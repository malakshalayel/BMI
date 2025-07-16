import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeighTSelection extends StatefulWidget {
  WeighTSelection({super.key, required this.weightController});

  @override
  State<WeighTSelection> createState() => _WeighTSelectionState();
  TextEditingController weightController;
}

class _WeighTSelectionState extends State<WeighTSelection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Weight",
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
                int currentWeight =
                    int.tryParse(widget.weightController.text) ?? 0;
                if (currentWeight > 0) {
                  widget.weightController.text = (currentWeight - 1).toString();
                }
              });
            },
          ),
        ),
        // SizedBox(width: 5.w),

        // Text Field
        SizedBox(
          width: 60.w,
          child: TextField(
            controller: widget.weightController,
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
                int currentWeight =
                    int.tryParse(widget.weightController.text) ?? 0;
                widget.weightController.text = (currentWeight + 1).toString();
              });
            },
          ),
        ),
        SizedBox(width: 5.w),

        // Unit
        Text("Kg", style: TextStyle(fontSize: 15, color: Colors.blue)),
      ],
    );
  }
}
