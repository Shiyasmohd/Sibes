import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Models/food_model.dart';
import 'package:foodie/Models/food_type_model.dart';
import 'package:foodie/Models/user_model.dart';
import 'package:foodie/Screens/Widgets/main_widgets.dart';
import 'package:foodie/firebase/functions.dart';

class ScreenMain extends StatelessWidget {
  ScreenMain({Key? key}) : super(key: key);
  final List<FoodType> tAll = [
    FoodType("All", Icons.ac_unit_rounded, "assets/logo.png"),
    FoodType("Burgur", Icons.food_bank, "assets/logo.png"),
    FoodType("IceCreams", Icons.food_bank_sharp, "assets/logo.png"),
    FoodType("All", Icons.food_bank_sharp, "assets/logo.png"),
    FoodType("All", Icons.food_bank_sharp, "assets/logo.png"),
    FoodType("All", Icons.food_bank_sharp, "assets/logo.png"),
    FoodType("All", Icons.food_bank_sharp, "assets/logo.png"),
  ];

  final  main =  MainWidgets();
  @override
  Widget build(BuildContext context) {
    Widget categories(FoodType type) {
      FireBaseFunctions.instance.refresh();

      return Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(
              type.iconName,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              type.name,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
    }

    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Container(
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () => handleClick(context),
                      child: Container(
                        child: const Text(
                          "Add +",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Text(
            "  Categories",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          // CATEGORIES

          Expanded(
            flex: 1,
            child: ListView.separated(
              itemBuilder: (ctx, index) {
                return categories(tAll[index]);
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  width: 10,
                );
              },
              itemCount: tAll.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
            ),
          ),
          Expanded(
            flex: 4,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return  Center(
                    child: Image.asset(
                "assets/loading-food.gif",
               height: 250.0,
               width: 250.0,
               ),
                  );
                }

                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    final _temp = FoodModel.fromMap1(document);
                    return main.foodCard(_temp, context);
                  }).toList(),
                );
              },
            ),
          )
        ],
      ),
    ));
  }

  handleClick(ctx) async {
    // await FirebaseAuth.instance.signOut();
    // if (FirebaseAuth.instance.currentUser == null) {
    //   Navigator.popAndPushNamed(ctx, "/login");
    // }
    Navigator.pushNamed(ctx, '/create');
  }

 
}
