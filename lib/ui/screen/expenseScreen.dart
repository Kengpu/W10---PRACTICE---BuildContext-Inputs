import 'package:flutter/material.dart';
import '../widgets/expenseList.dart';
import '../widgets/form.dart';
import '../../model/expense.dart';
import '../../data/fakeExpense.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Expense> _userExpenses = fakeExpenses;

  void removeExpense(String id, BuildContext context) {
    // 1. Find the expense to remove
    final expenseIndex = _userExpenses.indexWhere((e) => e.id == id);
    if (expenseIndex == -1) return; // safety check
    final removedExpense = _userExpenses[expenseIndex];

    // 2. Remove it from list
    setState(() {
      _userExpenses.removeAt(expenseIndex);
    });

    // 3. Clear any previous snackbar
    ScaffoldMessenger.of(context).clearSnackBars();

    // 4. Show new snackbar with Undo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${removedExpense.title} deleted."),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _userExpenses.insert(expenseIndex, removedExpense);
            });
          },
        ),
      ),
    );
  }

  void openAddExpenseModal(BuildContext context) async {
    final expense = await showModalBottomSheet(
      context: context,
      isScrollControlled: true, // better for keyboard
      builder: (_) => ExpenseForm(),
    );

    if (expense != null) {
      getUserInputs(
        expense['title'],
        expense['amount'],
        expense['category'],
        expense['date'],
      );
    } else {
      print('No expense added');
    }
  }

  void getUserInputs(
      String title, double amount, ExpenseCategory category, DateTime date) {
    final newExpense =
        Expense(title: title, amount: amount, category: category, date: date);
    setState(() {
      _userExpenses.add(newExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Expense App"),
          backgroundColor: Colors.blue,
          actions: [
            Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => openAddExpenseModal(ctx),
              ),
            ),
          ],
        ),
        body: Builder(
          builder: (scaffoldCtx) => Container(
            color: Colors.blue[200],
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: _userExpenses.isEmpty
                ? Center(
                    child: Text(
                      "No expenses added yet!",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  )
                : ExpenseList(
                    expenses: _userExpenses,
                    onRemove: (id) => removeExpense(id, scaffoldCtx),
                  ),
          ),
        ),
      ),
    );
  }
}