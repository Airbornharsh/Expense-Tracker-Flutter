import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/Chart_bar.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {super.key});

  List<Map<String, Object>> get getGroupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return getGroupTransactionValues.fold(0.0, (sum, item) {
      return sum + (item["amount"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Container(
        height: 120,
        decoration: const BoxDecoration(color: Colors.white),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...(getGroupTransactionValues).map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(data["day"] as String,
                      data["amount"] as double, totalSpending),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
