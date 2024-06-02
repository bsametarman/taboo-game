import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabu/Materials/buttons.dart';
import 'package:tabu/Materials/sizedBoxes.dart';
import 'package:tabu/Materials/textFields.dart';

class GameStartpage extends StatefulWidget {
  const GameStartpage({super.key});

  @override
  State<GameStartpage> createState() => _GameStartpageState();
}

class _GameStartpageState extends State<GameStartpage> {
  String _teamAName = "";
  String _teamBName = "";

  @override
  void initState() {
    super.initState();
    _loadTeamAName();
    _loadTeamBName();
  }

  _loadTeamAName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _teamAName = (prefs.getString('teamAName') ?? "Team A");
    });
  }

  _saveTeamANameValue(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('teamAName', value);
  }

  _loadTeamBName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _teamBName = (prefs.getString('teamBName') ?? "Team B");
    });
  }

  _saveTeamBNameValue(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('teamBName', value);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Takım Seç"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: screenWidth * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "1. Takım",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBoxes().verticalSizedBox(),
              TextFields().textField(
                text: "1. Takım Adı",
                onChanged: (value) {
                  setState(() {
                    _teamAName = value;
                    _saveTeamANameValue(value);
                  });
                },
              ),
              //Text(_teamAName),
              SizedBoxes().verticalSizedBox(),
              const Text(
                "2. Takım",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBoxes().verticalSizedBox(),
              TextFields().textField(
                text: "2. Takım Adı",
                onChanged: (value) {
                  setState(() {
                    _teamBName = value;
                    _saveTeamBNameValue(value);
                  });
                },
              ),
              //Text(_teamBName),
              SizedBoxes().verticalSizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Buttons().smallButton(
                      text: "Geri",
                      height: 50,
                      width: 50,
                      radius: 5,
                      onPressedFunction: () {
                        Navigator.pop(context);
                      }),
                  SizedBoxes().horizontalSizedBox(),
                  Buttons().smallButton(
                      text: "Başla",
                      height: 50,
                      width: 50,
                      radius: 5,
                      onPressedFunction: () {}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
