import 'package:flutter/material.dart';

class ChartKey extends StatelessWidget {
  const ChartKey({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
