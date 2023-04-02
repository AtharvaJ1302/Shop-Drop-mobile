import 'package:flutter/material.dart';
import '../const/colors.dart';

Widget loadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(red),
    ),
  );
}
