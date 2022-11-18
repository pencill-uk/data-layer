import 'dart:convert';
import '../base/remote_base.dart';

class AccountRemote extends RemoteBase {
  AccountRemote() : super(pBaseUrl: '', pToken: '') {
    super.endpoint = "accounts";
  }

  Future<String> postAccount(Map<String, dynamic> pJsonData) async {
    endpoint = "accounts";

    return Future.value(
        await super.postJsonData(pBody: json.encode(pJsonData)));
  }

  Future<String> getAccount(String pIdentifier, String pMethod) async {
    // String tQueryParameters = 'method=$pMethod&identifier=$pIdentifier';

    String tQueryParameters = '/$pIdentifier';

    return Future.value(await super.getJsonData(
        pResource: pIdentifier, pQueryParameters: tQueryParameters) as String);
  }
}
