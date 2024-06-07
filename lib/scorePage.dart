import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabu/Materials/appTheme.dart';
import 'package:tabu/Materials/buttons.dart';
import 'package:tabu/Materials/sizedBoxes.dart';
import 'package:tabu/gamePage.dart';
import 'package:tabu/gameStartPage.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  late int _teamAScore;
  late int _teamBScore;
  late String _teamAName;
  late String _teamBName;
  late double _pointToWin;

  @override
  void initState() {
    super.initState();
    _loadTeamAScore();
    _loadTeamBScore();
    _loadTeamAName();
    _loadTeamBName();
    _loadPointToWin();
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

  _loadPointToWin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _pointToWin = (prefs.getDouble('pointToWin') ?? 50);
    });
  }

  _setGeneratedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('generatedValues', []);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skor Durumu"),
        backgroundColor: AppTheme().lightTheme().colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
      ),
      body: PopScope(
        canPop: false,
        child: Center(
          child: Column(
            children: [
              SizedBoxes().verticalSizedBox(verticalSize: screenWidth * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        _teamAName.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _teamAScore.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBoxes()
                      .verticalSizedBox(verticalSize: screenWidth * 0.2),
                  Column(
                    children: [
                      Text(
                        _teamBName.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _teamBScore.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _teamAScore >= _pointToWin
                  ? Text(
                      _teamAName.toString() + " takımı kazandı!",
                      style: const TextStyle(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(""),
              SizedBoxes().verticalSizedBox(verticalSize: screenWidth * 0.05),
              _teamBScore >= _pointToWin
                  ? Text(
                      _teamBName.toString() + " takımı kazandı!",
                      style: const TextStyle(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(""),
              SizedBoxes().verticalSizedBox(verticalSize: screenWidth * 0.05),
              Buttons().smallButton(
                text: "Devam",
                height: 50,
                width: 50,
                radius: 5,
                onPressedFunction: () {
                  if (_teamAScore >= _pointToWin ||
                      _teamBScore >= _pointToWin) {
                    _setGeneratedValues();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const GameStartpage()),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const GamePage()),
                      ),
                    );
                  }
                },
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     if (_teamAScore >= _pointToWin || _teamBScore >= _pointToWin) {
              //       Navigator.pushReplacement(
              //         context,
              //         MaterialPageRoute(
              //           builder: ((context) => const GameStartpage()),
              //         ),
              //       );
              //     } else {
              //       Navigator.pushReplacement(
              //         context,
              //         MaterialPageRoute(
              //           builder: ((context) => const GamePage()),
              //         ),
              //       );
              //     }
              //   },
              //   child: const Text("Devam"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
