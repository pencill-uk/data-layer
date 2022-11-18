import 'dart:convert';
import 'dart:html' show window;
import '../base/local_base.dart';

class UserLocal extends LocalBase {
  Future<String> saveUser(Map<String, dynamic> pJsonData) async {
    return Future.value(
        await super.writeJsonData(pBody: json.encode(pJsonData)));
  }

  Future<String> fetchUser(String pIdentifier, String pMethod) async {
    // String tQueryParameters = 'method=$pMethod&identifier=$pIdentifier';

    String tQueryParameters = '/$pIdentifier';

    return Future.value(await super.readJsonData(
        pResource: pIdentifier, pQueryParameters: tQueryParameters) as String);
  }

  String? fetchToken() {
    var csrfToken = window.localStorage.containsKey("csrf")
        ? window.localStorage["csrf"]
        : "";

    if (csrfToken != "") {
      var userToken = csrfToken?.split(".");

      if (userToken?.length != 3) {
        window.localStorage.remove("csrf");
        return "";
      } else {
        var token = json.decode(
            utf8.decode(base64Url.decode(base64Url.normalize(userToken![1]))));
        if (DateTime.fromMillisecondsSinceEpoch(token["exp"] * 1000)
            .isAfter(DateTime.now())) {
          return csrfToken;
        } else {
          window.localStorage.remove("csrf");
          return "";
        }
      }
    } else {
      return "";
    }
  }

  void saveToken({required String pToken}) {
    window.localStorage['csrf'] = pToken;
  }
}
