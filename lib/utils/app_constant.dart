import 'package:flutter/material.dart';

class AppConstant{
  static Widget kLoading = const Center(
    child: CircularProgressIndicator(),
  );

  //Custom SnackBar
  static customToast({required BuildContext context, required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}