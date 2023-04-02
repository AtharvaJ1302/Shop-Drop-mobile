// ignore_for_file: prefer_const_constructors

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category%20screen/category_details.dart';
import 'package:emart_app/widgets%20common/bg_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 200,
                  crossAxisSpacing: 8),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      newcatImages[index],
                      height: 130,
                      width: 200,
                      fit: BoxFit.fill,
                    ),
                    10.heightBox,
                    newCat[index]
                        .text
                        .align(TextAlign.center)
                        .color(darkFontGrey)
                        .make(),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .clip(Clip.antiAlias)
                    .outerShadowMd
                    .make()
                    .onTap(() {
                  controller.getSubCategories(newCat[index]);
                  Get.to(() => CategoryDetails(title: newCat[index]));
                });
              }),
        ),
      ),
    );
  }
}
