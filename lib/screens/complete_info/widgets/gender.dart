import 'package:flutter/material.dart';

class GenderSelection extends StatefulWidget {
  GenderSelection({
    super.key,
    required this.selectedGender,
    required this.onGenderChanged,
  });
  String selectedGender;
  final ValueChanged<String> onGenderChanged;

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        Text(
          "Gender",
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildGenderRadioOption('Male'),
        Text("Male", style: TextStyle(color: Colors.blue)),
        _buildGenderRadioOption('Female'),
        Text("Female", style: TextStyle(color: Colors.blue)),
      ],
    );
  }

  Widget _buildGenderRadioOption(String gender) {
    return Radio<String>(
      fillColor: WidgetStatePropertyAll(Colors.blue),
      value: gender,
      groupValue: widget.selectedGender,
      onChanged: (value) {
        setState(() {
          widget.selectedGender = value!;
          widget.onGenderChanged(value);
        });
      },
    );
  }
}
