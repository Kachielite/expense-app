import 'package:daily_expense/enums/categories.dart';
import 'package:daily_expense/enums/expense_type.dart';
import 'package:daily_expense/model/expense_model.dart';

List<ExpenseModel> myExpenses = [
  ExpenseModel(
    'Lunch at Cafe',
    Categories.food,
    23.50,
    ExpenseType.expense,
    DateTime.now().subtract(const Duration(days: 3)),
  ),
  ExpenseModel(
    'Flight Ticket',
    Categories.travel,
    180.75,
    ExpenseType.expense,
    DateTime.now().subtract(const Duration(days: 10)),
  ),
  ExpenseModel(
    'Freelance Payment',
    Categories.income,
    1050.00,
    ExpenseType.income,
    DateTime.now().subtract(const Duration(days: 7)),
  ),
  ExpenseModel(
    'Beach Vacation',
    Categories.leisure,
    150.25,
    ExpenseType.expense,
    DateTime.now().subtract(const Duration(days: 20)),
  ),
  ExpenseModel(
    'Online Course',
    Categories.education,
    99.99,
    ExpenseType.expense,
    DateTime.now().subtract(const Duration(days: 15)),
  ),
  ExpenseModel(
    'Stock Returns',
    Categories.investment,
    200.00,
    ExpenseType.income,
    DateTime.now().subtract(const Duration(days: 5)),
  ),
  ExpenseModel(
    'Movie Night',
    Categories.movies,
    15.00,
    ExpenseType.expense,
    DateTime.now().subtract(const Duration(days: 2)),
  ),
  ExpenseModel(
    'Doctor Visit',
    Categories.health,
    75.50,
    ExpenseType.expense,
    DateTime.now().subtract(const Duration(days: 8)),
  ),
  ExpenseModel(
    'Car Repair',
    Categories.emergency,
    225.00,
    ExpenseType.expense,
    DateTime.now().subtract(const Duration(days: 12)),
  ),
  ExpenseModel(
    'Savings Deposit',
    Categories.savings,
    100.00,
    ExpenseType.income,
    DateTime.now().subtract(const Duration(days: 1)),
  ),
];
