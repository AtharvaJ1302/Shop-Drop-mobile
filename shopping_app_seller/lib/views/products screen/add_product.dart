// ignore_for_file: prefer_const_constructors, unused_local_variable, use_build_context_synchronously

import 'package:emart_seller/controllers/products_controller.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:get/get.dart';
import '../../const/const.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/text_style.dart';
import 'components/product_dropdown.dart';
import 'components/product_images.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();

    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
              )),
          title: boldText(text: "Add product", size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator()
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.uploadImages();
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(text: save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //product name
                customTextfield(
                    hint: "BMW",
                    label: "Product Name",
                    controller: controller.pnameController),

                10.heightBox,

                //product description
                customTextfield(
                    hint: "Nice product",
                    label: "Description",
                    isDesc: true,
                    controller: controller.pdescController),

                10.heightBox,

                //product price
                customTextfield(
                    hint: "\$100",
                    label: "Price",
                    controller: controller.ppriceController),

                10.heightBox,

                //product quantity
                customTextfield(
                    hint: "20",
                    label: "Quantity",
                    controller: controller.pquantityController),

                10.heightBox,

                //select category dropdown
                productDropdown("Category", controller.categoryList,
                    controller.categoryvalue, controller),

                10.heightBox,

                //select sub-category dropdown
                productDropdown("Subcategory", controller.subcategoryList,
                    controller.subcategoryvalue, controller),

                10.heightBox,
                Divider(
                  color: whiteColor,
                ),

                //images
                boldText(text: "Choose product images"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => controller.pImagesList[index] != null
                          ? Image.file(
                              controller.pImagesList[index],
                              width: 100,
                              height: 100,
                            ).onTap(() {
                              controller.pickImage(index, context);
                            })
                          : productImages(label: "${index + 1}").onTap(() {
                              controller.pickImage(index, context);
                            }),
                    ),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "first image will be display image",
                    color: lightGrey),

                10.heightBox,
                Divider(
                  color: whiteColor,
                ),

                //color choose
                /* boldText(text: "Choose product colors"),

                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                      9,
                      (index) => Stack(
                        alignment: Alignment.center,
                        children: [
                          VxBox()
                              .color(Vx.randomPrimaryColor)
                              .roundedFull
                              .size(65, 65)
                              .make()
                              .onTap(() {
                            controller.selectedColorIndex.value = index;
                          }),
                          controller.selectedColorIndex.value == index
                              ? const Icon(
                                  Icons.done,
                                  color: whiteColor,
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
