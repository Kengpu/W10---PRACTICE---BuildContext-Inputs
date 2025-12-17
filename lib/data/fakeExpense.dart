import "../model/expense.dart";

final List<Expense> fakeExpenses = [
  Expense(
    title: 'Groceries',
    amount: 54.99,
    date: DateTime.now().subtract(Duration(days: 1)),
    category: ExpenseCategory.food,
  ),
  Expense(
    title: 'Electricity Bill',
    amount: 75.50,
    date: DateTime.now().subtract(Duration(days: 3)),
    category: ExpenseCategory.utilities,
  ),
  Expense(
    title: 'Movie Tickets',
    amount: 30.00,
    date: DateTime.now().subtract(Duration(days: 2)),
    category: ExpenseCategory.entertainment,
  ),
  Expense(
    title: 'Gym Membership',
    amount: 45.00,
    date: DateTime.now().subtract(Duration(days: 5)),
    category: ExpenseCategory.other,
  ),
  Expense(
    title: 'Dining Out',
    amount: 60.25,
    date: DateTime.now().subtract(Duration(days: 4)),
    category: ExpenseCategory.food,
  ),
];