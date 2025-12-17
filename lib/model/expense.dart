import 'package:uuid/uuid.dart';

const uuid = Uuid();
enum ExpenseCategory {
  food,
  travel,
  entertainment,
  utilities,
  study,
  other,
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();   

  Expense.defaultExpense(this.title, this.amount,this.category)
      : id = uuid.v4(),
        date = DateTime.now();
}