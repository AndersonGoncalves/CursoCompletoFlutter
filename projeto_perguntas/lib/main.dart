import 'package:flutter/material.dart';
import './perguntasApp.dart';

main() => runApp(const MyAppPerguntas());

class MyAppPerguntas extends StatelessWidget {
  const MyAppPerguntas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Perguntas',
          ),
        ),
        body: const PerguntasApp(),
      ),
    );
  }
}
