import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final void Function() reiniciar;

  const Resultado(this.reiniciar, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        onPressed: reiniciar,
        child: const Text('Reiniciar'),
      ),
    );
  }
}
