import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'app_exception.dart';

class RemoteAPI {
  late final String
      baseUrl; // = 'https://pencill-cms-app.azurewebsites.net/api';

  String endpoint = '';
  String queryParameters = '';

  String token =
      '70f17c23e3b829d8b710cc2ffb261f9557b4415a89d1e008c262ceaacf52f711eaa6bf5d13ed82ae8af0a1226ade5c015f7c4381b64f8fca2a1c4c4998ac4ea983ec277ed354aa12a10ed2ce7baa3c88722fda7e3f6f73ca45ba59c1b0e3dd1367f1c226dfca0777eb2ce225d6b2ac21e2969c3f9a350fe25702b4fc941d046c';

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json",
    // "Access-Control-Allow-Origin": "*",
    'Authorization':
        'Bearer 70f17c23e3b829d8b710cc2ffb261f9557b4415a89d1e008c262ceaacf52f711eaa6bf5d13ed82ae8af0a1226ade5c015f7c4381b64f8fca2a1c4c4998ac4ea983ec277ed354aa12a10ed2ce7baa3c88722fda7e3f6f73ca45ba59c1b0e3dd1367f1c226dfca0777eb2ce225d6b2ac21e2969c3f9a350fe25702b4fc941d046c'
  };

  RemoteAPI({required String pBaseUrl, required String pToken}) {
    baseUrl = pBaseUrl;
    token = pToken;

    headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
  }

  String get url =>
      '$baseUrl$endpoint' + (queryParameters != '' ? '?$queryParameters' : '');

  Future<dynamic> getData(
      {required String url, String? queryParameters}) async {
    late final http.Response response;

    var fullUrl =
        '$baseUrl$url${queryParameters!.isNotEmpty ? '$queryParameters?populate=*' : '?populate=*'}';

    try {
      response = await http.get(
        Uri.parse(fullUrl),
        headers: headers,
      );
    } on SocketException {
      throw FetchDataException('No Internet connection', 'ERROR-1001');
    } catch (e) {
      rethrow;
    }
    return Future.value(response.body);
  }

  Future<dynamic> getJsonData(
      {required String pEndPoint,
      required String pResource,
      String pQueryParameters = ''}) async {
    late final http.Response response;

    print('Remote API Token : $token');

    var fullUrl =
        '$baseUrl/$pEndPoint/$pResource${pQueryParameters != '' ? '$queryParameters?populate=*' : '?populate=*'}';

    print('Remote API URL: $fullUrl');

    try {
      response = await http.get(
        Uri.parse(fullUrl),
        headers: headers,
      );

      print('Remote API Response Body: ' + response.body);
    } on SocketException {
      throw FetchDataException('No Internet connection', 'ERROR-1001');
    } catch (e) {
      print('Remote API Error: $e');
      rethrow;
    }
    return Future.value(response.body);

    // return Future.value("[" + response.body + "]");
  }

  Future<dynamic> postJsonData({required Map<String, dynamic> pBody}) async {
    late final http.Response response;

    try {
      response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(pBody),
      );

      print('Remote API : ${response.body}');

      return Future.value(processResponse(response));
    } catch (e) {
      print(e);
    }
    return Future.value(processResponse(response));
  }

  Future<String> postData({required Map<String, dynamic> pBody}) async {
    late final http.Response response;

    try {
      response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(pBody),
      );

      return Future.value(processResponse(response));
    } catch (e) {
      print(e);
    }
    return Future.value(processResponse(response));
  }

  String processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var resJson = response.body;
        return resJson;
      case 400:
        throw BadRequestException(response.body.toString(), 'ERROR-400');
      case 401:
        throw UnauthorisedException(response.body.toString(), 'ERROR-401');
      case 403:
        throw UnauthorisedException(response.body.toString(), 'ERROR-403');
      case 404:
        throw NotFoundException(response.body.toString(), 'ERROR-404');
      case 500:
        throw ServerException(response.body.toString(), 'ERROR-500');
      default:
        throw FetchDataException(response.body.toString(), 'ERROR-DEFAULT');
    }
  }
}
