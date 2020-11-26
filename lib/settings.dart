import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'styles.dart';
import 'nightshift.dart';
import 'components.dart';
import 'autosleep.dart';
import 'clock.dart';
import 'globals.dart' as globals;

FocusNode firstFocusNode = new FocusNode();

final Map<int, Widget> abSegments = const <int, Widget>{
  0: Text("On", style: buttonStyle),
  1: Text("Off", style: buttonStyle),
};

final Map<int, Widget> animationSegments = const <int, Widget>{
  0: Text("Fast", style: buttonStyle),
  1: Text("Normal", style: buttonStyle),
  2: Text("Slow", style: buttonStyle),
  3: Text("Off", style: buttonStyle),
};

final Map<int, Widget> pauseSegments = const <int, Widget>{
  0: Text("On", style: buttonStyle),
  1: Text("Off", style: buttonStyle),
};

class SettingsPage extends StatelessWidget {
  final String frameName;

  SettingsPage({Key key, @required this.frameName}) : super(key: key);

  Widget build(BuildContext buildContext) {
    print(frameName);
    return new Scaffold(
        body: new GestureDetector(
      child: new Container(
          child: buildContent(frameName),
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50)),
      onTap: () {
        print('tapped!');
        FocusScope.of(buildContext).requestFocus(new FocusNode());
      },
      behavior: HitTestBehavior.translucent,
    ));
  }
}

StatefulBuilder buildContent(frameName) {
  int abIndex = 0;
  int animationIndex = 3;

  int currentAnimation = int.parse(globals.data["animation"]);
  if (currentAnimation == 1) {
    // do nothing
  } else if (currentAnimation <= 6) {
    animationIndex = 0;
  } else if (currentAnimation <= 12) {
    animationIndex = 1;
  } else {
    animationIndex = 2;
  }

  int pauseIndex = 0;
  final frameNameController = TextEditingController(text: frameName);

  // void dispose() {
  //   textFieldController.dispose();
  //   super.dispose();
  // }

  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return Container(
        child: Column(
      children: [
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context, frameNameController.text);

                  // Also save all settings
                }),
            Expanded(
                child: TextFormField(
              style: titleStyle,
              focusNode: firstFocusNode,
              controller: frameNameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(border: InputBorder.none),
            )),
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                onPressed: () {
                  print("edit!");
                  FocusScope.of(context).requestFocus(firstFocusNode);
                }),
          ],
        ),
        Row(
          children: <Widget>[Text("Autobrightness", style: headerStyle)],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
                child: CupertinoSlidingSegmentedControl(
              children: abSegments,
              onValueChanged: (int newValue) {
                setState(() {
                  abIndex = newValue;
                });
              },
              groupValue: abIndex,
            ))
          ],
        ),
        Row(
          children: <Widget>[Text("Animation Speed", style: headerStyle)],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
                child: CupertinoSlidingSegmentedControl(
              children: animationSegments,
              onValueChanged: (int newValue) {
                setState(() {
                  animationIndex = newValue;
                });
                if (newValue == 0) {
                  globals.updateSettings("animation", "6");
                } else if (newValue == 1) {
                  globals.updateSettings("animation", "12");
                } else if (newValue == 2) {
                  globals.updateSettings("animation", "18");
                } else {
                  globals.updateSettings("animation", "1");
                }
              },
              groupValue: animationIndex,
            ))
          ],
        ),
        pageNavigationButton("Night Shift", new NightShiftPage()),
        pageNavigationButton("Autosleep", new AutosleepPage()),
        pageNavigationButton("Clock", new ClockPage()),
        // Row(
        //   children: <Widget>[
        //     Text(
        //       "Paused Icon",
        //       style: headerStyle,
        //     ),
        //   ],
        // ),
        // Row(
        //   mainAxisSize: MainAxisSize.max,
        //   children: <Widget>[
        //     Expanded(
        //         child: CupertinoSlidingSegmentedControl(
        //       children: pauseSegments,
        //       onValueChanged: (int newValue) {
        //         setState(() {
        //           pauseIndex = newValue;
        //         });
        //       },
        //       groupValue: pauseIndex,
        //     ))
        //   ],
        // ),
        Spacer(),
        Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                  color: Color(0xffe5e5e7),
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  child: Text(
                    "Restart",
                    style: buttonStyle,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0))),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                  color: Color(0xfff2f2f2),
                  splashColor: Colors.transparent,
                  onPressed: () => {},
                  child: Text(
                    "Restore Defaults",
                    style: buttonStyle.apply(color: Color(0xffee0000)),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0))),
            )
          ],
        )
      ],
    ));
  });
}
