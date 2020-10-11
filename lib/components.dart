import 'styles.dart';
import 'package:flutter/material.dart';

Widget buildNavigationBar(BuildContext context, String text) {
  return Row(
    children: <Widget>[
      IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context, "Test Return Text");

            // Also save all settings
          }),
      Expanded(
        child: new Text(
          text,
          style: titleStyle,
        ),
      ),
    ],
  );
}
