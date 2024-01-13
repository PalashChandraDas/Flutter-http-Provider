import 'package:http/http.dart' as http;

import '../../../utils/apis.dart';

class JsonHolderService{

  Future<http.Response> jsonHolderPostData() async {
    var url = Uri.parse(Apis.jsonHolderBaseUrl + Apis.jsonHolderEndPoint);
    http.Response response = await http.get(url);
    return response;
  }

}