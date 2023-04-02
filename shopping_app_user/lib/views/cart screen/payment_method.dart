// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/widgets%20common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets common/our_button.dart';
import '../homescreen/home.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(
      () => Scaffold(
          backgroundColor: whiteColor,
          bottomNavigationBar: SizedBox(
            height: 60,
            child: controller.placingOrder.value
                ? Center(
                    child: loadingIndicator(),
                  )
                : ourButton(
                    onPress: () async {
                      controller.placeMyOrder(
                          orderPaymentMethod:
                              paymentMethods[controller.paymentIndex.value],
                          totalAmount: controller.totalP.value);

                      await controller.clearCart();
                      VxToast.show(context, msg: "Order placed successfully");
                      Get.offAll(Home());
                    },
                    color: redColor,
                    textColor: whiteColor,
                    title: "Place my order",
                  ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: "Choose payment method"
                .text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .make(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Obx(
              () => Column(
                children: List.generate(paymentMethodsImg.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.changePaymentIndex(index);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: controller.paymentIndex.value == index
                                ? redColor
                                : Colors.transparent,
                            width: 4,
                          )),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(
                            paymentMethodsImg[index],
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                            colorBlendMode:
                                controller.paymentIndex.value == index
                                    ? BlendMode.darken
                                    : BlendMode.color,
                            color: controller.paymentIndex.value == index
                                ? Colors.black.withOpacity(0.3)
                                : Colors.transparent,
                          ),
                          controller.paymentIndex.value == index
                              ? Transform.scale(
                                  scale: 1.3,
                                  child: Checkbox(
                                      activeColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      value: true,
                                      onChanged: (value) {}),
                                )
                              : Container(),
                          Positioned(
                              bottom: 0,
                              right: 10,
                              child: paymentMethods[index]
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .white
                                  .make()),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          )),
    );
  }
}
