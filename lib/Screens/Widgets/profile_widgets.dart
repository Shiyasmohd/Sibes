import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Models/food_model.dart';

class ProfileWidgets {
  Widget image() {
    return Container(
      width: 350,
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        image: const DecorationImage(
          image: AssetImage("assets/profile.png"),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: Colors.white,
          width: 8,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget liner() {
    return const Divider(
      color: Colors.red,
    );
  }

  Widget text1(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal),
    );
  }

  Widget text2(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Colors.black87,
            fontStyle: FontStyle.italic));
  }

  Widget details(BuildContext ctx) {
    return Center(
      child: Column(
        children: [
          image(),
          text2("Taslim M M"),
          const SizedBox(
            height: 90,
          ),
          liner(),
          InkWell(
            onTap: () {
              Navigator.pushNamed(ctx, 'additions');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text1("  Active Contributions"),
                const Icon(
                  Icons.fastfood,
                  size: 40,
                )
              ],
            ),
          ),
          liner(),
          InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text1("  Settings"),
                  const Icon(Icons.settings, size: 40)
                ],
              )),
          liner(),
          InkWell(
            onTap: () {
              signOut(ctx);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text1("  Sign out"),
                const Icon(Icons.arrow_right, size: 40)
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> signOut(BuildContext ctx) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(ctx, '/login', (route) => false);
  }
}
