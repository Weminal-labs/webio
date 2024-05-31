import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webio/provider/zk_login_provider.dart';

class ApiService {
  static String baseUrl = 'https://api.enoki.mystenlabs.com/v1/';
  static Map<String, String> get headers => {
        // "Content-Type": "application/json",
        // "Accept": "application/json",
        "Authorization": "Bearer enoki_public_20eba0273fd3d1b655da480622024e43",
      };

  static Future<(String, String)> getSaltAndAddress() async {
    var newHeader = headers;
    newHeader.addAll({"zklogin-jwt": "${ZkLoginProvider.getInstance().jwt}"});
    var res = await http.get(
      Uri.parse('${baseUrl}zklogin'),
      headers: newHeader,
    );
    if (res.statusCode != 200) {
      throw Exception("getSaltAndAddress fail ${res.statusCode}");
    }
    print('getSaltAndAddress: ${res.body}');
    Map<String, dynamic> decoded = jsonDecode(res.body);
    print('decoded: ${decoded}');
    Map<String, dynamic> data = decoded['data'];
    print('Data: $data');
    return (data['salt'] as String, data['address'] as String);
  }

  static Future<Map<String, dynamic>> getProof() async {
    var newHeader = headers;
    newHeader.addAll({"zklogin-jwt": "${ZkLoginProvider.getInstance().jwt}"});
    ZkLoginProvider provider = ZkLoginProvider.getInstance();
    var res = await http.post(Uri.parse('${baseUrl}zklogin/zkp'),
        headers: newHeader,
        body: jsonEncode({
          "network": "testnet",
          "randomness": provider.randomness,
          "maxEpoch": provider.maxEpoch,
          "ephemeralPublicKey":
              "${provider.account!.keyPair.getPublicKey().toSuiPublicKey()}"
        }));
    if (res.statusCode == 200) {
      Map<String, dynamic> decoded =
          jsonDecode(res.body) as Map<String, dynamic>;
      return decoded['data'];
    } else {
      print("getProof fail: ${res.body}");
      throw Exception("getProof fail ${res.statusCode}");
    }
  }
}
