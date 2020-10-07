import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatelessWidget {
  @override
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text(
      "Listen",
      style: TextStyle(fontFamily: 'Helvetica', fontWeight: FontWeight.w600),
    ),
    1: Text("Spotify",
        style: TextStyle(fontFamily: 'Helvetica', fontWeight: FontWeight.w600)),
  };

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          child: buildContent(),
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50)),
    );
  }

  Widget buildContent() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            new Text(
              "Patrick's Frame",
              style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold),
            )
          ]),
          Row(children: [
            new Text(
              "Abbey Road",
              style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500),
            )
          ]),
          Row(children: [
            new Text(
              "The Beatles — From Spotify",
              textAlign: TextAlign.left,
            )
          ]),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: CupertinoSlidingSegmentedControl(
                children: logoWidgets,
                onValueChanged: (changeFromGroupValue) {},
                groupValue: 0,
              ))
            ],
          )
        ],
      );
}
