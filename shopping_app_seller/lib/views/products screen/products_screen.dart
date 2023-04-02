// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/controllers/products_controller.dart';
import 'package:emart_seller/views/products%20screen/product_details.dart';
import 'package:emart_seller/widgets/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../const/const.dart';

import 'package:intl/intl.dart' as intl;

import '../../const/firebase_const.dart';
import '../../const/images.dart';
import '../../services/store_services.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/text_style.dart';
import 'add_product.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());

    return Scaffold(
      backgroundColor: whiteColor,

      //plus button to add products
      floatingActionButton: FloatingActionButton(
        backgroundColor: red,
        onPressed: () async {
          await controller.getCategories();
          controller.populateCategoryList();
          Get.to(() => AddProduct());
        },
        child: Icon(Icons.add),
      ),
      appBar: appbarWidget(products),
      body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                      data.length,

                      //product card
                      (index) => Card(
                        child: ListTile(
                          onTap: () {
                            Get.to(() => ProductDetails(
                                  data: data[index],
                                ));
                          },
                          leading: Image.network(
                            data[index]['p_images'][0],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          title: boldText(
                              text: "${data[index]['p_name']}",
                              color: fontGrey),
                          subtitle: Row(
                            children: [
                              normalText(
                                  text: "${data[index]['p_price']}",
                                  color: darkGrey),
                              10.widthBox,
                              boldText(
                                  text: data[index]['is_featured'] == true
                                      ? "featured"
                                      : "",
                                  color: green),
                              10.widthBox,
                              boldText(
                                  text: data[index]['is_top'] == true
                                      ? "Top-cat"
                                      : "",
                                  color: Colors.red),
                            ],
                          ),
                          trailing: VxPopupMenu(
                            arrowSize: 0.0,
                            menuBuilder: () => Column(
                              children: List.generate(
                                popupMenuTitles.length,
                                (i) => Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(popupMenuIcons[i],
                                          color: data[index]['featured_id'] ==
                                                          currentUser!.uid &&
                                                      i == 0 ||
                                                  data[index]['top_id'] ==
                                                          currentUser!.uid &&
                                                      i == 1
                                              ? green
                                              : darkGrey),
                                      5.widthBox,
                                      normalText(
                                          text: data[index]['featured_id'] ==
                                                      currentUser!.uid &&
                                                  i == 0
                                              ? 'Remove Featured'
                                              : data[index]['top_id'] ==
                                                          currentUser!.uid &&
                                                      i == 1
                                                  ? 'Remove Top-cat'
                                                  : popupMenuTitles[i],
                                          color: darkGrey),
                                      10.widthBox,
                                    ],
                                  ).onTap(() {
                                    switch (i) {
                                      case 0:
                                        if (data[index]['is_featured'] ==
                                            true) {
                                          controller
                                              .removeFeatured(data[index].id);
                                          VxToast.show(context, msg: "Removed");
                                        } else {
                                          controller
                                              .addFeatured(data[index].id);
                                          VxToast.show(context, msg: "Added");
                                        }

                                        break;

                                      case 1:
                                        if (data[index]['is_top'] == true) {
                                          controller
                                              .removeTopProd(data[index].id);
                                          VxToast.show(context, msg: "Removed");
                                        } else {
                                          controller.addTopProd(data[index].id);
                                          VxToast.show(context, msg: "Added");
                                        }

                                        break;

                                      case 2:
                                        controller
                                            .removeProduct(data[index].id);
                                        VxToast.show(context,
                                            msg: "Product Removed");
                                        break;
                                    }
                                    VxPopupMenuController().hideMenu();
                                  }),
                                ),
                              ),
                            ).box.white.rounded.width(200).make(),
                            clickType: VxClickType.singleClick,
                            child: Icon(Icons.more_vert_rounded),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
