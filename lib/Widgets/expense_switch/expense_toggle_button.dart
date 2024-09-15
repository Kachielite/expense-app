import 'package:flutter/material.dart';

class ExpenseToggleButton extends StatelessWidget {
  const ExpenseToggleButton(this.label, {super.key});

  final String label;

  @override
  Widget build(context) {
    return SizedBox(
      width: 180,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
      ),
    );
  }
}
