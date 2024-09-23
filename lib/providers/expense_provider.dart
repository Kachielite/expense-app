import 'package:daily_expense/data/my_expenses.dart';
import 'package:daily_expense/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Widgets/new_expense/new_expense.dart';
import '../enums/expense_type.dart';

class ExpenseNotifier extends StateNotifier<List<ExpenseModel>> {
  ExpenseNotifier() : super(myExpenses);

  List<ExpenseModel> filterExpenseType(activeFilter) {
    if (activeFilter == "INCOME") {
      return [...state].where((e) => e.type == ExpenseType.income).toList();
    } else {
      return [...state].where((e) => e.type == ExpenseType.expense).toList();
    }
  }

  void onSave(ExpenseModel expense) {
    state = [expense, ...state];
  }

  void onUpdate(ExpenseModel expense) {
    List<ExpenseModel> expensesToBeUpdated = [...state];
    int expenseIndex = expensesToBeUpdated.indexOf(expense);
    print(expense.title);
    print(expenseIndex);
    expensesToBeUpdated.removeAt(expenseIndex);
    expensesToBeUpdated.insert(expenseIndex, expense);

    state = expensesToBeUpdated;
  }

  void onDelete(ExpenseModel expense, BuildContext context) {
    List<ExpenseModel> expensesToBeUpdated = state;

    expensesToBeUpdated.remove(expense);

    state = expensesToBeUpdated;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text(
        "Item deleted",
        style: TextStyle(color: Colors.white),
      ),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            onUpdate(expense);
          }),
    ));
  }

  void onAdd(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => const NewExpense(
              mode: 'new',
            ));
  }

  void onEdit(ExpenseModel expense, BuildContext context) {
    // List<ExpenseModel> expensesToBeUpdated = state;
    // int expenseIndex = expensesToBeUpdated.indexOf(expense);
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              mode: 'edit',
              expense: expense,
            ));
  }
}

final expenseProvider =
    StateNotifierProvider<ExpenseNotifier, List<ExpenseModel>>((ref) {
  return ExpenseNotifier();
});
