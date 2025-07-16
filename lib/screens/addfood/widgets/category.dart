import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  Category({super.key, required this.categoryController});

  @override
  State<Category> createState() => _CategoryState();
  TextEditingController categoryController;
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Category",
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 30),

        SizedBox(
          width: 100,
          child: TextField(
            controller: widget.categoryController,
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
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: null,
                border: Border.all(color: Colors.blue),
              ),
              height: 32, // Line height
              // width: 1, // Line thickness
              // Line color
              margin: EdgeInsets.symmetric(horizontal: 0),

              child: IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Center(child: Icon(Icons.arrow_drop_down_sharp)),
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(width: 7),
      ],
    );
  }
}
