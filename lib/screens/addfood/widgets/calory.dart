import 'package:flutter/material.dart';

class Calory extends StatefulWidget {
  Calory({super.key, required this.caloryController});

  @override
  State<Calory> createState() => _CaloryState();
  TextEditingController caloryController;
}

class _CaloryState extends State<Calory> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Calory",
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 50),

        SizedBox(
          width: 120,
          child: TextField(
            controller: widget.caloryController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.zero,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.zero,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.zero,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              isDense: true,
            ),
          ),
        ),

        SizedBox(width: 7),
        Text("cal / g", style: TextStyle(fontSize: 15, color: Colors.blue)),
      ],
    );
  }
}
