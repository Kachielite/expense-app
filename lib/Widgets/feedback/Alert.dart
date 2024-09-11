import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  const Alert(this.ctx, {super.key});

  final BuildContext ctx;

  @override
  Widget build(context) {
    return AlertDialog(
      title: const Text(
        'Invalid Form',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: const Text(
          'Please make sure a valid title, amount, date and category was entered.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14)),
      actions: [
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.black),
          onPressed: () {
            Navigator.pop(ctx);
          },
          child: const Text('Okay'),
        ),
      ],
    );
  }
}
