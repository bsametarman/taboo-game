import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabu/Materials/buttons.dart';
import 'package:tabu/Materials/sizedBoxes.dart';

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
  late dynamic _currentWord;
  bool _isRunning = true;
  dynamic _words = [];
  bool isFirstTeam = true;

  @override
  void initState() {
    super.initState();
    _loadJsonAsset();
    _loadTimeValue();
    _startTimer();
    _loadTeamAName();
    _loadTeamBName();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer?.cancel();
        isFirstTeam = !isFirstTeam;
        Navigator.pop(context);
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
                            _timeLeft.toString(),
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
                      isFirstTeam ? _teamAName : _teamBName,
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
                          Buttons().iconButton(
                            height: 50,
                            width: 100,
                            radius: 5,
                            icon: Icon(Icons.close),
                            onPressedFunction: _randomNumber,
                          ),
                          Buttons().smallButton(
                            text: "Tabu",
                            height: 50,
                            width: 50,
                            radius: 5,
                            onPressedFunction: _randomNumber,
                          ),
                          Buttons().iconButton(
                            height: 50,
                            width: 100,
                            radius: 5,
                            icon: Icon(Icons.check),
                            onPressedFunction: _randomNumber,
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
