import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category%20screen/category_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget featuredButton({String? title, icon}) {
  //var controller = Get.put(ProductController());
  return Row(
    children: [
      Image.asset(
        icon,
        width: 50,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .roundedSM
      .width(170)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .padding(const EdgeInsets.all(4))
      .white
      .outerShadowSm
      .make()
      .onTap(() {
        Get.to(()=>CategoryDetails(title: title));
  });
}
