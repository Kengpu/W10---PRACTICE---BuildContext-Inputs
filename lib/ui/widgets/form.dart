import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  ExpenseCategory selectedCategory = ExpenseCategory.food;
  DateTime? selectedDate;

  void onCreate() {
    Navigator.pop(context, {
      'title': _titleController.text,
      'amount': double.parse(_amountController.text),
      'category': selectedCategory,
      'date': selectedDate ?? DateTime.now(),
    });
  }

  void onCancel() => Navigator.pop(context);

  String get formattedDate =>
      selectedDate == null
          ? 'Select date'
          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';

  void selectDate(BuildContext context) async {
    final pickDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );

    if (pickDate != null) {
      setState(() => selectedDate = pickDate);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              /// Title
              Text(
                "Add New Expense",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              /// Title Input
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
                maxLength: 50,
              ),

              const SizedBox(height: 12),

              /// Amount + Date
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      decoration: const InputDecoration(
                        labelText: "Amount",
                        prefixText: "\$ ",
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () => selectDate(context),
                    icon: const Icon(Icons.calendar_today),
                    label: Text(formattedDate),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Category
              DropdownButtonFormField<ExpenseCategory>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
                items: ExpenseCategory.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedCategory = value!);
                },
              ),

              const SizedBox(height: 24),

              /// Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel,
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onCreate,
                      child: const Text("Create"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
