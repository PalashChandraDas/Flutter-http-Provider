import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_http/modules/jsonHolderAPI/model/jsonholder_user_post_model.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../service/json_holder_service.dart';

class JsonHolderProvider extends ChangeNotifier {
  final JsonHolderService _jsonHolderService = JsonHolderService();
  List<JsonHolderUserPostModel> userPostList = [];
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
        for (var data in getPostDataList) {
          userPostList.add(JsonHolderUserPostModel(
              userId: data['userId'],
              id: data['id'],
              title: data['title'],
              body: data['body']
          ));
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
