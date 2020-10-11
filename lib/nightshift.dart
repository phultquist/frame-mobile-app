import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'components.dart';
import 'styles.dart';

final Map<int, Widget> nightShiftSegments = const <int, Widget>{
  0: Text("On", style: buttonStyle),
  1: Text("Off", style: buttonStyle),
};

class NightShiftPage extends StatelessWidget {
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
  int nightShiftIndex = 0;
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return new Container(
      child: Column(
        children: <Widget>[
          buildNavigationBar(context, "Night Shift"),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: CupertinoSlidingSegmentedControl(
                children: nightShiftSegments,
                onValueChanged: (int newValue) {
                  setState(() {
                    nightShiftIndex = newValue;
                  });
                },
                groupValue: nightShiftIndex,
              ))
            ],
          ),
          Spacer()
        ],
      ),
    );
  });
}
