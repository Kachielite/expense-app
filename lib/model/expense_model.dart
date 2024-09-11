import 'package:daily_expense/enums/categories.dart';
import 'package:daily_expense/enums/expense_type.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
var formatter = DateFormat.yMd();

class ExpenseModel {
  ExpenseModel(this.title, this.category, this.amount, this.type, this.createAt)
      : id = uuid.v4();

  final String id;
  final String title;
  final Categories category;
  final double amount;
  final ExpenseType type;
  final DateTime createAt;

  String get formatDate {
    return formatter.format(createAt);
  }
}
