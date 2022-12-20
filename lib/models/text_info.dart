import 'package:flutter/material.dart';

class TextInfo {
  String text;
  double left;
  double top;
  Color color;
  FontWeight fontWeight;
  FontStyle fontStyle;
  double fontSize;
  TextAlign textAlign;
  TextInfo({
    required this.color,
    required this.fontSize,
    required this.fontStyle,
    required this.fontWeight,
    required this.left,
    required this.text,
    required this.textAlign,
    required this.top,
  });
}
