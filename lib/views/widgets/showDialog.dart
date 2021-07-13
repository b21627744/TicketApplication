import 'package:flutter/material.dart';

Future<String?> showDialogWidget(BuildContext context, String text) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) =>
        AlertDialog(title: Text(text), actions: <Widget>[
      TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text('OK', style: TextStyle(color: Colors.black)))
    ]),
  );
}
