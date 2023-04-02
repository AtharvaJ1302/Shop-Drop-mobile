// ignore_for_file: prefer_const_constructors, unused_import

import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget ourButton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      //primary: redColor,
      primary: color,
      padding: EdgeInsets.all(12),
    ),
    onPressed: onPress,
    child: title!.text.color(textColor).fontFamily(bold).make(),
    //child: login.text.white.fontFamily(bold).make(),
  );
}
