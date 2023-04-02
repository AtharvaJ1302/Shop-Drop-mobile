import 'package:emart_app/consts/consts.dart';
import 'package:flutter/cupertino.dart';

Widget orderPlaceDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //left side column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.fontFamily(semibold).make(),
            "$d1".text.color(redColor).fontFamily(semibold).make(),
          ],
        ),

        //right side column
        SizedBox(
          width: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.fontFamily(semibold).color(redColor).make(),
              "$d2".text.make(),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget orderPlaceDetails2({
  title1,
  title2,
  showDone,
  showDone2,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //left side column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.fontFamily(semibold).make(),
            showDone
                ? const Text(
                    "Paid",
                    style: TextStyle(color: redColor, fontFamily: semibold),
                  )
                : const Text("Unpaid",
                    style: TextStyle(color: redColor, fontFamily: semibold))
          ],
        ),

        //right side column
        SizedBox(
          width: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.fontFamily(semibold).make(),
              showDone2
                  ? const Text("Delivered",
                      style: TextStyle(color: redColor, fontFamily: semibold))
                  : const Text("Ordered",
                      style: TextStyle(color: redColor, fontFamily: semibold))
            ],
          ),
        ),
      ],
    ),
  );
}
