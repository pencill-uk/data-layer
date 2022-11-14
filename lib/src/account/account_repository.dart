import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart' as FA;
// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'account_remote.dart';

class AccountRepository {
  AccountRepository() {
    // if (Firebase.apps.isEmpty) {
    //   Firebase.initializeApp().whenComplete(() {
    //     _firebaseAuth = FA.FirebaseAuth.instance;
    //   });
    // }
  }

  Future<String> getAccount(String pIdentifier) async {
    // print('getAccount pIdentifier: $pIdentifier');

    return AccountRemote().getAccount(pIdentifier, "email").then((value) {
      // final decodedJson = json.decode(value);
      // return decodedJson;
      return value;
    });
  }
}
