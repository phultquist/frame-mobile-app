import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'components.dart';
import 'styles.dart';
import 'colorpicker.dart';

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
  int clockStyleIndex = 0;
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return new Container(
      child: Column(
        children: <Widget>[
          buildNavigationBar(context, "Clock"),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: CupertinoSlidingSegmentedControl(
                children: clockModeSegments,
                onValueChanged: (int newValue) {
                  setState(() {
                    clockModeIndex = newValue;
                  });
                },
                groupValue: clockModeIndex,
              ))
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Style",
                style: headerStyle,
              )
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
