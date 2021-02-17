// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'settings.dart';
import 'styles.dart';
import 'components.dart';
import 'dart:convert';
import 'globals.dart' as globals;

final double brightnessMin = 0.0;
final double brightnessMax = 100.0;
void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatelessWidget {
  // final WebSocketChannel channel =
  //     IOWebSocketChannel.connect('ws://192.168.68.102:8000');

  // @override
  final Map<int, Widget> modeSegments = const <int, Widget>{
    0: Text("Listen", style: buttonStyle),
    1: Text("Connect", style: buttonStyle),
  };

  Widget build(BuildContext context) {
    // print(globals.channel.);
    return new Scaffold(
        body: StreamBuilder(
            stream: globals.channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                try {
                  globals.data = jsonDecode(snapshot.data);
                } on Exception catch (_) {
                  print('error');
                }
                print(snapshot.hasData);
                return new Container(
                    child: buildContent(globals.data),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40));
              } else {
                return Container(
                  child: Text('Could Not Connect :('),
                  alignment: Alignment.center,
                );
              }
            }));
  }

  StatefulBuilder buildContent(data) {
    // const imageUrl =
    //     "https://i.scdn.co/image/d3acaeb069f37d8e257221f7224c813c5fa6024e";

    String imageUrl = data["imageUrl"];
    bool asleep = data["asleep"] == "true";
    int modeIndex = 0;
    if (data["mode"] == "spotify") {
      modeIndex = 1;
    }
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
              overflow: TextOverflow.ellipsis,
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
              margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Container(
                            padding: EdgeInsets.all(5.0),
                            margin: EdgeInsets.all(4.0),
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 15,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  imageUrl,
                                  scale: 0.10,
                                )))),
                    Row(children: [
                      Expanded(
                          child: new Text(
                        data["albumName"] ?? "Not Playing",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500),
                        maxLines: 1,
                      ))
                    ]),
                    Row(children: [
                      Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: new Text(
                            data["artistName"] ?? " ",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.fade,
                          ))
                    ])
                  ])),
          // Spacer(),
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "QUICK SETTINGS",
                                style: TextStyle(
                                    color: Color(0xff9d9d9d),
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          )),
                      Row(
                        children: <Widget>[
                          Text(
                            "Brightness",
                            style: headerStyle,
                          )
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 11, top: 10),
                          child: Row(children: <Widget>[
                            Expanded(
                              child: CupertinoSlider(
                                  value: sliderValue,
                                  onChanged: (newv) {
                                    setState(() {
                                      sliderValue = newv;
                                    });
                                    globals.updateSettings(
                                        "brightness", newv.round().toString());
                                  },
                                  min: brightnessMin,
                                  max: brightnessMax),
                            )
                          ])),
                      Row(
                        children: <Widget>[
                          Text(
                            "Mode",
                            style: headerStyle,
                          )
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                  child: CupertinoSlidingSegmentedControl(
                                children: modeSegments,
                                onValueChanged: (int newValue) {
                                  setState(() {
                                    modeIndex = newValue;
                                  });
                                  if (newValue == 0) {
                                    globals.updateSettings("mode", "listen");
                                  }
                                  if (newValue == 1) {
                                    globals.updateSettings("mode", "spotify");
                                  }
                                },
                                groupValue: modeIndex,
                              ))
                            ],
                          )),
                      Spacer(),
                      (() {
                        if (data["mode"] == "listen") {
                          return Column(children: [
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: FlatButton(
                                      color: Color(0xffe5e5e7),
                                      splashColor: Colors.transparent,
                                      onPressed: () {
                                        globals.updateSettings(
                                            "listenTrigger", "true");
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                new CupertinoAlertDialog(
                                                  title:
                                                      new Text("Listening..."),
                                                  content:
                                                      CupertinoActivityIndicator(
                                                    animating: true,
                                                  ),
                                                ));
                                        new Future.delayed(
                                            Duration(seconds: 15), () {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Text(
                                        "Listen Now",
                                        style: buttonStyle,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.0))),
                                )
                              ],
                            ),
                          ]);
                        }
                        return Column(children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: FlatButton(
                                    color: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onPressed: () => {},
                                    child: Text(
                                      "",
                                      style: buttonStyle,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0))),
                              )
                            ],
                          ),
                        ]);
                      }()),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                                color: Color(0xffe5e5e7),
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  asleep = !asleep;
                                  globals.updateSettings(
                                      "asleep", asleep.toString());
                                },
                                child: Text(
                                  asleep ? "Wake" : "Sleep",
                                  style: buttonStyle,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0))),
                          )
                        ],
                      ),
                    ],
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ))),
        ],
      );
    });
  }
}

// class AlbumCover extends StatelessWidget {
//   Widget build(BuildContext buildContext) {}
// }
