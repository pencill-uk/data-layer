import 'dart:convert';
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
      return _userRemote.getUserById(pId: token['id']).then((value) {
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
      extractToken(pUserJson: userJson);
      var tId = extractUserId(pUserJson: userJson);
      print('authenticateUser tId: $tId');
      return _userRemote.getUserById(pId: tId);
    } else {
      return "";
    }
  }

  String extractUserId({required String pUserJson}) {
    Map<String, dynamic> decodedJson = json.decode(pUserJson);
    print(decodedJson);
    return decodedJson['jwt']['id'];
  }

  void extractToken({required String pUserJson}) {
    var tJwtToken = json.decode(pUserJson)['jwt'];
    print("Extract Token JWT: $tJwtToken");
    _userRemote.updateToken(pToken: tJwtToken);
    _userLocal.saveToken(pToken: tJwtToken);
    var tToken = _userLocal.fetchToken();
    print("Extract Token: $tToken");
  }
}
