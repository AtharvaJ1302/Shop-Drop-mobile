// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category%20screen/item_details.dart';
import 'package:emart_app/widgets%20common/bg_widget.dart';
import 'package:emart_app/widgets%20common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubcategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  //var controller = Get.find<ProductController>();
  var controller = Get.put(ProductController());

  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<ProductController>();

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: widget.title!.text.fontFamily(bold).white.make(),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        controller.subcat.length,
                        (index) => "${controller.subcat[index]}"
                                .text
                                .size(12)
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .makeCentered()
                                .box
                                .margin(EdgeInsets.symmetric(horizontal: 4))
                                .rounded
                                .size(150, 60)
                                .white
                                .make()
                                .onTap(() {
                              switchCategory("${controller.subcat[index]}");
                              setState(() {});
                            })),
                  ),
                ),
                20.heightBox,
                StreamBuilder(
                  stream: productMethod,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        child: Center(
                          child: loadingIndicator(),
                        ),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Expanded(
                        child: "No products found"
                            .text
                            .color(darkFontGrey)
                            .makeCentered(),
                      );
                    } else {
                      var data = snapshot.data!.docs;

                      // 20.heightBox,

                      //items container
                      return Expanded(
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 250,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_images'][0],
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ).box.roundedSM.clip(Clip.antiAlias).make(),
                                    "${data[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${data[index]['p_price']}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .roundedSM
                                    .outerShadowMd
                                    .margin(EdgeInsets.symmetric(horizontal: 4))
                                    .padding(EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  controller.checkIffav(data[index]);
                                  Get.to(() => ItemDetails(
                                        title: "${data[index]['p_name']}",
                                        data: data[index],
                                      ));
                                });
                              }));
                    }
                  },
                ),
              ],
            )));
  }
}
