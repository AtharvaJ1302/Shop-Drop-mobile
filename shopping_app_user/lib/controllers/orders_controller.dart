import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import '../consts/firebase_const.dart';

class OrdersController extends GetxController {
  var orders = [];

  var confirmed = false.obs;
  var ondelivery = false.obs;
  var delivered = false.obs;
  var paymentstatus = false.obs;
  var deliverystatus = false.obs;

  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        orders.add(item);
      }
    }
  }

  changeStatus({status, docId, title}) async {
    var store = firestore.collection(ordersCollection).doc(docId);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
