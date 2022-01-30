import 'dart:convert';
import 'dart:io';

import 'package:currnecy_app/networking/CustomExceptions.dart';
import 'package:currnecy_app/networking/links.dart';
import 'package:http/http.dart' as http;
class ApiProvider{
  
  final Links _links = Links();
    Future<dynamic> get({String path,Map<String,String> parameters}) async {

    var responseJson;
    try {
      final response = await http.get(Uri.https(_links.baseUrl, path,parameters));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
   dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
       throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    
  }
}
}