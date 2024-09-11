import 'package:flutter/material.dart';

class TotalExpense extends StatelessWidget {
  const TotalExpense(this.totalExpenses, {super.key});

  final String totalExpenses;

  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          color: Colors.black),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Balance',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const Spacer(),
          Text(
            '\$$totalExpenses',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
