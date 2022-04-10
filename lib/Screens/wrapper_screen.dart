import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Models/user_model.dart';
// import 'package:foodie/Screens/home_screen.dart';
// import 'package:foodie/Screens/login_screen.dart';
// import 'package:foodie/main.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({Key? key}) : super(key: key);

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  
  @override
  Widget build(BuildContext context) {
    // if (user == null) {
    //   Navigator.pushReplacementNamed(context, '/login');
    // } else {
    //   FirebaseFirestore.instance
    //       .collection("users")
    //       .doc(user!.uid)
    //       .get()
    //       .then((value) {
    //     loggedInUser = UserModel.fromMap(value.data());
    //     Navigator.pushReplacementNamed(context, '/');
    //     print("succeful ${loggedInUser.toString()}");
    //   }).catchError((e) => {print("No User Present")});
    // }
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: handleClick(),
          child: Image.asset(
            "assets/loading-food.gif",
            height: 250.0,
            width: 250.0,
            
          ),
        ),

      ),
    );
  }
   handleClick() {
    if (user == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        loggedInUser = UserModel.fromMap(value.data());
        Navigator.pushReplacementNamed(context, '/');
        print("succeful ${loggedInUser.toString()}");
      }).catchError((e) => {print("No User Present")});
    }
   }
}
