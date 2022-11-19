import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'user_local.dart';
import 'user_remote.dart';

class UserRepository {
  final UserRemote _userRemote = UserRemote();
  final UserLocal _userLocal = UserLocal();

  Future<String> fetchUser(String pIdentifier) async {
    // print('getUser pIdentifier: $pIdentifier');

    return _userRemote.getUser(pIdentifier, "email").then((value) {
      // final decodedJson = json.decode(value);
      // return decodedJson;
      return value;
    });
  }

  Future<String> createUser(Map<String, dynamic> pJsonData) async {
    print('postUser pJsonData: $pJsonData');

    return _userRemote.postUser(pJsonData).then((value) {
      // final decodedJson = json.decode(value);
      // return decodedJson;
      return value;
    });
  }

  bool isCurrentUserAuthenticated() {
    Map<String, dynamic>? token = _userLocal.fetchToken();

    print('lastAutenticatedUserStatus: $token');
    if (token != null && token.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getCurrentUser() async {
    Map<String, dynamic>? token = _userLocal.fetchToken();

    print('lastAutenticatedUserStatus: $token');
    if (token != null) {
      return _userRemote.getUserById(pId: token['id'].toString()).then((value) {
        print("getCurrentUser: $value");
        return value;
      });
    } else {
      return Future.value("");
    }
  }

  Future<String> authenticateUser(
      {required String pIdentifier, required String pPassword}) async {
    String userJson = await _userRemote.authenticateUser(
        pIdentifier: pIdentifier, pPassword: pPassword);

    print('authenticateUser value: $userJson');
    if (userJson != "") {
      String tToken = extractToken(pUserJson: userJson);
      var tId = extractUserIdFromToken(pJwtToken: tToken);
      print('authenticateUser tId: $tId');
      return _userRemote.getUserById(pId: tId);
    } else {
      return "";
    }
  }

  String extractUserIdFromToken({required String pJwtToken}) {
    var tToken = JwtDecoder.decode(pJwtToken);
    return tToken['id'];
  }

  String extractToken({required String pUserJson}) {
    var tJwtToken = json.decode(pUserJson)['jwt'];
    print("Extract Token JWT: $tJwtToken");
    _userRemote.updateToken(pToken: tJwtToken);
    _userLocal.saveToken(pToken: tJwtToken);
    Map<String, dynamic>? tToken = _userLocal.fetchToken();
    print("Extract Token: $tToken");
    return tToken!['id'].toString();
  }
}
