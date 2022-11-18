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
    String? token = _userLocal.fetchToken();

    print('lastAutenticatedUserStatus: $token');
    if (token != "") {
      return true;
    } else {
      return false;
    }
  }

  Future<String> authenticateUser(
      {required String pIdentifier, required String pPassword}) async {
    String user = await _userRemote.authenticateUser(
        pIdentifier: pIdentifier, pPassword: pPassword);

    print('authenticateUser value: $user');
    if (user != "") {
      extractToken(pUserJson: user);
      return json.encode(json.decode(user)['user']);
    } else {
      return "";
    }
  }

  void extractToken({required String pUserJson}) {
    var tJwtToken = json.decode(pUserJson)['jwt'];
    _userRemote.updateToken(pToken: tJwtToken);
    _userLocal.saveToken(pToken: tJwtToken);
  }
}
