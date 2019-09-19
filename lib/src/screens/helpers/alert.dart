import 'package:flutter/material.dart';

Future<bool> showAlertPopup(
  BuildContext context, {
  okText: "OK",
  message: "Are you sure ?",
  onPressOk,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          message,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          RaisedButton(
            color: Colors.green,
            child: Text(
              okText,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: onPressOk,
          ),
        ],
      );
    },
  );
}
