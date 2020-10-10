import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'styles.dart';

FocusNode firstFocusNode = new FocusNode();

final Map<int, Widget> abSegments = const <int, Widget>{
  0: Text("On", style: buttonStyle),
  1: Text("Off", style: buttonStyle),
};

final Map<int, Widget> animationSegments = const <int, Widget>{
  0: Text("Off", style: buttonStyle),
  1: Text("Slow", style: buttonStyle),
  2: Text("Normal", style: buttonStyle),
  3: Text("Fast", style: buttonStyle),
};

final Map<int, Widget> pauseSegments = const <int, Widget>{
  0: Text("On", style: buttonStyle),
  1: Text("Off", style: buttonStyle),
};

class SettingsPage extends StatelessWidget {
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
  int abIndex = 0;
  int animationIndex = 0;
  int pauseIndex = 0;
  final frameNameController = TextEditingController();

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
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
                child: CupertinoSlidingSegmentedControl(
              children: animationSegments,
              onValueChanged: (int newValue) {
                setState(() {
                  animationIndex = newValue;
                });
              },
              groupValue: animationIndex,
            ))
          ],
        ),
        pageNavigationButton("Night Shift"),
        pageNavigationButton("Autosleep"),
        pageNavigationButton("Clock"),
        Row(
          children: <Widget>[
            Text(
              "Show Paused Icon",
              style: headerStyle,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
                child: CupertinoSlidingSegmentedControl(
              children: pauseSegments,
              onValueChanged: (int newValue) {
                setState(() {
                  pauseIndex = newValue;
                });
              },
              groupValue: pauseIndex,
            ))
          ],
        ),
      ],
    ));
  });
}

Widget pageNavigationButton(String text) {
  return GestureDetector(
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
        )),
    onTap: () {
      print('$text row tapped');
    },
    onTapDown: (details) {
      print('tapped down');
    },
    behavior: HitTestBehavior.translucent,
  );
}
