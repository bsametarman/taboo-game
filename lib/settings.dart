import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double _timeValue = 60;
  double _passCount = 3;
  double _tabooMinusPoint = 1;
  double _pointToWin = 50;

  @override
  void initState() {
    super.initState();
    _loadTimeValue();
    _loadPassCount();
    _loadTabooMinusPoint();
    _loadPointToWin();
  }

  _loadTimeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _timeValue = (prefs.getDouble('timeValue') ?? 60);
    });
  }

  _saveTimeValue(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('timeValue', value);
  }

  _loadPassCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _passCount = (prefs.getDouble('passCount') ?? 3);
    });
  }

  _savePassCount(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('passCount', value);
  }

  _loadTabooMinusPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tabooMinusPoint = (prefs.getDouble('tabooMinusPoint') ?? 1);
    });
  }

  _saveTabooMinusPoint(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('tabooMinusPoint', value);
  }

  _loadPointToWin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _pointToWin = (prefs.getDouble('pointToWin') ?? 50);
    });
  }

  _savePointToWin(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('pointToWin', value);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Süre",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.8,
                  child: Slider(
                    value: _timeValue,
                    min: 15,
                    max: 180,
                    divisions: 11,
                    label: _timeValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _timeValue = value;
                        _saveTimeValue(value);
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${_timeValue.toString()} sn",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Text(
              "Pas Hakkı ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.8,
                  child: Slider(
                    value: _passCount,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: _passCount.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _passCount = value;
                        _savePassCount(value);
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  _passCount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Text(
              "Tabu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.8,
                  child: Slider(
                    value: _tabooMinusPoint,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: _tabooMinusPoint.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _tabooMinusPoint = value;
                        _saveTabooMinusPoint(value);
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  _tabooMinusPoint.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Text(
              "Kazanma Puanı",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.8,
                  child: Slider(
                    value: _pointToWin,
                    min: 30,
                    max: 300,
                    divisions: 9,
                    label: _pointToWin.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _pointToWin = value;
                        _savePointToWin(value);
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  _pointToWin.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
