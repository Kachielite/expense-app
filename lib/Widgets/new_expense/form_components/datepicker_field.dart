import 'package:flutter/material.dart';

import '../../../model/expense_model.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField(
      {super.key, required this.onSelectDate, required this.dateValue});

  final void Function() onSelectDate;
  final DateTime dateValue;

  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Date',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.white)),
              child: TextButton(
                  onPressed: onSelectDate,
                  child: Row(
                    children: [
                      Text(
                        formatter.format(dateValue),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: onSelectDate,
                        icon: const Icon(Icons.date_range),
                        color: Colors.white,
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
