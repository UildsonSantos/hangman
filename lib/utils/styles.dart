import 'package:flutter/material.dart';

TextStyle retroStyle({double? size, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    fontFamily: "RetroGaming",
    color: color ?? Colors.black,
    fontSize: size ?? 18,
    fontWeight: fontWeight ?? FontWeight.normal,
  );
}
