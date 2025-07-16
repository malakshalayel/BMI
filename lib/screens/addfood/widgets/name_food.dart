import 'package:flutter/material.dart';

class NameFood extends StatefulWidget {
  NameFood({super.key, required this.nameControoler});

  @override
  State<NameFood> createState() => _NameFoodState();
  TextEditingController nameControoler;
}

class _NameFoodState extends State<NameFood> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Name",
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(width: 50),
        SizedBox(
          width: 140,
          child: TextField(
            controller: widget.nameControoler,
            keyboardType: TextInputType.text,
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
      ],
    );
  }
}
