// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets%20common/bg_widget.dart';
import 'package:emart_app/widgets%20common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../controllers/home_controller.dart';
import '../category screen/item_details.dart';

class TopProducts extends StatelessWidget {
  const TopProducts({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    //var controller = Get.find<ProductController>();
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: "Top Products".text.fontFamily(bold).white.make(),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: FirestoreServices.gettopProducts(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: loadingIndicator(),
                      );
                    } else {
                      var topproducts = snapshot.data!.docs;
                      return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: topproducts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 250),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  topproducts[index]['p_images'][0],
                                  // imgP5,
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                Spacer(),
                                "${topproducts[index]['p_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${topproducts[index]['p_price']}"
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make()
                              ],
                            )
                                .box
                                .margin(EdgeInsets.symmetric(horizontal: 4))
                                .white
                                .shadowMd
                                .roundedSM
                                .padding(EdgeInsets.all(12))
                                .make()
                                .onTap(() {
                              Get.to(() => ItemDetails(
                                    title: "${topproducts[index]['p_name']}",
                                    data: topproducts[index],
                                  ));
                            });
                          });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
