import 'dart:convert';
import 'dart:html' show window;
import '../base/local_base.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

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

  Map<String, dynamic>? fetchToken() {
    var csrfToken = window.localStorage.containsKey("csrf")
        ? window.localStorage["csrf"]
        : "";

    if (csrfToken != "" && csrfToken != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(csrfToken);

      print("Decoded Token $decodedToken");

      if (JwtDecoder.isExpired(csrfToken)) {
        print("Token Expired");
        return null;
      } else {
        return decodedToken;
      }
    } else {
      print("Token Not Found");
      return null;
    }
  }

  void saveToken({required String pToken}) {
    window.localStorage['csrf'] = pToken;
  }

  Map<String, dynamic> parseJwt({required String pJwtToken}) {
    //   var userToken = csrfToken?.split(".");

    //   if (userToken?.length != 3) {
    //     window.localStorage.remove("csrf");
    //     return "";
    //   } else {
    //     var token = json.decode(
    //         utf8.decode(base64Url.decode(base64Url.normalize(userToken![1]))));
    //     if (DateTime.fromMillisecondsSinceEpoch(token["exp"] * 1000)
    //         .isAfter(DateTime.now())) {
    //       return csrfToken;
    //     } else {
    //       window.localStorage.remove("csrf");
    //       return "";
    //     }
    //   }
    // } else {
    //   return "";
    // }

    return json.decode(utf8.decode(
        base64Url.decode(base64Url.normalize(pJwtToken.split(".")[1]))));
  }
}
