import 'dart:convert';
import '../base/remote_base.dart';

class UserRemote extends RemoteBase {
  UserRemote() : super(pBaseUrl: '', pToken: '') {
    super.endpoint = "auth/local";
  }

  Future<String> postUser(Map<String, dynamic> pJsonData) async {
    return Future.value(
        await super.postJsonData(pBody: json.encode(pJsonData)));
  }

  Future<String> getUserById({required String pId}) async {
    String tQueryParameters = '/$pId';

    return Future.value(await super.getJsonData(
        pResource: pId, pQueryParameters: tQueryParameters) as String);
  }

  Future<String> getUser(String pIdentifier, String pMethod) async {
    // String tQueryParameters = 'method=$pMethod&identifier=$pIdentifier';

    String tQueryParameters = '/$pIdentifier';

    return Future.value(await super.getJsonData(
        pResource: pIdentifier, pQueryParameters: tQueryParameters) as String);
  }

  Future<String> authenticateUser(
      {required String pIdentifier, required String pPassword}) async {
    String tBody = '{"identifier": "$pIdentifier", "password": "$pPassword"}';
    return Future.value(await super.postJsonData(pBody: tBody) as String);
  }

  void updateToken({required String pToken}) {
    // print("Store Token JWT:$pToken");
    super.token = pToken;
    updateHeader();
  }
}
