import 'dart:convert';
import '../base/remote_api.dart';

class AccountRemote extends RemoteAPI {
  AccountRemote() : super(pBaseUrl: '', pToken: '') {
    super.endpoint = "accounts";
  }

  Future<String> postAccount(Map<String, dynamic> pJsonData) async {
    endpoint = "accounts";

    return Future.value(await super
        .postJsonData(pEndPoint: 'accounts', pBody: json.encode(pJsonData)));
  }

  Future<String> getAccount(String pIdentifier, String pMethod) async {
    // String tQueryParameters = 'method=$pMethod&identifier=$pIdentifier';

    String tQueryParameters = '/$pIdentifier';

    return Future.value(await super.getJsonData(
        pEndPoint: 'accounts',
        pResource: pIdentifier,
        pQueryParameters: tQueryParameters) as String);
  }
}
