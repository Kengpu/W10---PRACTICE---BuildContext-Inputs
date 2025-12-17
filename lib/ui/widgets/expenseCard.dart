import 'package:flutter/material.dart';
import '../../model/expense.dart';
import 'package:intl/intl.dart';
class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({super.key, required this.expense});

  Icon get categoryIcon {
    switch (expense.category) {
      case ExpenseCategory.food:
        return Icon(Icons.fastfood);
      case ExpenseCategory.utilities:
        return Icon(Icons.lightbulb);
      case ExpenseCategory.entertainment:
        return Icon(Icons.movie);
      case ExpenseCategory.other:
      default:
        return Icon(Icons.miscellaneous_services);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding : EdgeInsets.all(8),
      child: ListTile(
        title: Text(expense.title),
        subtitle: Text("${expense.amount.toStringAsFixed(2)} USD"),
        trailing: SizedBox(
          width: 120,
          child: Row(
            children : [
              categoryIcon,
              SizedBox(width: 10),
              Text(DateFormat.yMd().format(expense.date))
            ]
          ),
        )
      ),
    );
  }
}