import 'package:expense/transaction.dart';
import 'package:expense/widgets/ChartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekday.day &&
            recentTransaction[i].date.month == weekday.month &&
            recentTransaction[i].date.year == weekday.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekday).substring(0,1), 'amount': totalSum};
    }).reversed.toList();
  }
  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (previousValue, element) => previousValue+(element['amount'] as double));
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ChartBar(data['day'] as String, 
            data['amount'] as double, 
            totalSpending==0.0?0.0: (data['amount'] as double)/totalSpending ),
          );
        }).toList()),
      ),
    );
  }
}
