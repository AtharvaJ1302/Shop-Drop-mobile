// ignore_for_file: prefer_const_constructors

import 'package:emart_seller/widgets/text_style.dart';
import '../const/const.dart';

Widget customTextfield({label, hint, controller, isDesc = false}) {
  return TextFormField(
    style: TextStyle(color: whiteColor),
    controller: controller,
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label),
      hintText: hint,
      hintStyle: TextStyle(color: lightGrey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: whiteColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: whiteColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: red),
      ),
    ),
  );
}
