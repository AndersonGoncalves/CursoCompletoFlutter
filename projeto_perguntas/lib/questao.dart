import 'package:flutter/material.dart';

class Questao extends StatelessWidget {
  final String texto;

  const Questao(this.texto, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 28, color: Colors.blue),
        textAlign: TextAlign.center,
      ),
    );
  }
}