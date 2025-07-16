import 'package:bmi/core/widgets/elevatedbutton_app.dart';
import 'package:bmi/screens/addfood/widgets/photo.dart';
import 'package:bmi/screens/edit_food_details/widgets/edit_calory.dart';
import 'package:bmi/screens/edit_food_details/widgets/edit_category.dart';
import 'package:bmi/screens/edit_food_details/widgets/edit_name_food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditFood extends StatefulWidget {
  const EditFood({super.key, required this.Foodid});

  final String Foodid;
  @override
  State<EditFood> createState() => _EditFoodState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController categoryController = TextEditingController();
final TextEditingController caloryController = TextEditingController();
bool _isLoading = false;

class _EditFoodState extends State<EditFood> {
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference Food = FirebaseFirestore.instance.collection('add_food');

  @override
  void initState() {
    super.initState();
    _loadFoodData(); // ✅ CALLED HERE - Loads data when screen opens
  }

  Future<void> _loadFoodData() async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance
              .collection("add_food")
              .doc(widget.Foodid)
              .get();

      if (doc.exists) {
        setState(() {
          nameController.text = doc["nameFood"] ?? "";
          categoryController.text = doc["category"] ?? "";
          caloryController.text = doc["calory"].toString() ?? "";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading food: ${e.toString()}')),
      );
    }
  }

  Future<void> EditFoodData() async {
    await Food.doc(widget.Foodid).update({
      "nameFood": nameController.text.trim(),
      "category": categoryController.text.trim(),
      "calory": caloryController.text.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
      "createdAt": DateTime.timestamp(),
      "creator": FirebaseAuth.instance.currentUser!.uid,
    });
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
                    'Edit Food Details',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  EditNameFood(nameControoler: nameController),
                  SizedBox(height: 30.h),
                  EditCategory(categoryController: categoryController),
                  SizedBox(height: 30.h),
                  EditCalory(caloryController: caloryController),
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
                          EditFoodData();
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
