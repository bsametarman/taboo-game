import 'package:flutter/material.dart';
import 'package:tabu/Materials/appTheme.dart';
import 'package:tabu/Materials/sizedBoxes.dart';

class HowToPlayPage extends StatelessWidget {
  const HowToPlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nasıl Oynanır?"),
        backgroundColor: AppTheme().lightTheme().colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Tabu, 2 takım halinde oynanan bir kelime oyunudur.\nOyunun amacı, belirli bir süre içinde takım arkadaşlarına mümkün olduğunca çok sayıda kelimeyi anlatmaktır,\nancak anlatıcı kelimeyi tarif ederken bazı yasaklı (tabu) kelimeleri kullanamaz.\nKazanma sayısına ilk erişen takım oyunu kazanır.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBoxes().verticalSizedBox(),
            const Text(
              "Coded by bsametarman\ngithub.com/bsametarman",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
