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

StatefulBuilder pageNavigationButton(String text, newPage) {
  double _opacityValue = 1.0;
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return GestureDetector(
      child: Opacity(
          opacity: _opacityValue,
          child: Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Text(
                    text,
                    style: headerStyle,
                  ),
                  Spacer(),
                  Icon(Icons.chevron_right)
                ],
              ))),
      onTap: () {
        print('$text row tapped');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => newPage));
      },
      onTapDown: (details) {
        setState(() {
          _opacityValue = 0.7;
        });
      },
      onTapUp: (details) {
        setState(() {
          _opacityValue = 1.0;
        });
      },
      behavior: HitTestBehavior.translucent,
    );
  });
}
