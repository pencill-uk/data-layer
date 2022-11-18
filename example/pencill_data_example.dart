import 'package:data_layer/src/user/user_repository.dart';

void main() {
  UserRepository userRepository = UserRepository();

  if (userRepository.isCurrentUserAuthenticated()) {
    print('User is authenticated');
  } else {
    print('User is not authenticated');

    userRepository
        .authenticateUser(pIdentifier: "b6@pencill.co.uk", pPassword: "qazxsw")
        .then((value) {
      print('authenticated User Response: $value');

      if (value != "") {
        return value;
      } else {
        return "";
      }
    });
  }

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
}
