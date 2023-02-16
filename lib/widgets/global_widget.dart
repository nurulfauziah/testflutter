import 'package:flutter/material.dart';
import 'package:testflutter/helper/navigation.dart';
import 'package:testflutter/widgets/bottom.dart';

class GlobalWidget {
  static showAlertDialog(BuildContext context, String message) {
    // set up the buttons
    // Widget cancelButton = MainBottom(
    //   function: () {
    //     Navigator.pop(context);
    //   },
    //   title: 'Cancel',
    // );
    Widget continueButton = MainBottom(
      function: () {
        Navigation.back();
      },
      title: 'Ok',
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // Image.asset('assets/images/ic_verified.png'),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Error',
            textAlign: TextAlign.center,
            // style: TextHelper.title18,
          )
        ],
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: [
        Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
            width: double.infinity,
            child: continueButton),
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
