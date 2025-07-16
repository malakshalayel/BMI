import 'package:bmi/core/widgets/elevatedbutton_app.dart';
import 'package:bmi/core/widgets/textFiled_app.dart';
import 'package:bmi/screens/complete_info/complete_info.dart';
import 'package:bmi/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isObscureText = true;

  Future<void> createAccountWithEmailAndPassword() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      print('User created: ${userCredential.user?.email}');
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user?.uid)
          .set({
            "name": nameController.text.trim(),
            "email": emailController.text.trim(),
            "password": passwordController.text.trim(),
            "passwordConfirm": confirmPasswordController.text.trim(),
            "createdAt": FieldValue.serverTimestamp(),
          });

      if (userCredential.user != null) {
        // Navigate to home screen after successful signup
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CompleteInfo()),
        );
      } else {
        print('User creation failed');
      }
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI Analyzer',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create New Account',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  'If you already haven\'t an account, ',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 50.h),
                AppTextField(controller: nameController, hintText: "Name"),
                SizedBox(height: 12),
                AppTextField(controller: emailController, hintText: "E-Email"),
                SizedBox(height: 12),
                AppTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: isObscureText,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    icon: Icon(
                      isObscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                AppTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: isObscureText,
                ),
                SizedBox(height: 60.h),

                AppElevatedButton(
                  onPressed: () async {
                    await createAccountWithEmailAndPassword();
                  },
                  child: const Text(
                    'CREATE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Navigate to login screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Colors.grey[600]),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
