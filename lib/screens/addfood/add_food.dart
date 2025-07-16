import 'package:bmi/core/widgets/elevatedbutton_app.dart';
import 'package:bmi/screens/addfood/widgets/calory.dart';
import 'package:bmi/screens/addfood/widgets/category.dart';
import 'package:bmi/screens/addfood/widgets/name_food.dart';
import 'package:bmi/screens/addfood/widgets/photo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController categoryController = TextEditingController();
final TextEditingController caloryController = TextEditingController();

class _AddFoodState extends State<AddFood> {
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference addFood = FirebaseFirestore.instance.collection(
    'add_food',
  );
  Future<void> saveFoodData() async {
    await addFood.doc().set({
      "nameFood": nameController.text.trim(),
      "category": categoryController.text.trim(),
      "calory": caloryController.text.trim(),
      "createdAt": DateTime.timestamp(),
      "creator": FirebaseAuth.instance.currentUser!.uid,
    }, SetOptions(merge: true));
  }

  @override
  void initState() {
    super.initState();

    // Clear data on page open
    nameController.clear();
    categoryController.clear();
    caloryController.clear();
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
                    'Add Food Details',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  NameFood(nameControoler: nameController),
                  SizedBox(height: 30.h),
                  Category(categoryController: categoryController),
                  SizedBox(height: 30.h),
                  Calory(caloryController: caloryController),
                  SizedBox(height: 30.h),
                  Photo(),

                  SizedBox(height: 50.h),
                  Row(
                    children: [
                      AppElevatedButton(
                        width: 130,
                        height: 42,
                        child: Text(
                          'Upload Photo',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        onPressed: () {
                          // saveFoodData();
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text("Data saved successfully")),
                          // );
                          // Navigator.of(context).pushNamedAndRemoveUntil(
                          //   '/FoodList',
                          //   (route) => false,
                          // );
                          // // Handle save data action
                          // print('Data saved successfully!');
                          // // You can navigate to another screen or show a success message
                        },
                      ),
                      SizedBox(width: 20.w),
                      AppElevatedButton(
                        width: 110,
                        height: 42,
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        onPressed: () {
                          saveFoodData();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/FoodList',
                            (route) => false,
                          );
                          // Handle save data action
                          print('Data saved successfully!');
                          // You can navigate to another screen or show a success message
                        },
                      ),
                    ],
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
