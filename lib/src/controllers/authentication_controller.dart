import 'package:get/get.dart';
import 'package:vncitizens_authentication/src/models/models.dart';
import 'package:vncitizens_authentication/src/services/authentication_service.dart';

class AuthenticationController {
  AuthenticationService? _authenticationService;
  var status = AuthenticationStatus.unauthenticated.obs;
  var process = AuthenticationProcess.init.obs;
  String _accessToken = '';

  AuthenticationController({
    required String ssoURL,
    required String clientId,
    required String username,
    required String password,
  }) {
    _authenticationService = Get.put(AuthenticationService(
      ssoURL: ssoURL,
      clientId: clientId,
      username: username,
      password: password,
    ));
  }

  String get accessToken => _accessToken;

  signInWithCredential() async {
    String accessToken = await _authenticationService!.signInWithCredential();
    _accessToken = accessToken;
  }

  signInWithPassword({required username, required password}) async {
    process(AuthenticationProcess.loading);
    try {
      String accessToken = await _authenticationService!.signInWithPassword(
        username: username,
        password: password,
      );
      status(AuthenticationStatus.authenticated);
      _accessToken = accessToken;

      process(AuthenticationProcess.success);
      Get.back(id: 4);
    } catch (e) {
      process(AuthenticationProcess.failure);
    }
  }

  signOut() {
    status(AuthenticationStatus.unauthenticated);
    _accessToken = '';
    process(AuthenticationProcess.init);
  }
}
