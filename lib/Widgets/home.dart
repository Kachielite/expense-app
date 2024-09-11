import 'package:daily_expense/Widgets/chart/chart_container.dart';
import 'package:daily_expense/Widgets/expense/expense_items.dart';
import 'package:daily_expense/Widgets/new_expense/new_expense.dart';
import 'package:daily_expense/Widgets/total_expense/total_expense.dart';
import 'package:daily_expense/data/my_expenses.dart';
import 'package:daily_expense/model/expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../enums/expense_type.dart';
import 'expense_switch/expense_toggle_buttons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final List<ExpenseModel> expenseList = myExpenses;
  late List<ExpenseModel> filteredExpense;
  late List<PieChartSectionData> chartData;

  String activeFilter = 'ALL';
  late int expenseIndex;

  void onSelectExpenseType(String type) {
    setState(() {
      activeFilter = type;
    });
  }

  void onSave(ExpenseModel expense) {
    setState(() {
      myExpenses.insert(0, expense);
    });
  }

  void onUpdate(ExpenseModel expense) {
    expenseList.removeAt(expenseIndex);
    setState(() {
      myExpenses.insert(expenseIndex, expense);
    });
  }

  void onAdd() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onSave,
              mode: 'new',
            ));
  }

  void onEdit(ExpenseModel expense) {
    expenseIndex = myExpenses.indexOf(expense);
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onUpdate,
              mode: 'edit',
              expense: expense,
            ));
  }

  void onDelete(ExpenseModel expense) {
    int expenseIndex = expenseList.indexOf(expense);

    setState(() {
      expenseList.remove(expense);
    });

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
            setState(() {
              expenseList.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(context) {
    List<ExpenseModel> incomeExpensesType = myExpenses
        .where((expense) => expense.type == ExpenseType.income)
        .toList();

    List<ExpenseModel> expenseExpenseType = myExpenses
        .where((expense) => expense.type == ExpenseType.expense)
        .toList();

    double totalIncome = incomeExpensesType
        .map((expense) => expense.amount)
        .reduce((a, b) => a + b);

    double totalExpense = expenseExpenseType
        .map((expense) => expense.amount)
        .reduce((a, b) => a + b);

    final String balance = (totalIncome - totalExpense).toStringAsFixed(2);

    if (activeFilter == 'ALL') {
      filteredExpense = expenseList;
    } else if (activeFilter == 'INCOME') {
      filteredExpense =
          expenseList.where((e) => e.type == ExpenseType.income).toList();
    } else {
      filteredExpense =
          expenseList.where((e) => e.type == ExpenseType.expense).toList();
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(16, 38, 50, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(16, 38, 50, 1),
        title: const Text('Daily Expense Tracker',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(foregroundColor: Colors.white),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
        child: Column(
          children: [
            TotalExpense(balance),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ChartContainer(
                filter: activeFilter,
                incomeType: incomeExpensesType,
                expenseType: expenseExpenseType,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ExpenseToggleButtons(onSelectExpenseType),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: ExpenseItems(
              filteredExpense,
              onDelete: onDelete,
              onEdit: onEdit,
            ))
          ],
        ),
      ),
    );
  }
}
