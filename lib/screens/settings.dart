import 'package:flutter/material.dart';
import '../data/shared_prefs.dart';
import '../models/font_size.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;

  List<int> colors = [
    0xFF455A64,
    0xFFFFC107,
    0xFF673AB7,
    0xFFF57C00,
    0xFF795548
  ];

  SPSettings settings = SPSettings();
  final List<FontSize> fontSizes = [
    FontSize('small', 12),
    FontSize('medium', 16),
    FontSize('large', 20),
    FontSize('extra-large', 24),
  ];

  @override
  void initState() {
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: fontSize,
            color: Color(settingColor),
          ),
        ),
        backgroundColor: Color(settingColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Choose a Font Size for the App',
            style: TextStyle(
              fontSize: fontSize,
              color: Color(settingColor),
            ),
          ),
          DropdownButton(
            value: fontSize.toString(),
            items: getDropdownMenuItems(),
            onChanged: changeSize,
          ),
          Text(
            'App Main Color',
            style: TextStyle(
              fontSize: fontSize,
              color: Color(settingColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => setColor(colors[0]),
                child: ColorSquare(colors[0]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[1]),
                child: ColorSquare(colors[1]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[2]),
                child: ColorSquare(colors[2]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[3]),
                child: ColorSquare(colors[3]),
              ),
              GestureDetector(
                onTap: () => setColor(colors[4]),
                child: ColorSquare(colors[4]),
              ),
            ],
          )
        ],
      ),
    );
  }

  void setColor(int color) {
    setState(() {
      settingColor = color;
      settings.setColor(color);
    });
  }

  List<DropdownMenuItem<String>> getDropdownMenuItems() {
    List<DropdownMenuItem<String>> items = [];

    for (FontSize fontSizet in fontSizes) {
      items.add(
        DropdownMenuItem(
          value: fontSizet.size.toString(),
          child: Text(fontSizet.name),
        ),
      );
    }
    return items;
  }

  void changeSize(String? newSize) {
    settings.setFontSize(double.parse(newSize ?? '14'));
    setState(() {
      fontSize = double.parse(newSize ?? '14');
    });
  }
}

class ColorSquare extends StatelessWidget {
  final int colorCode;
  const ColorSquare(this.colorCode);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color(colorCode),
      ),
    );
  }
}
