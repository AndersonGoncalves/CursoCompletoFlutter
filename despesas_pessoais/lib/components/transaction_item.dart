import 'dart:math';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.tr,
    required this.onRemove,
  });

  final Transaction tr;
  final void Function(String p1) onRemove;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];

  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(5);
    _backgroundColor = colors.elementAt(i);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        /*Substituindo o container por CircleAvatar
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary,
          ),
          height: 60,
          width: 60,
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: FittedBox(
              child: Text(
                'R\$${tr.value}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        */
        leading: CircleAvatar(
          radius: 30,
          backgroundColor:
              _backgroundColor, //Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: FittedBox(
              child: Text(
                'R\$${widget.tr.value}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          DateFormat('dd MMM y').format(widget.tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () => widget.onRemove(widget.tr.id),
                icon: Icon(Icons.delete,
                    color: Theme.of(context).colorScheme.error),
                label: Text(
                  'Excluir',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () => widget.onRemove(widget.tr.id),
              ),
      ),
      //Trocado pelo Widget ListTile
      //        Card(
      //          child: Row(
      //            children: <Widget>[
      //              Container(
      //                margin: const EdgeInsets.symmetric(
      //                  horizontal: 15,
      //                  vertical: 10,
      //                ),
      //                decoration: BoxDecoration(
      //                  border: Border.all(
      //                    color: Theme.of(context)
      //                        .colorScheme
      //                        .primary, //ou Theme.of(context).primaryColor,
      //                    width: 2,
      //                  ),
      //                ),
      //                padding: const EdgeInsets.all(10),
      //                child: Text(
      //                  'R\$ ${tr.value.toStringAsFixed(2)}',
      //                  style: TextStyle(
      //                    fontWeight: FontWeight.bold,
      //                    fontSize: 20,
      //                    color: Theme.of(context)
      //                        .colorScheme
      //                        .primary, //ou Theme.of(context).primaryColor,
      //                 ),
      //                ),
      //              ),
      //              Column(
      //                crossAxisAlignment: CrossAxisAlignment.start,
      //                children: <Widget>[
      //                  Text(
      //                    tr.title,
      //                    style: Theme.of(context)
      //                        .textTheme
      //                        .titleLarge, //Pegar o thema do textTheme, headline6 foi deprecado, usar titleLarge
      //                    //style: const TextStyle(
      //                    //  fontSize: 16,
      //                    //  fontWeight: FontWeight.bold,
      //                    //),
      //                  ),
      //                  Text(
      //                    DateFormat('dd MMM y').format(tr.date),
      //                    style: const TextStyle(
      //                      color: Colors.grey,
      //                    ),
      //                  )
      //                ],
      //              )
      //            ],
      //          ),
      //       );
    );
  }
}
