import 'package:flutter/material.dart';

import '../Widgets/home.dart'; // Make sure you have corresponding widgets for each tab

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0; // Track the selected index

  // A list of widgets corresponding to each tab
  final List<Widget> _pages = [
    const Home(), // Home widget
    const Text('Expense Screen'), // Add your widget for Expense
    const Text(
        'Wallet Screen'), // Add your widget for Wallet// Add your widget for the new tab
  ];

  // Function to update the selected index when a tab is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
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
