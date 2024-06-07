import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabu/Materials/buttons.dart';
import 'package:tabu/Materials/sizedBoxes.dart';
import 'package:tabu/scorePage.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  var rnd = Random();
  late int _index;
  late double _timeLeft;
  Timer? _timer;
  late String _teamAName;
  late String _teamBName;
  int _teamAScore = 0;
  int _teamBScore = 0;
  int _score = 0;
  double _tabooMinusPoint = 1;
  late int passCount;
  late dynamic _currentWord;
  List<String> _generatedValues = [];
  bool _isRunning = true;
  bool isButtonDisabled = false;
  dynamic _words = [];
  bool _isFirstTeam = true;

  @override
  void initState() {
    super.initState();
    _loadJsonAsset();
    _loadTimeValue();
    _startTimer();
    _loadTeamAName();
    _loadTeamBName();
    _loadPassCount();
    _loadIsFirstTeam();
    _loadTeamAScore();
    _loadTeamBScore();
    _loadTabooMinusPoint();
    _loadGeneratedValues();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
        _setIsFirstTeam(_isFirstTeam);
        _isFirstTeam ? _setTeamAScore(_score) : _setTeamBScore(_score);
        _setGeneratedValues(_generatedValues);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScorePage()),
        );
      }
      setState(() {
        _isRunning = true;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _toggleTimer() {
    if (_isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _randomNumber() {
    _index = rnd.nextInt(_words.length);

    while (_generatedValues.contains(_index.toString())) {
      _index = rnd.nextInt(_words.length);
    }
    _generatedValues.add(_index.toString());
    _setCurrentWord();
  }

  void _setCurrentWord() {
    setState(() {
      _currentWord = _words[_index];
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _loadTimeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _timeLeft = (prefs.getDouble('timeValue') ?? 60);
    });
  }

  _loadTeamAName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _teamAName = (prefs.getString('teamAName') ?? "Team A");
    });
  }

  _loadTeamBName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _teamBName = (prefs.getString('teamBName') ?? "Team B");
    });
  }

  _loadPassCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      passCount = (prefs.getInt('passCount') ?? 3);
    });
  }

  _setTeamAScore(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('teamAScore', score + _teamAScore);
  }

  _setTeamBScore(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('teamBScore', score + _teamBScore);
  }

  _loadTeamAScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _teamAScore = (prefs.getInt('teamAScore') ?? 0);
    });
  }

  _loadTeamBScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _teamBScore = (prefs.getInt('teamBScore') ?? 0);
    });
  }

  _loadIsFirstTeam() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirstTeam = (prefs.getBool('isFirstTeam') ?? true);
    });
  }

  _setIsFirstTeam(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTeam', !_isFirstTeam);
  }

  _loadTabooMinusPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tabooMinusPoint = (prefs.getDouble('tabooMinusPoint') ?? 1);
    });
  }

  _setGeneratedValues(List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('generatedValues', _generatedValues);
  }

  _loadGeneratedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _generatedValues = (prefs.getStringList('generatedValues') ?? []);
    });
    print(_generatedValues);
  }

  Future<void> _loadJsonAsset() async {
    final String words = await rootBundle.loadString('lib/assets/words.json');
    setState(() {
      _words = jsonDecode(words);
    });
    _randomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tabu"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
      ),
      body: PopScope(
        canPop: false,
        child: _words != null
            ? Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Buttons().iconButton(
                            height: 50,
                            width: 50,
                            radius: 5,
                            icon: Icon(Icons.pause_circle),
                            onPressedFunction: _toggleTimer,
                          ),
                          Text(
                            _timeLeft.toInt().toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 24,
                              color:
                                  _timeLeft >= 11 ? Colors.black : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _isFirstTeam ? _teamAName : _teamBName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 24,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _currentWord['word'],
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                            SizedBoxes().verticalSizedBox(verticalSize: 20),
                            Text(
                              _currentWord['forbidden_words'][0],
                              style: textStyle(),
                            ),
                            SizedBoxes().verticalSizedBox(verticalSize: 5),
                            Text(
                              _currentWord['forbidden_words'][1],
                              style: textStyle(),
                            ),
                            SizedBoxes().verticalSizedBox(verticalSize: 5),
                            Text(
                              _currentWord['forbidden_words'][2],
                              style: textStyle(),
                            ),
                            SizedBoxes().verticalSizedBox(verticalSize: 5),
                            Text(
                              _currentWord['forbidden_words'][3],
                              style: textStyle(),
                            ),
                            SizedBoxes().verticalSizedBox(verticalSize: 5),
                            Text(
                              _currentWord['forbidden_words'][4],
                              style: textStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Pas Hakkı: ${passCount.toString()}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Buttons().iconButton(
                                height: 50,
                                width: 100,
                                radius: 5,
                                icon: const Icon(Icons.close),
                                onPressedFunction: () {
                                  if (!isButtonDisabled) {
                                    setState(() {
                                      passCount--;
                                      _randomNumber();
                                      if (passCount == 0) {
                                        isButtonDisabled = true;
                                      }
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                          Buttons().smallButton(
                            text: "Tabu",
                            height: 60,
                            width: 60,
                            radius: 5,
                            onPressedFunction: () {
                              setState(() {
                                _score -= _tabooMinusPoint.toInt();
                                _randomNumber();
                              });
                            },
                          ),
                          Column(
                            children: [
                              Text(
                                "Skor: ${_score.toString()}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Buttons().iconButton(
                                height: 50,
                                width: 100,
                                radius: 5,
                                icon: Icon(Icons.check),
                                onPressedFunction: () {
                                  setState(() {
                                    _score++;
                                    _randomNumber();
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.red,
    );
  }
}
