// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:intl/intl.dart' as intl; //new
import '../../../const/firebase_const.dart';
import '../../../widgets/text_style.dart';

Widget chatBubble() {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: purpleColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          normalText(text: "Your message here"),
          10.heightBox,
          normalText(text: "10:45 PM"),
        ],
      ),
    ),
  );
}
