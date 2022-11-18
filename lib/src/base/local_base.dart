class LocalBase {
  Future<dynamic> writeJsonData({required String pBody}) async {
    return Future.value("");
  }

  Future<dynamic> readJsonData(
      {required String pResource, String pQueryParameters = ''}) async {}
}
