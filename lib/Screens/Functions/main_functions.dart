import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodie/Models/food_model.dart';
import 'package:foodie/Models/user_model.dart';

class MainFunctions{
   handleClick2(BuildContext ctx, FoodModel m1) async {
    UserModel owner = UserModel();
    final ow1 = m1.userId;
    final ownerDetails = await FirebaseFirestore.instance
        .collection("users")
        .doc(ow1)
        .get()
        .then((value) {
      owner = UserModel.fromMap(value.data());
    });

    Navigator.pushNamed(ctx, '/view', arguments: [m1, owner]);
  }
}