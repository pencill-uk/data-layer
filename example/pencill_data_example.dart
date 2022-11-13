import 'package:data_layer/data_layer.dart';

void main() {
  String baseUrl = 'https://pencill-cms-app.azurewebsites.net/api';

  const String token = String.fromEnvironment('API_TOKEN',
      defaultValue:
          '70f17c23e3b829d8b710cc2ffb261f9557b4415a89d1e008c262ceaacf52f711eaa6bf5d13ed82ae8af0a1226ade5c015f7c4381b64f8fca2a1c4c4998ac4ea983ec277ed354aa12a10ed2ce7baa3c88722fda7e3f6f73ca45ba59c1b0e3dd1367f1c226dfca0777eb2ce225d6b2ac21e2969c3f9a350fe25702b4fc941d046c');

  print('Token : $token');

  var remoteAPI = RemoteAPI(pBaseUrl: baseUrl, pToken: token);

  remoteAPI.getJsonData(
      pEndPoint: 'accounts', pResource: '1', pQueryParameters: '');
}
