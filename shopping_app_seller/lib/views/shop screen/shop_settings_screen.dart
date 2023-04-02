import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../widgets/custom_textfield.dart';
import '../../widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator()
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.updateShop(
                        shopaddress: controller.shopAddresseController.text,
                        shopname: controller.shopNameController.text,
                        shopdesc: controller.shopDescController.text,
                        shopmobile: controller.shopMobileController.text,
                        shopwebsite: controller.shopWebsiteController.text,
                      );
                      VxToast.show(context, msg: "Updated shop");
                    },
                    child: normalText(text: save)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //shop name
              customTextfield(
                label: shopName,
                hint: nameHint,
                controller: controller.shopNameController,
              ),

              10.heightBox,

              //shop address
              customTextfield(
                label: address,
                hint: shopAddressHint,
                controller: controller.shopAddresseController,
              ),

              10.heightBox,

              //shop mobile number
              customTextfield(
                label: mobile,
                hint: shopMobileHint,
                controller: controller.shopMobileController,
              ),

              10.heightBox,

              //shop website name
              customTextfield(
                label: website,
                hint: shopWebsiteHint,
                controller: controller.shopWebsiteController,
              ),

              10.heightBox,

              //description
              customTextfield(
                label: description,
                hint: shopDescHint,
                isDesc: true,
                controller: controller.shopDescController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
