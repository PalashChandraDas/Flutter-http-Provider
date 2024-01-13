import 'package:http/http.dart' as http;

import '../../../utils/apis.dart';

class ReqresService{

  Future<http.Response> reqresUserData() async {
    var url = Uri.parse(Apis.reqResBaseUrl + Apis.reqResEndPoint);
    http.Response response = await http.get(url);
    return response;
  }

}