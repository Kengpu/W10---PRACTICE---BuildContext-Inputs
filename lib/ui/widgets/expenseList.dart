import 'package:flutter/material.dart';
import '../../model/expense.dart';
import '../../data/fakeExpense.dart';
import './expenseCard.dart';
class ExpenseList extends StatelessWidget {
  final List<Expense> expenses ;
  final void Function(String id) onRemove;

  const ExpenseList({required this.expenses, required this.onRemove, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return Dismissible(
          key: Key(expense.id),
          onDismissed: (_) {
            onRemove(expense.id);
          },
          child: Container(
            margin : EdgeInsets.symmetric(vertical: 6),
            child: ExpenseCard(expense: expense)),
        );
      },
    );
  }
}