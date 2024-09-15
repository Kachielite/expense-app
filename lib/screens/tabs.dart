import 'package:daily_expense/screens/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../Widgets/new_expense/new_expense.dart';
import '../data/my_expenses.dart';
import '../model/expense_model.dart';
import 'home.dart'; // Make sure you have corresponding widgets for each tab

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0; // Track the selected index

  final List<ExpenseModel> expenseList = myExpenses;
  late List<ExpenseModel> filteredExpense;
  late List<PieChartSectionData> chartData;

  String activeFilter = 'INCOME';
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

  // Function to update the selected index when a tab is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // A list of widgets corresponding to each tab
    final List<Widget> pages = [
      Home(
        onAdd: onAdd,
        activeFilter: activeFilter,
        onEdit: onEdit,
        onDelete: onDelete,
      ), // Home widget
      ExpressScreen(
        onEdit: onEdit,
        onDelete: onDelete,
        onSelectExpenseType: onSelectExpenseType,
        activeFilter: activeFilter,
      ), // Add your widget for Expense
      const Text('Wallet Screen'),
      NewExpense(onSave,
          mode:
              'New') // Add your widget for Wallet// Add your widget for the new tab
    ];
    return Scaffold(
      body: pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        currentIndex: _selectedIndex, // Set the selected index
        onTap: _onItemTapped, // Handle taps on tabs
        backgroundColor: const Color.fromRGBO(16, 38, 50, 1),
        type: BottomNavigationBarType.fixed, // Add this line for 4+ items
        selectedItemColor:
            Colors.white, // Optionally set the selected item color
        unselectedItemColor:
            Colors.grey, // Optionally set the unselected item color
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.area_chart_sharp), label: 'Expense'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: 'Wallet'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: 'Add'),
        ],
      ),
    );
  }
}
