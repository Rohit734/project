import 'package:flutter/material.dart';
import 'chart_bar.dart';
import '../data/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  // returns a list of dictionary containing string and object(value) (List<Map<String, Object>>) we call it as Object because we have diffrent Types of value

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      //DateTime.now().subtract(Duration(days: index)); returns current day - index which is today - 0 = today and today -1 = yesterday

      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalCost = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekday.day &&
            recentTransaction[i].date.month == weekday.month &&
            recentTransaction[i].date.year == weekday.year) {
          totalCost += recentTransaction[i].amount;
        }
      }
      //print(DateFormat.E(weekday.day).toString());
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalCost
      };
    }).reversed.toList();
  }

  double get percentage {
    return groupTransactionValues.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  percentage == 0.0
                      ? 0.0
                      : (data['amount'] as double) / percentage),
            );
          }).toList(),
        ),
      ),
    );
  }
}
