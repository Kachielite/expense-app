import 'package:daily_expense/screens/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/expense_model.dart';
import 'history.dart';
import 'home.dart';
import 'new_expense.dart'; // Make sure you have corresponding widgets for each tab

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0; // Track the selected index

  late List<ExpenseModel> filteredExpense;
  late List<PieChartSectionData> chartData;

  String activeFilter = 'EXPENSE';
  late int expenseIndex;
  void onSelectExpenseType(String type) {
    setState(() {
      activeFilter = type;
    });
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
        activeFilter: activeFilter,
        onItemTapped: _onItemTapped,
      ), // Home widget
      ExpressScreen(
        onSelectExpenseType: onSelectExpenseType,
        activeFilter: activeFilter,
      ), // Add your widget for Expense
      const HistoryScreen(),
      NewExpenseScreen(
        onItemTapped: _onItemTapped,
      ) // Add your widget for Wallet// Add your widget for the new tab
    ];

    return Scaffold(
      body: pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: false,
        elevation: 0.0,
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
              icon: Icon(Icons.history_outlined), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: 'Add'),
        ],
      ),
    );
  }
}
