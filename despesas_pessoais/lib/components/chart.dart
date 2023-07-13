import 'package:despesas_pessoais/components/chart_bar.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.00;

      //FOR
      /*for (var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }*/

      //FOR IN
      /*for (var transaction in recentTransactions) {
        bool sameDay = transaction.date.day == weekDay.day;
        bool sameMonth = transaction.date.month == weekDay.month;
        bool sameYear = transaction.date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += transaction.value;
        }
      }*/

      //WHERE, MAP e FOLD
      totalSum = recentTransactions
          .where((e) =>
              (e.date.day == weekDay.day) &&
              (e.date.month == weekDay.month) &&
              (e.date.year == weekDay.year))
          .map((tr) => tr.value)
          .fold(0.0, (t, a) => t + a);

      return {
        'day': DateFormat.E().format(
            weekDay)[0], //DateFormat.E(): retorna a sigla do dia da semana
        'value': totalSum,
      };
    }).reversed.toList();
  }

  const Chart(this.recentTransactions, {super.key});

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'].toString(),
                value: (tr['value'] as double),
                percentage: (_weekTotalValue == 0
                    ? 0
                    : (tr['value'] as double) / _weekTotalValue),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
