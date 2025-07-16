import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class lenghtSelection extends StatefulWidget {
  lenghtSelection({super.key, required this.lenghtController});
  TextEditingController lenghtController = TextEditingController();

  @override
  State<lenghtSelection> createState() => _lenghtSelectionState();
}

TextEditingController weightController = TextEditingController();

class _lenghtSelectionState extends State<lenghtSelection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Length",
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 30.w),

        // Minus button
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          height: 29.h,
          child: IconButton(
            icon: Icon(Icons.remove),
            color: Colors.blue,
            iconSize: 16,
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                int current = int.tryParse(widget.lenghtController.text) ?? 0;
                if (current > 0) {
                  widget.lenghtController.text = (current - 1).toString();
                }
              });
            },
          ),
        ),
        // SizedBox(width: 5.w),

        // Text field
        SizedBox(
          width: 60.w,
          child: TextField(
            controller: widget.lenghtController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8.h),
              isDense: true,
            ),
          ),
        ),
        // SizedBox(width: 5.w),

        // Plus button
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          height: 29.h,
          child: IconButton(
            icon: Icon(Icons.add),
            color: Colors.blue,
            iconSize: 16,
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                int current = int.tryParse(widget.lenghtController.text) ?? 0;
                widget.lenghtController.text = (current + 1).toString();
              });
            },
          ),
        ),
        SizedBox(width: 5.w),

        // Unit label
        Text("cm", style: TextStyle(fontSize: 15, color: Colors.blue)),
      ],
    );
  }
}
