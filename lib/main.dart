import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'settings.dart';
import 'styles.dart';
import 'components.dart';
import 'dart:convert';
import 'globals.dart' as globals;

final double brightnessMin = 50.0;
final double brightnessMax = 100.0;
void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatelessWidget {
  // final WebSocketChannel channel =
  //     IOWebSocketChannel.connect('ws://192.168.68.102:8000');

  @override
  final Map<int, Widget> modeSegments = const <int, Widget>{
    0: Text("Listen", style: buttonStyle),
    1: Text("Connect", style: buttonStyle),
  };

  Widget build(BuildContext context) {
    return new Scaffold(
        body: StreamBuilder(
            stream: globals.channel.stream,
            builder: (context, snapshot) {
              globals.data = jsonDecode(snapshot.data);
              return new Container(
                  child: buildContent(globals.data),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 50));
            }));
  }

  StatefulBuilder buildContent(data) {
    // const imageUrl =
    //     "https://i.scdn.co/image/d3acaeb069f37d8e257221f7224c813c5fa6024e";
    const imageUrl =
        "https://storage.googleapis.com/file-in.appspot.com/files/AhXcb_9i_c.jpg";

    int modeIndex = 0;
    double sliderValue = double.parse(data["brightness"]);
    if (sliderValue <= brightnessMin || sliderValue > brightnessMax) {
      sliderValue = brightnessMin;
    }
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
          Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //     child: Container(
                    //         padding: EdgeInsets.all(5.0),
                    //         margin: EdgeInsets.all(4.0),
                    //         // height: 100,
                    //         child: Image.network(
                    //           imageUrl,
                    //           scale: 0.10,
                    //         ))),
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
                    ])
                  ])),
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
                    globals.updateSettings(
                        "brightness", newv.round().toString());
                    print(newv);
                  },
                  min: brightnessMin,
                  max: brightnessMax),
            )
          ]),
          Row(
            children: <Widget>[
              Text(
                "Mode",
                style: headerStyle,
              )
            ],
          ),
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
          ),
        ],
      );
    });
  }
}

// class AlbumCover extends StatelessWidget {
//   Widget build(BuildContext buildContext) {}
// }
