import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final void Function() reiniciar;
  final int pontuacao;

  const Resultado(this.reiniciar, this.pontuacao, {super.key});

  String get fraseResultado {
    if (pontuacao < 8) {
      return 'Parabéns';
    } else if (pontuacao < 12) {
      return 'Você é bom';
    } else if (pontuacao < 15) {
      return 'Você se garante';
    } else {
      return 'Impressionante';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            fraseResultado,
            style: const TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: reiniciar,
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
  }
}
