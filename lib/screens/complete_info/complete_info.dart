import 'package:bmi/core/widgets/elevatedbutton_app.dart';
import 'package:bmi/screens/complete_info/widgets/date_of_birth.dart';
import 'package:bmi/screens/complete_info/widgets/gender.dart';
import 'package:bmi/screens/complete_info/widgets/lenght.dart';
import 'package:bmi/screens/complete_info/widgets/weight.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

class CompleteInfo extends StatefulWidget {
  const CompleteInfo({super.key});

  @override
  State<CompleteInfo> createState() => _CompleteInfoState();
}

class _CompleteInfoState extends State<CompleteInfo> {
  String gender = '';
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  Future<void> saveUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      final genderSelected = gender;
      final weight = _weightController.text;
      final length = _lengthController.text;
      final dateOfBirth = _dateOfBirthController.text;
      print('User ID: ${user.uid}');
      print('User Gender: $genderSelected');
      print('User Weight: $weight');
      print('User Length: $length');
      print('User Date of Birth: $dateOfBirth');

      if (gender.isEmpty ||
          weight.isEmpty ||
          length.isEmpty ||
          dateOfBirth.isEmpty) {
        // Handle empty fields
        print('Please fill in all fields');
        return;
      }
      final id = const Uuid().v4();
      final userData = {
        "gender": gender,
        "weight": weight,
        "length": length,
        "dateOfBirth": dateOfBirth,
        "createdAt": DateTime.timestamp(),
        "id": id,
        "creator": user.uid,
      };
      print('User Data in complete info: $userData');
      final now = DateTime.now();
      await FirebaseFirestore.instance
          .collection("user information")
          .doc(id)
          .set({...userData, 'CreatedAt': now});
      // print(id);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('User data saved successfully')));
    } catch (e) {
      // Handle any errors that occur during the save operation
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
                    'Complete Your \nInformation',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  GenderSelection(
                    selectedGender: gender,
                    onGenderChanged: (newGender) {
                      setState(() {
                        gender = newGender;
                      });
                    },
                  ),
                  SizedBox(height: 30.h),
                  WeighTSelection(weightController: _weightController),
                  SizedBox(height: 30.h),
                  lenghtSelection(lenghtController: _lengthController),
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
                    onPressed: () {
                      saveUserData();
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
}
