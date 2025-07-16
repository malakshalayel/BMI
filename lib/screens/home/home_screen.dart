import 'package:bmi/core/widgets/elevatedbutton_app.dart';
import 'package:bmi/screens/addfood/add_food.dart';
import 'package:bmi/screens/new_record/new_record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  late Future<DocumentSnapshot> docSnapshotuser;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    docSnapshotuser =
        FirebaseFirestore.instance.collection("users").doc(user?.uid).get();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Analyzer',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: docSnapshotuser,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return Center(
                    child: Text(
                      'Hi, ${snapshot.data?['name'] ?? 'User'}!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              Text(
                "Current Status",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10.h),
              CurrentStatus(context),
              SizedBox(height: 20.h),
              Text(
                "Old Status",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 280.w,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 10.0,
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream:
                        FirebaseFirestore.instance
                            .collection("user information")
                            .where("creator", isEqualTo: user?.uid)
                            .orderBy("createdAt", descending: true)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No data available'));
                      }

                      final docs = snapshot.data!.docs;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final doc = docs[index];
                          final data = doc.data() as Map<String, dynamic>;

                          final weight =
                              int.tryParse(data["weight"]?.toString() ?? "0") ??
                              0;
                          final length =
                              int.tryParse(data["length"]?.toString() ?? "0") ??
                              1;
                          final bmi =
                              weight / ((length / 100) * (length / 100));
                          final status = getInterpretation(bmi);

                          // Write status to Firestore if not already written
                          if (!data.containsKey("status")) {
                            FirebaseFirestore.instance
                                .collection('user information')
                                .doc(doc.id)
                                .set({
                                  'status': status,
                                }, SetOptions(merge: true));
                          }

                          Timestamp? timestamp;
                          final rawTimestamp = data['createdAt'];
                          if (rawTimestamp is Timestamp) {
                            timestamp = rawTimestamp;
                          } else if (rawTimestamp is String) {
                            try {
                              timestamp = Timestamp.fromDate(
                                DateTime.parse(rawTimestamp),
                              );
                            } catch (_) {}
                          }

                          final formattedDate =
                              timestamp != null
                                  ? DateFormat(
                                    "dd/MM/yyyy",
                                  ).format(timestamp.toDate())
                                  : "No date";

                          final values = [
                            data['status'] ?? 'No status',
                            "${data['weight'] ?? '0'} Kg",
                            formattedDate,
                            "${data['length'] ?? '0'} Cm",
                          ];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 4,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 1,
                                    crossAxisSpacing: 1,
                                  ),
                              itemBuilder: (context, i) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                          i == 0
                                              ? Radius.circular(5)
                                              : Radius.zero,
                                      topRight:
                                          i == 1
                                              ? Radius.circular(5)
                                              : Radius.zero,
                                      bottomLeft:
                                          i == 2
                                              ? Radius.circular(5)
                                              : Radius.zero,
                                      bottomRight:
                                          i == 3
                                              ? Radius.circular(5)
                                              : Radius.zero,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      values[i],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Row(
                children: [
                  AppElevatedButton(
                    width: 125,
                    height: 40,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AddFood()),
                      );
                    },
                    child: Text(
                      "Add Food",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 30.w),
                  AppElevatedButton(
                    width: 125,
                    height: 40,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder:
                              (context) => NewRecord(
                                userId:
                                    FirebaseFirestore.instance
                                        .collection("user information")
                                        .doc(user?.uid)
                                        .id,
                              ),
                        ),
                      );
                    },
                    child: Text(
                      "Add Record",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              AppElevatedButton(
                width: 280,
                height: 40,
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil("/FoodList", (route) => false);
                },
                child: Text(
                  "View Food",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil("/Login", (route) => true);
                  },
                  child: Text(
                    "logout",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CurrentStatus(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection("user information")
              .where("creator", isEqualTo: user?.uid)
              .orderBy("createdAt", descending: true)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildStatusContainer(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return _buildStatusContainer(
            child: Text(
              "Error loading status",
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final docs =
            snapshot.data!.docs.where((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return data.containsKey('status') && data['status'] != null;
            }).toList();

        if (docs.isEmpty) {
          return _buildStatusContainer(
            child: Text(
              "No status available",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        final status =
            (docs.first.data() as Map<String, dynamic>)['status'].toString();
        return _buildStatusContainer(
          child: Text(
            status,
            style: TextStyle(
              color: _getStatusColor(status),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusContainer({required Widget child}) {
    return Container(
      width: 280.w,
      height: 40.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(child: child),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'underweight':
        return Colors.orange;
      case 'normal weight':
        return Colors.green;
      case 'overweight':
        return Colors.yellow.shade700;
      case 'obese':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
