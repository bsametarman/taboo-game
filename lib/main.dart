import 'package:flutter/material.dart';
import 'package:tabu/Materials/Buttons.dart';
import 'package:tabu/Materials/appTheme.dart';
import 'package:tabu/Materials/sizedBoxes.dart';
import 'package:tabu/gameStartPage.dart';
import 'package:tabu/howToPlayPage.dart';
import 'package:tabu/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabu',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightTheme(),
      home: const MyHomePage(title: 'Tabu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Buttons().mainPageButton(
                    text: "Oyna",
                    radius: 5,
                    width: screenWidth * 0.15,
                    height: screenWidth * 0.15,
                    onPressedFunction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GameStartpage()));
                    }),
                const SizedBox(
                  width: 10,
                ),
                Buttons().mainPageButton(
                  text: "Ayarlar",
                  radius: 5,
                  width: screenWidth * 0.15,
                  height: screenWidth * 0.15,
                  onPressedFunction: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Settings()));
                  },
                ),
              ],
            ),
            SizedBoxes().verticalSizedBox(),
            Buttons().mainPageButton(
              text: "Nasıl Oynanır?",
              width: screenWidth * 0.3,
              height: screenWidth * 0.1,
              onPressedFunction: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HowToPlayPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
