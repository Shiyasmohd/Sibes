import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUps {
  Future<void> yes_or_no(String title,String text, BuildContext context) async {
    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: const Text("Cancel"),
        onPressed: () {},
      );
      Widget continueButton = TextButton(
        child: const Text("Continue"),
        onPressed: () {},
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title:  Text(title),
        content:  Text(
            text),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
