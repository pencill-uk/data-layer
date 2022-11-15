import 'account_remote.dart';

class AccountRepository {
  AccountRepository() {}

  Future<String> getAccount(String pIdentifier) async {
    // print('getAccount pIdentifier: $pIdentifier');

    return AccountRemote().getAccount(pIdentifier, "email").then((value) {
      // final decodedJson = json.decode(value);
      // return decodedJson;
      return value;
    });
  }

  Future<String> postAccount(Map<String, dynamic> pJsonData) async {
    print('postAccount pJsonData: $pJsonData');

    return AccountRemote().postAccount(pJsonData).then((value) {
      // final decodedJson = json.decode(value);
      // return decodedJson;
      return value;
    });
  }
}
