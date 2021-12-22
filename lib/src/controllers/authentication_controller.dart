import 'package:get/get.dart';
import 'package:vncitizens_authentication/src/models/authentication_status.dart';
import 'package:vncitizens_authentication/src/services/authentication_service.dart';

class AuthenticationController {
  AuthenticationService? _authenticationService;
  var status = AuthenticationStatus.unauthenticated.obs;
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
    String accessToken = await _authenticationService!.signInWithPassword(
      username: username,
      password: password,
    );
    status(AuthenticationStatus.authenticated);
    _accessToken = accessToken;

    Get.back(id: 4);
  }

  signOut() {
    status(AuthenticationStatus.unauthenticated);
    _accessToken = '';
  }
}
