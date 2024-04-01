

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';


class Flush {
  static void showFlushbar(BuildContext context, String message) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}



class Dialog {
  static Future<void> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing dialog with a tap outside
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(), // Display a circular progress indicator
              SizedBox(height: 16.0),
              Text("Loading..."),
            ],
          ),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}