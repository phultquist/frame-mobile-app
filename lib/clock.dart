import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'components.dart';
import 'styles.dart';
import 'colorpicker.dart';
import 'globals.dart' as globals;

FocusNode firstFocusNode = new FocusNode();

final Map<int, Widget> idleModeSegments = const <int, Widget>{
  0: Text("Off", style: buttonStyle),
  1: Text("12 Hour", style: buttonStyle),
  2: Text("24 Hour", style: buttonStyle),
  3: Text("Dance", style: buttonStyle)
};

final Map<int, Widget> clockStyleSegments = const <int, Widget>{
  0: Text("Classic", style: buttonStyle),
  1: Text("Modern", style: buttonStyle),
};

final Map<int, Widget> danceStyleSegments = const <int, Widget>{
  0: Text("Egyptian", style: buttonStyle),
  1: Text("Brick", style: buttonStyle),
  2: Text("Rap", style: buttonStyle)
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
  int idleModeIndex = 0;
  int danceStyleIndex = 0;
  String idleMode = globals.data["idleMode"];
  if (idleMode != "false" || idleMode != "off") {
    if (idleMode == "clock") {
      if (globals.data["clockTiming"] == "12") {
        idleModeIndex = 1;
      } else {
        idleModeIndex = 2;
      }
    } else if (idleMode.startsWith("gif")) {
      idleModeIndex = 3;
      switch (idleMode.split(":")[1]) {
        case "brick":
          {
            danceStyleIndex = 1;
          }
          break;
        case "rap":
          {
            danceStyleIndex = 2;
          }
          break;
      }
    }
  }

  int clockStyleIndex = globals.data["clock"] == "classic" ? 0 : 1;

  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return new Container(
      child: Column(
        children: <Widget>[
          buildNavigationBar(context, "Clock & Dance"),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: CupertinoSlidingSegmentedControl(
                        children: idleModeSegments,
                        onValueChanged: (int newValue) {
                          setState(() {
                            idleModeIndex = newValue;
                          });

                          switch (newValue) {
                            case 0:
                              {
                                globals.updateSettings("idleMode", "false");
                              }
                              break;
                            case 1:
                              {
                                globals.updateSettings("idleMode", "clock");
                                globals.updateSettings("clockTiming", "12");
                              }
                              break;
                            case 2:
                              {
                                globals.updateSettings("idleMode", "clock");
                                globals.updateSettings("clockTiming", "24");
                              }
                              break;
                            case 3:
                              {
                                globals.updateSettings("idleMode", "gif");
                              }
                              break;
                          }
                        },
                        groupValue: idleModeIndex,
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
                  child: Container(
                      margin: EdgeInsets.only(bottom: 10),
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
                      )))
            ],
          ),
          pageNavigationButton("Color", ColorPickerPage()),
          (() {
            if (idleModeIndex == 3) {
              return Column(
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 5, bottom: 10),
                          child: Text(
                            "Dance",
                            style: headerStyle,
                          ))
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: CupertinoSlidingSegmentedControl(
                                children: danceStyleSegments,
                                onValueChanged: (int newValue) {
                                  setState(() {
                                    danceStyleIndex = newValue;
                                  });
                                  String idleModeSettingText = "false";
                                  switch (newValue) {
                                    case 0:
                                      {
                                        idleModeSettingText = "gif:egypt";
                                      }
                                      break;
                                    case 1:
                                      {
                                        idleModeSettingText = "gif:brick";
                                      }
                                      break;
                                    case 2:
                                      {
                                        idleModeSettingText = "gif:rap";
                                      }
                                      break;
                                  }
                                  globals.updateSettings(
                                      "idleMode", idleModeSettingText);
                                },
                                groupValue: danceStyleIndex,
                              )))
                    ],
                  )
                ],
              );
            } else
              return Row();
          })(),
          Spacer()
        ],
      ),
    );
  });
}
