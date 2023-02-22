import 'package:flutter/material.dart';

class FontModel {
  FontModel({this.fontWeight, this.color, this.fontSize});
  FontWeight? fontWeight;
  Color? color;
  double? fontSize;

  TextStyle titleStyle() {
    return TextStyle(fontWeight: fontWeight, fontSize: fontSize!, color: color);
  }
}
