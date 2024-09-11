import 'package:daily_expense/Widgets/expense_switch/expense_toggle_button.dart';
import 'package:flutter/material.dart';

const List<String> _expenseTypes = ['ALL', 'INCOME', 'EXPENSE'];

class ExpenseToggleButtons extends StatefulWidget {
  const ExpenseToggleButtons(this.onSelectExpenseType, {super.key});

  final void Function(String) onSelectExpenseType;

  @override
  State<ExpenseToggleButtons> createState() {
    return _ExpenseToggleButtonsState();
  }
}

class _ExpenseToggleButtonsState extends State<ExpenseToggleButtons> {
  final List<bool> selectedType = [true, false, false];

  @override
  Widget build(context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: ToggleButtons(
            borderColor: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            isSelected: selectedType,
            fillColor: Colors.black,
            selectedColor: Colors.white,
            color: Colors.black,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < selectedType.length; i++) {
                  selectedType[i] = i == index;
                }
              });

              widget.onSelectExpenseType(_expenseTypes[index]);
            },
            children: [
              ..._expenseTypes.map((type) => ExpenseToggleButton(type))
            ]));
  }
}
