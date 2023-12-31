import 'package:despesas_pessoais/components/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:despesas_pessoais/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                SizedBox(
                  height: 20,
                  child: Text(
                    'Nenhuma transação cadastrada',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return TransactionItem(
                //key: ValueKey(tr.id), //Não funciona com ListView.builder, GlobalObjectKey não é recomendado mas é a unica saída para esse caso, pois provavelmente é um Bug do Flutter usar o ValueKey com ListView.builder
                key: GlobalObjectKey(tr),
                tr: tr,
                onRemove: onRemove,
              );
            },
          );
    //Sem usar o ListView.builder (recomendado somente se a lista for pequena)
    //ListView(
    //    children: transactions.map((tr) {
    //      return TransactionItem(
    //        key: ValueKey(tr.id),
    //        tr: tr,
    //        onRemove: onRemove,
    //      );
    //    }).toList(),
    //  );
  }
}
