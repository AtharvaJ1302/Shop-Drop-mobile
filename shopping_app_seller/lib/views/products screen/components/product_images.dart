import 'package:emart_seller/widgets/text_style.dart';

import '../../../const/const.dart';

Widget productImages({required label, onPress}) {
  return "$label"
      .text
      .bold
      .color(fontGrey)
      .size(16.0)
      .makeCentered()
      .box
      .roundedSM
      .color(lightGrey)
      .size(100, 100)
      .make();
}
