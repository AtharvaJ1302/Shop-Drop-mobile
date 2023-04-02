// ignore_for_file: prefer_const_constructors

import 'package:emart_seller/widgets/text_style.dart';

import '../const/const.dart';

Widget ourButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: color,
        padding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
    onPressed: onPress,
    child: normalText(text: title, size: 16.0),
  );
}
