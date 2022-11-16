import 'dart:convert';

import 'package:data_layer/data_layer.dart';
import 'package:data_layer/src/account/account_repository.dart';

void main() {
  String baseUrl = 'https://pencill-cms-app.azurewebsites.net/api';

  const String token = String.fromEnvironment('API_TOKEN',
      defaultValue:
          '70f17c23e3b829d8b710cc2ffb261f9557b4415a89d1e008c262ceaacf52f711eaa6bf5d13ed82ae8af0a1226ade5c015f7c4381b64f8fca2a1c4c4998ac4ea983ec277ed354aa12a10ed2ce7baa3c88722fda7e3f6f73ca45ba59c1b0e3dd1367f1c226dfca0777eb2ce225d6b2ac21e2969c3f9a350fe25702b4fc941d046c');

  print('Token : $token');

  AccountRepository accountRepository = AccountRepository();

  accountRepository
      .authenticateAccount(pIdentifier: "ram@anogaa.com", pPassword: "qazxsw")
      .then((value) {
    print('getAccount value: $value');

//     String body = """{
//     "data": {
//         "accountName": "Ram 1 Account",
//         "accountType": "Parent",
//         "accountStatus": true,
//         "createdAt": "2022-11-06T19:51:48.797Z",
//         "updatedAt": "2022-11-06T21:41:38.210Z",
//         "users": [
//            1
//         ],
//         "children": [],
//         "marketingPreferences": {
//             "emailOptIn": true,
//             "smsOptIn": true,
//             "marketingOptIn": true,
//             "postalOptIn": false
//         }
//     }
// }""";

    // accountRepository.postAccount(json.decode(body)).then((value) {
    //   print('postAccount value: $value');
    // });
  });
}
