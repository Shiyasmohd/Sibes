import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie/Models/food_model.dart';
import 'package:foodie/Models/user_model.dart';
import 'package:foodie/Screens/Widgets/view_widgets.dart';

class ScreenView extends StatelessWidget {
  ScreenView({Key? key}) : super(key: key);
  UserModel owner = UserModel();
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as List;
    final _food = data[0] as FoodModel;
    final _owner = data[1] as UserModel;
    final Widgets = ViewWidgets(_food);
    bool booked = true;
    FirebaseAuth auth = FirebaseAuth.instance;
    if (_food.bookings.contains(auth.currentUser!.uid)) booked = true;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference foodItems =
        FirebaseFirestore.instance.collection('users');
    Widget bookButton() {
      return (TextButton.icon(
          onPressed: () {
            // print("Owner ${owner.firstName}");
            // print("Current User ${auth.currentUser!.uid}");
            // if (booked == true) {
            //   if(_food.no>_food.noBooked)
            //   {FoodModel _temp = _food;
            //   _temp.bookings.add(auth.currentUser!.uid);
            //   _temp.noBooked++;
            //   foodItems
            //       .doc(_food.itemId)
            //       .update(_temp.toMap())
            //       .then((value) => null)
            //       .catchError((error) {
            //     print(error);
            // });
            // }
            //}
            Fluttertoast.showToast(msg: "Booking feature not available currently");
          },
          icon: const Icon(Icons.book_online),
          label: const Text("Book Item")));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_food.hotelName.toString()),
        centerTitle: true,
      ),
      body: ListView(
        children: [Widgets.image(), Widgets.details(), bookButton()],
      ),
    );
  }
}
