import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

const buttonStyle =
    TextStyle(fontFamily: 'Helvetica', fontWeight: FontWeight.w600);

const headerStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    fontSize: 18.0);

class HomePage extends StatelessWidget {
  @override
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text(
      "Listen",
      style: buttonStyle,
    ),
    1: Text("Spotify", style: buttonStyle),
  };

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          child: buildContent(),
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50)),
    );
  }

  StatefulBuilder buildContent() {
    int modeIndex = 0;
    double sliderValue = 70.0;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            new Text(
              "Patrick's Frame",
              style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold),
            ),
            new IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.red,
                ),
                onPressed: () {})
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
                onValueChanged: (int newValue) {
                  setState(() {
                    modeIndex = newValue;
                  });
                },
                groupValue: modeIndex,
              ))
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Brightness",
                style: headerStyle,
              )
            ],
          ),
          Row(children: <Widget>[
            Expanded(
              child: CupertinoSlider(
                  value: sliderValue,
                  onChanged: (newv) {
                    setState(() {
                      sliderValue = newv;
                    });
                  },
                  min: 50.0,
                  max: 100.0),
            )
          ]),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                    color: Color(0xffe5e5e7),
                    splashColor: Colors.transparent,
                    onPressed: () => {},
                    child: Text(
                      "Sleep Now",
                      style: buttonStyle,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0))),
              )
            ],
          )
        ],
      );
    });
  }
}
