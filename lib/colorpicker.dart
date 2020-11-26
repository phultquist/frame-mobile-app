import 'package:flutter/material.dart';
import 'components.dart';
import 'globals.dart' as globals;

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
    Color(0xffef0e0e),
    Color(0xff0cf5d9),
    Color(0xfffde400),
    Color(0xff6804e7),
    Color(0xffff9900),
    Color(0xff000000),
    Color(0xffe500ea),
    Color(0xffffffff),
    Color(0xff1dcc00),
    Color(0xff364886),
    Color(0xff1677e9),
    Color(0xffaae6ff),
    Color(0xffffb8b8),
    Color(0xffb1ff9d),
    Color(0xff959595),
    Color(0xffc29cff),
    Color(0xff1100cf),
    Color(0xffe8c300),
    Color(0xfffebdff),
    Color(0xff287e00)
  ];

  int selectedIndex = 0;
  dynamic rgb = globals.data["clockColor"].split(",");
  for (int i = 0; i < colors.length; i++) {
    Color c = colors[i];
    print(c.red + c.green + c.blue);
    if (c.red == int.parse(rgb[0]) &&
        c.green == int.parse(rgb[1]) &&
        c.blue == int.parse(rgb[2])) {
      selectedIndex = i;
    }
  }

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
              width: 55.0,
              height: 55.0,
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
            Color selectedColor = colors[selectedIndex];
            String rgbConverted = selectedColor.red.toString() +
                "," +
                selectedColor.green.toString() +
                "," +
                selectedColor.blue.toString();
            globals.updateSettings("clockColor", rgbConverted);
          },
        ));
      }
      rows.add(Row(
          children: row, mainAxisAlignment: MainAxisAlignment.spaceBetween));
    }
    return Column(
      children: rows,
    );
  });
}
