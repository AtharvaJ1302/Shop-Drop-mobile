import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/category%20screen/category_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .white
      .roundedSM
      .outerShadowSm
      .margin(const EdgeInsets.symmetric(horizontal: 5))
      .padding(const EdgeInsets.all(5))
      .width(180)
      .make()
      .onTap(() {
    Get.to(() => CategoryDetails(title: title));
  });
}
