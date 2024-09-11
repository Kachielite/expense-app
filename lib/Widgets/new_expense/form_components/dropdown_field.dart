import 'package:flutter/material.dart';

class DropDownField extends StatelessWidget {
  const DropDownField(
      {super.key,
      required this.label,
      required this.data,
      required this.onSelect,
      required this.value});

  final void Function(Enum value) onSelect;
  final String label;
  final List<Enum> data;
  final Enum value;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 5,
              ),
              DropdownButtonFormField<Enum>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Colors.white), // White border when enabled
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Colors.white), // White border when focused
                  ),
                  hintText: label,
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                dropdownColor: Colors.black, // Dropdown background color
                iconEnabledColor: Colors.white, // Dropdown icon color
                style:
                    const TextStyle(color: Colors.white), // Dropdown text color
                value: value,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  onSelect(value);
                },
                items: data
                    .map((d) => DropdownMenuItem<Enum>(
                          value: d,
                          child: Text(d.name.toUpperCase()),
                        ))
                    .toList(),
              )
            ]));
  }
}
