import 'package:bmi/core/widgets/elevatedbutton_app.dart';
import 'package:bmi/screens/new_record/widgets/date.dart';
import 'package:bmi/screens/new_record/widgets/lenght.dart';
import 'package:bmi/screens/new_record/widgets/time_ofnew_record.dart';
import 'package:bmi/screens/new_record/widgets/weight.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewRecord extends StatefulWidget {
  NewRecord({super.key, required userId});
  String? userId;
  @override
  State<NewRecord> createState() => _NewRecordState();
}

class _NewRecordState extends State<NewRecord> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _timeOfRecordController = TextEditingController();

  // Future<void> addNewMeasurement() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user == null) {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(const SnackBar(content: Text('No user logged in')));
  //       return;
  //     }

  //     final weight = double.tryParse(_weightController.text);
  //     final height = double.tryParse(_lengthController.text);

  //     if (weight == null || height == null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Please enter valid numbers')),
  //       );
  //       return;
  //     }

  //     // Calculate BMI and status
  //     final bmi = weight / ((height / 100) * (height / 100));
  //     final status = getInterpretation(bmi);

  //     // Create NEW document in measurements subcollection
  //     await FirebaseFirestore.instance
  //         .collection('user information')
  //         .doc(user.uid)
  //         .set({
  //           'weight': weight,
  //           'lenght': height,
  //           'createdAt': FieldValue.serverTimestamp(),
  //           'bmi': bmi,
  //           'status': status,
  //         }, SetOptions(merge: true));

  //     // Clear fields and navigate back
  //     _weightController.clear();
  //     _lengthController.clear();
  //     Navigator.pop(context);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error saving measurement: ${e.toString()}')),
  //     );
  //   }
  // }

  Future<void> updateUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('No user logged in')));
        }
        return;
      }

      final weight = _weightController.text.trim();
      final length = _lengthController.text.trim();
      final dateOfBirth = _dateOfBirthController.text.trim();
      final timeRecord = _timeOfRecordController.text.trim();

      if (weight.isEmpty || length.isEmpty || dateOfBirth.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill in all required fields')),
          );
        }
        return;
      }
      final now = DateTime.now();

      final updateData = ({
        "weight": weight,
        "length": length,
        "dateOfBirth": dateOfBirth,
        "timeOfRecord": timeRecord,
        "updatedAt": now,
        // Use server timestamp consistently
      });

      // Check if document exists first
      final docRef = FirebaseFirestore.instance
          .collection("user information")
          .doc(widget.userId);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        // If document doesn't exist, include creation data
        // updateData["createdAt"] = DateTime.timestamp();
        // updateData["creator"] = user.uid;
      }

      await docRef.set({
        "weight": weight,
        "length": length,
        "dateOfBirth": dateOfBirth,
        "timeOfRecord": timeRecord,
        "updatedAt": now,
        "createdAt": DateTime.timestamp(),
        "creator": user.uid,
      }, SetOptions(merge: true));
      // await docRef.set({
      //   "createdAt": DateTime.timestamp(),
      //   "creator": user.uid,
      // }, SetOptions(merge: true));
      print("datat updated");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User data saved successfully')),
        );
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/Home', (route) => false);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving user data: ${e.toString()}')),
        );
      }
      print('Error saving user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'BMI Analyzer',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/Home");
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50.0,
              vertical: 20.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'New Record',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 40.h),

                  SizedBox(height: 30.h),
                  WeighTSelection(weightController: _weightController),
                  SizedBox(height: 30.h),
                  LenghtSelection(lenghtController: _lengthController),
                  SizedBox(height: 30.h),
                  TimeOfNewRecord(timeOfNewRecord: _timeOfRecordController),
                  SizedBox(height: 30.h),
                  DateOfBirthSelection(
                    dateOfBirthController: _dateOfBirthController,
                  ),

                  SizedBox(height: 50.h),
                  AppElevatedButton(
                    width: 180,
                    height: 42,
                    child: Text(
                      'Save Data',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                    onPressed: () async {
                      // addNewMeasurement();
                      await updateUserData();
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil('/Home', (route) => false);
                      // Handle save data action
                      print('Data saved successfully!');
                      // You can navigate to another screen or show a success message
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static String getInterpretation(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 25) {
      return 'Normal weight';
    } else if (bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
}
