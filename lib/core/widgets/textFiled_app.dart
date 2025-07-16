import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.suffixIcon,
    this.obscureText,
    this.enabled,
  });
  final String hintText;
  final TextEditingController? controller;
  final IconButton? suffixIcon;
  final bool? obscureText;
  final bool? enabled;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controller,
        obscureText: obscureText ?? false,
        enabled: enabled ?? true,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(10),
          ),
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 9.sp),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
