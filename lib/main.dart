import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'settings.dart';
import 'styles.dart';

void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatelessWidget {
  @override
  final Map<int, Widget> modeSegments = const <int, Widget>{
    0: Text("Listen", style: buttonStyle),
    1: Text("Connect", style: buttonStyle),
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
    String title = "Patrick's Frame";
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            new Text(
              title,
              style: titleStyle,
            ),
            Spacer(),
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsPage(
                                frameName: title,
                              )));
                  setState(() {
                    title = result;
                  });
                  print(result);
                })
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
                children: modeSegments,
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
                "QUICK SETTINGS",
                style: TextStyle(
                    color: Color(0xff9d9d9d), fontWeight: FontWeight.w700),
              )
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
