import '../../../const/const.dart';
import '../../../widgets/text_style.dart';

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
            boldText(text: "$title1", color: purpleColor),
            boldText(text: "$d1", color: red)
          ],
        ),

        //right side column
        SizedBox(
          width: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: "$title2", color: purpleColor),
              boldText(text: "$d2", color: red)
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
            "$title1".text.make(),
            showDone
                ? const Text(
                    "Paid",
                    style: TextStyle(
                      color: red,
                    ),
                  )
                : const Text("Unpaid",
                    style: TextStyle(
                      color: red,
                    ))
          ],
        ),

        //right side column
        SizedBox(
          width: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.make(),
              showDone2
                  ? const Text("Delivered",
                      style: TextStyle(
                        color: red,
                      ))
                  : const Text("Ordered",
                      style: TextStyle(
                        color: red,
                      ))
            ],
          ),
        ),
      ],
    ),
  );
}
