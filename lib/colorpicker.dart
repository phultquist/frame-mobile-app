import 'package:flutter/material.dart';
import 'components.dart';

const int colorsPerRow = 4;

class ColorPickerPage extends StatelessWidget {
  Widget build(BuildContext buildContext) {
    return new Scaffold(
        body: new GestureDetector(
      child: new Container(
          child: buildContent(),
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50)),
      onTap: () {},
      behavior: HitTestBehavior.translucent,
    ));
  }
}

StatefulBuilder buildContent() {
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return new Container(
      child: Column(
        children: <Widget>[
          buildNavigationBar(context, "Color"),
          Row(),
          buildColorPicker(),
          Spacer()
        ],
      ),
    );
  });
}

StatefulBuilder buildColorPicker() {
  List<Color> colors = [
    Color(0xffff0000),
    Color(0xff00ff00),
    Color(0xff0000ff),
    Color(0xff000000),
    Color(0xffffff00),
    Color(0xff00ffff),
    Color(0xff3f15ff),
    Color(0xff00e312),
    Color(0xffffffff),
    Color(0xff0f97f3),
    Color(0xffe59999),
    Color(0xffa4a5a6)
  ];
  int selectedIndex = 1;

  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    List<Row> rows = [];

    for (int i = 0; i < colors.length; i += colorsPerRow) {
      List<GestureDetector> row = [];
      int rowSize = colorsPerRow;
      if (colors.length - i < 4) {
        rowSize = colors.length - i;
      }
      for (int j = 0; j < rowSize; j++) {
        row.add(GestureDetector(
          child: Container(
              child: Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors[i + j],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                alignment: Alignment.center,
              ),
              width: 50.0,
              height: 50.0,
              margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              padding: const EdgeInsets.all(5.0),
              // color: Colors.grey.shade300
              decoration: new BoxDecoration(
                  color: selectedIndex == i + j
                      ? Colors.grey.shade300
                      : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              alignment: Alignment.center),
          onTap: () {
            setState(() {
              selectedIndex = i + j;
            });
          },
        ));
      }
      rows.add(
          Row(children: row, mainAxisAlignment: MainAxisAlignment.spaceAround));
    }
    return Column(
      children: rows,
    );
  });
}
