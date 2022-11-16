import 'account_remote.dart';

class AccountRepository {
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

  Future<String> authenticateAccount(
      {required String pIdentifier, required String pPassword}) {
    Future<String> account = getAccount("1");

    account.then((value) {
      print('getAccount value: $value');
      if (value != "") {
        return value;
      } else {
        return "";
      }
    });
    return account;
  }
}
