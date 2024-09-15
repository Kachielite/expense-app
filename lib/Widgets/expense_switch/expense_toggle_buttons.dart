import 'package:daily_expense/Widgets/expense_switch/expense_toggle_button.dart';
import 'package:flutter/material.dart';

const List<String> _expenseTypes = ['INCOME', 'EXPENSE'];

class ExpenseToggleButtons extends StatefulWidget {
  const ExpenseToggleButtons(this.onSelectExpenseType, this.activeFilter,
      {super.key});

  final void Function(String) onSelectExpenseType;
  final String activeFilter;

  @override
  State<ExpenseToggleButtons> createState() {
    return _ExpenseToggleButtonsState();
  }
}

class _ExpenseToggleButtonsState extends State<ExpenseToggleButtons> {
  @override
  Widget build(context) {
    final List<bool> selectedType = [
      widget.activeFilter == 'INCOME',
      widget.activeFilter == 'EXPENSE'
    ];
    return Container(
        width: double.infinity,
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
