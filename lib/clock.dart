import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'components.dart';
import 'styles.dart';
import 'colorpicker.dart';
import 'globals.dart' as globals;

FocusNode firstFocusNode = new FocusNode();

final Map<int, Widget> clockModeSegments = const <int, Widget>{
  0: Text("Off", style: buttonStyle),
  1: Text("12 Hour", style: buttonStyle),
  2: Text("24 Hour", style: buttonStyle),
};

final Map<int, Widget> clockStyleSegments = const <int, Widget>{
  0: Text("Classic", style: buttonStyle),
  1: Text("Modern", style: buttonStyle),
};

class ClockPage extends StatelessWidget {
  Widget build(BuildContext buildContext) {
    return new Scaffold(
        body: new GestureDetector(
      child: new Container(
          child: buildContent(),
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50)),
      onTap: () {
        print('tapped!');
        FocusScope.of(buildContext).requestFocus(new FocusNode());
      },
      behavior: HitTestBehavior.translucent,
    ));
  }
}

StatefulBuilder buildContent() {
  int clockModeIndex = 0;
  if (globals.data["showClock"] != false) {
    if (globals.data["clockTiming"] == "12") {
      clockModeIndex = 1;
    } else {
      clockModeIndex = 2;
    }
  }

  int clockStyleIndex = globals.data["clock"] == "classic" ? 0 : 1;

  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return new Container(
      child: Column(
        children: <Widget>[
          buildNavigationBar(context, "Clock"),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: CupertinoSlidingSegmentedControl(
                        children: clockModeSegments,
                        onValueChanged: (int newValue) {
                          setState(() {
                            clockModeIndex = newValue;
                          });
                          if (newValue == 0) {
                            globals.updateSettings("showClock", "false");
                          } else {
                            globals.updateSettings("showClock", "true");
                            if (newValue == 1) {
                              globals.updateSettings("clockTiming", "12");
                            } else {
                              globals.updateSettings("clockTiming", "24");
                            }
                          }
                        },
                        groupValue: clockModeIndex,
                      )))
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 5, bottom: 10),
                  child: Text(
                    "Style",
                    style: headerStyle,
                  ))
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: CupertinoSlidingSegmentedControl(
                children: clockStyleSegments,
                onValueChanged: (int newValue) {
                  setState(() {
                    clockStyleIndex = newValue;
                  });
                  if (newValue == 0) {
                    globals.updateSettings("clock", "classic");
                  } else {
                    globals.updateSettings("clock", "modern");
                  }
                },
                groupValue: clockStyleIndex,
              ))
            ],
          ),
          pageNavigationButton("Color", ColorPickerPage()),
          Spacer()
        ],
      ),
    );
  });
}
