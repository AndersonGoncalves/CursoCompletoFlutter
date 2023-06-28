import 'package:flutter/material.dart';
import './resultado.dart';
import './questionario.dart';

//O Imperativo tem o foco no COMO, em explicar como deve ser feito,
//já o Declarativo ele foca no O QUE precisa ser feito, o 'como' ele deixa
//para linguagem resolver. O Imperativo tem uma maior quantidade de código,
//pois você precisa explicar exatamente o fluxo de funcionamento,
//no Declarativo há uma menor quantidade.

main() => runApp(const PerguntaApp());

class PerguntaApp extends StatefulWidget {
  const PerguntaApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PerguntaAppState();
  }
}

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;

  final List<Map<String, Object>> _perguntas = const [
    {
      'texto': 'Qual é a sua cor favorita?',
      'respostas': [
        {'texto': 'Preto', 'nota': 10},
        {'texto': 'Vermelho', 'nota': 9},
        {'texto': 'Verde', 'nota': 7},
        {'texto': 'Branco', 'nota': 8},
      ]
    },
    {
      'texto': 'Qual é o seu animal favorito?',
      'respostas': [
        {'texto': 'Coelho', 'nota': 7},
        {'texto': 'Cobra', 'nota': 1},
        {'texto': 'Elefante', 'nota': 8},
        {'texto': 'Leão', 'nota': 10},
      ]
    },
    {
      'texto': 'Qual é o seu carro favorito?',
      'respostas': [
        {'texto': 'Gol', 'nota': 5},
        {'texto': 'Polo', 'nota': 9},
        {'texto': 'Nivus', 'nota': 10},
        {'texto': 'T-Cross', 'nota': 10},
      ]
    }
  ];

  void _responder() {
    if (temPerguntaSelecionada) {
      setState(() {
        _perguntaSelecionada++;
      });
    }
  }

  void _reiniciar() {
    setState(() {
      _perguntaSelecionada = 0;
    });
  }

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Perguntas',
          ),
        ),
        body: temPerguntaSelecionada
            ? Questionario(
                perguntaSelecionada: _perguntaSelecionada,
                perguntas: _perguntas,
                responder: _responder,
              )
            : Resultado(_reiniciar),
      ),
    );
  }
}
