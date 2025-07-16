import 'package:flutter/material.dart';

class TimeOfNewRecord extends StatelessWidget {
  TimeOfNewRecord({super.key, required this.timeOfNewRecord});
  TextEditingController timeOfNewRecord;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Time",
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 50),
        Expanded(
          child: TextField(
            controller: timeOfNewRecord,
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
        SizedBox(width: 70),
      ],
    );
  }
}
