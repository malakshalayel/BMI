import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
  });

  final VoidCallback onPressed;
  final Widget child;
  final int? width;
  final int? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width?.w ?? 300.w,
      height: height?.h ?? 45.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
        child: child,
      ),
    );
  }
}
