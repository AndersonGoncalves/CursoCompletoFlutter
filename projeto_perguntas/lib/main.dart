import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

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

  void _responder() {
    setState(() {
      _perguntaSelecionada++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> perguntas = [
      {
        'texto': 'Qual é a sua cor favorita?',
        'respostas': ['Preto', 'Vermelho', 'Verde', 'Branco']
      },
      {
        'texto': 'Qual é o seu animal favorito?',
        'respostas': ['Coelho', 'Cobra', 'Elefante', 'Leão']
      },
      {
        'texto': 'Qual é o seu carro favorito?',
        'respostas': ['Gol', 'Polo', 'Nivus', 'T-Cross']
      }
    ];

    /*Forma Imperativa (Como fazer)
    List<Widget> respostas = [];
    for (String textoResp
        in perguntas[_perguntaSelecionada]['respostas'] as List) {
      respostas.add(Resposta(textoResp, _responder));
    }*/

    //Forma Declarativa (O que fazer)
    List<String> respostas =
        perguntas[_perguntaSelecionada]['respostas'] as List<String>;
    List<Widget> widgetsRespostas =
        respostas.map((t) => Resposta(t, _responder)).toList();
    //

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Perguntas',
          ),
        ),
        body: Column(
          children: <Widget>[
            Questao(
                perguntas.elementAt(_perguntaSelecionada)['texto'] as String),
            ...widgetsRespostas,
          ],
        ),
      ),
    );
  }
}
