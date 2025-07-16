import 'package:flutter/material.dart';

class DateOfBirthSelection extends StatelessWidget {
  DateOfBirthSelection({super.key, required this.dateOfBirthController});
  TextEditingController dateOfBirthController;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Date of Birth",
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 30),
        Expanded(
          child: TextField(
            controller: dateOfBirthController,
            keyboardType: TextInputType.datetime,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.zero,
              ),
              focusColor: Colors.blue,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.zero,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ),
        SizedBox(width: 30),
      ],
    );
  }
}
