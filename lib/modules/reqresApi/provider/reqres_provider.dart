import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_http/modules/reqresApi/service/reqres_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/user_model.dart';

class ReqresProvider extends ChangeNotifier {
  final ReqresService _reqresService = ReqresService();
  List<ReqresUserModel> userDataList = [];
  bool isLoading = false;
  bool isError = false;

  ReqresProvider() {
    log('onInit() called-------');
    getUserData();
  }

  //get method http----------
  Future<void> getUserData() async {
    try {
      isLoading = true;
      var result = await _reqresService.reqresUserData();

      if (result.statusCode == 200) {
        log('ALL BODY DATA===> ${result.body}'); //show console
        final myBodyData = jsonDecode(result.body);
        final myData = myBodyData['data'] as List<dynamic>;

        final transformedList = myData.map((data) => ReqresUserModel(
                id: data['id'],
                email: data['email'],
                first_name: data['first_name'],
                last_name: data['last_name'],
                avatar: data['avatar'])).toList();

        userDataList = transformedList; //assign data the list
        log('DATA LENGTH = ${userDataList.length}');
      }
    } catch (e) {
      log('error------------> $e');
      Fluttertoast.showToast(msg: 'Something went wrong');
      isError = true;
    } finally {
      log('finally==============>');
      isLoading = false;
    }
    notifyListeners(); // Update UI
  }
}
