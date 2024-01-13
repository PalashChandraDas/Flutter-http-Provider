import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../model/JsonHolderPostModel.dart';
import '../service/json_holder_service.dart';

class JsonHolderProvider extends ChangeNotifier {
  final JsonHolderService _jsonHolderService = JsonHolderService();
  List<JsonHolderPostModel> userPostList = [];
  bool isLoading = false;
  bool isError = false;

  JsonHolderProvider() {
    log('onInit() called-------');
    getPostData();
  }

  //get method http----------
  Future<void> getPostData() async {
    try {
      isLoading = true;
      http.Response result = await _jsonHolderService.jsonHolderPostData();

      if (result.statusCode == 200) {
        log('ALL BODY DATA===> ${result.body}'); //show console

        //jsonDecode for retrieve data from server
        List<dynamic> getPostDataList = jsonDecode(result.body);
        for (var i in getPostDataList) {
          userPostList.add(JsonHolderPostModel.fromJson(i));
        }
        log(getPostDataList.toString());
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
