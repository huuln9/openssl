import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthenticationService extends GetConnect {
  String ssoURL;
  String clientId;
  String username;
  String password;

  AuthenticationService({
    required this.ssoURL,
    required this.clientId,
    required this.username,
    required this.password,
  });

  Future<String> signInWithCredential() async {
    final String accessToken = await _getAccessTokenWithPassword(
        username: username, password: password);
    return accessToken;
  }

  Future<String> signInWithPassword({
    required String username,
    required String password,
  }) async {
    final String accessToken = await _getAccessTokenWithPassword(
        username: username, password: password);

    return accessToken;
  }

  Future<String> _getAccessTokenWithPassword({
    required String username,
    required String password,
  }) async {
    Map<String, dynamic> requestBody = {
      'grant_type': 'password',
      'client_id': clientId,
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('$ssoURL/auth/realms/digo/protocol/openid-connect/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['access_token'];
    } else {
      throw Exception(response.body);
    }
  }
}
