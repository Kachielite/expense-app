import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      required this.inputController,
      required this.label,
      this.type});

  final TextEditingController inputController;
  final String label;
  final String? type;

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
            TextField(
              controller: inputController,
              cursorColor: Colors.white, // Set cursor color to white
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
              ),
              keyboardType:
                  _getKeyboardType(), // Use the method to determine the keyboard type
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ));
  }

  // A method to get the correct TextInputType based on the provided 'type'
  TextInputType _getKeyboardType() {
    switch (type) {
      case 'number':
        return TextInputType.number;
      case 'email':
        return TextInputType.emailAddress;
      case 'phone':
        return TextInputType.phone;
      case 'multiline':
        return TextInputType.multiline;
      case 'url':
        return TextInputType.url;
      default:
        return TextInputType.text; // Default to text input type
    }
  }
}
