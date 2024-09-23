import 'package:daily_expense/screens/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
      child: MaterialApp(
    home: TabsScreen(),
  )));
}
