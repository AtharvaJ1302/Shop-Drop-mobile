// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../const/const.dart';
import '../../const/images.dart';
import '../../widgets/text_style.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkGrey,
            )),
        title: boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
              autoPlay: true,
              height: 350,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              itemCount: data['p_images'].length,
              itemBuilder: (context, index) {
                return Image.network(
                  data['p_images'][index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //product name
                  boldText(
                      text: "${data['p_name']}", color: fontGrey, size: 16.0),

                  10.heightBox,

                  //category and subcategory
                  Row(
                    children: [
                      boldText(
                          text: "${data['p_category']}",
                          color: fontGrey,
                          size: 16.0),
                      10.widthBox,
                      normalText(
                          text: "${data['p_subcategory']}",
                          color: fontGrey,
                          size: 16.0),
                    ],
                  ),

                  10.heightBox,

                  //rating
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    size: 25,
                    count: 5,
                    maxRating: 5,
                  ),

                  10.heightBox,

                  boldText(text: "${data['p_price']}", color: red, size: 18.0),

                  20.heightBox,

                  //colors section
                  Column(
                    children: [
                      /*Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Colors", color: fontGrey),
                          ),
                          Row(
                            children: List.generate(
                              2,
                              (index) => VxBox()
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 6))
                                  .color(Color(data['p_colors'][index]))
                                  .size(40, 40)
                                  .roundedFull
                                  .make()
                                  .onTap(() {}),
                            ),
                          )
                        ],
                      ),*/

                      10.heightBox,

                      //quantity section
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Quantity", color: fontGrey),
                          ),
                          normalText(
                              text: "${data['p_quantity']} items",
                              color: fontGrey),
                        ],
                      ),
                    ],
                  ).box.white.padding(const EdgeInsets.all(8)).make(),

                  Divider(),

                  20.heightBox,
                  boldText(text: "Description", color: fontGrey),
                  10.heightBox,
                  normalText(text: "${data['p_desc']}", color: fontGrey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
