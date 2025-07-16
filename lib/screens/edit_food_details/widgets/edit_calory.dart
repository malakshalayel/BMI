import 'package:flutter/material.dart';

class EditCalory extends StatefulWidget {
  EditCalory({super.key, required this.caloryController});

  @override
  State<EditCalory> createState() => _EditCaloryState();
  TextEditingController caloryController;
}

class _EditCaloryState extends State<EditCalory> {
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
        SizedBox(width: 40),

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
        //SizedBox(width: 70),
      ],
    );
  }
}
