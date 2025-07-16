// import 'package:flutter/material.dart';

import 'package:bmi/screens/addfood/widgets/calory.dart';
import 'package:bmi/screens/edit_food_details/edit_food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodList extends StatefulWidget {
  const FoodList({super.key});

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  final user = FirebaseAuth.instance.currentUser;

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
        leading: IconButton(
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil("/Home", (route) => false);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 20),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance
                  .collection("add_food")
                  .where("creator", isEqualTo: user!.uid)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              print("No Data");
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No food items found'));
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                const Text(
                  'Food List',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 40.h),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final data =
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
                      final nameFood =
                          data.containsKey("nameFood")
                              ? data["nameFood"]
                              : "Unnamed";
                      final categoryFood =
                          data.containsKey("category")
                              ? data["category"]
                              : "Un category";
                      final calory =
                          data.containsKey("calory")
                              ? data["calory"]
                              : "Un calory";
                      return Dismissible(
                        key: ValueKey(snapshot.data!.docs[index].id),
                        onDismissed: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            try {
                              await FirebaseFirestore.instance
                                  .collection("add_food")
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();
                            } catch (e) {
                              print("Error deleting document: $e");
                            }
                          } else {}
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: null,
                                border: Border.all(color: Colors.blue),
                              ),
                              height: 100,
                              width: 100, // Line height
                              margin: EdgeInsets.symmetric(horizontal: 0),
                              child: Icon(
                                Icons.food_bank_rounded,
                                size: 50,
                                color: Colors.blue,
                              ),
                            ),
                            Expanded(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  //  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: Colors.blue),
                                ),
                                margin: EdgeInsets.only(
                                  right: 5,
                                  top: 12,
                                  bottom: 12,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: 0,
                                    top: 0,
                                    bottom: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              nameFood,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          // SizedBox(width: 100),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.blue[50],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                      Colors.blue,
                                                    ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) => EditFood(
                                                          Foodid:
                                                              snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id,
                                                        ),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          //SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              "  $categoryFood \n   $calory cal/g ",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                          //SizedBox(width: 100),
                                          Text(
                                            "swipe to delete -->",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
