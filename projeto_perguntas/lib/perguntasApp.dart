import 'package:flutter/material.dart';
import './resultado.dart';
import './questionario.dart';

class PerguntasApp extends StatefulWidget {
  const PerguntasApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PerguntasAppState();
  }
}

class _PerguntasAppState extends State<PerguntasApp> {
  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;

  final List<Map<String, Object>> _perguntas = const [
    {
      'texto': 'Qual é a sua cor favorita?',
      'respostas': [
        {'texto': 'Preto', 'pontuacao': 10},
        {'texto': 'Vermelho', 'pontuacao': 9},
        {'texto': 'Verde', 'pontuacao': 7},
        {'texto': 'Branco', 'pontuacao': 8},
      ]
    },
    {
      'texto': 'Qual é o seu animal favorito?',
      'respostas': [
        {'texto': 'Coelho', 'pontuacao': 7},
        {'texto': 'Cobra', 'pontuacao': 1},
        {'texto': 'Elefante', 'pontuacao': 8},
        {'texto': 'Leão', 'pontuacao': 10},
      ]
    },
    {
      'texto': 'Qual é o seu carro favorito?',
      'respostas': [
        {'texto': 'Gol', 'pontuacao': 5},
        {'texto': 'Polo', 'pontuacao': 9},
        {'texto': 'Nivus', 'pontuacao': 10},
        {'texto': 'T-Cross', 'pontuacao': 10},
      ]
    }
  ];

  void _responder(int pontuacao) {
    if (temPerguntaSelecionada) {
      setState(() {
        _perguntaSelecionada++;
        _pontuacaoTotal += pontuacao;
      });
    }
  }

  void _reiniciar() {
    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
    });
  }

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    return temPerguntaSelecionada
        ? Questionario(
            perguntaSelecionada: _perguntaSelecionada,
            perguntas: _perguntas,
            responder: _responder,
          )
        : Resultado(_reiniciar, _pontuacaoTotal);
  }
}
