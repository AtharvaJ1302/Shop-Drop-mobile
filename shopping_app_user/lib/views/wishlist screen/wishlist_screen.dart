import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets%20common/loading_indicator.dart';
import 'package:flutter/material.dart';

import '../../consts/firebase_const.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title:
            "My Wishlist".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No items in wishlist"
                .text
                .color(darkFontGrey)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                            '${data[index]['p_images'][0]}',
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          title: "${data[index]['p_name']}"
                              .text
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          subtitle: "${data[index]['p_price']}"
                              .numCurrency
                              .text
                              .size(14)
                              .color(redColor)
                              .fontFamily(semibold)
                              .make(),

                          //delete button
                          trailing: const Icon(
                            Icons.favorite,
                            color: redColor,
                          ).onTap(() async {
                            await firestore
                                .collection(productsCollection)
                                .doc(data[index].id)
                                .set({
                              'p_wishlist':
                                  FieldValue.arrayRemove([currentUser!.uid]),
                            }, SetOptions(merge: true));
                          }),
                        );
                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
