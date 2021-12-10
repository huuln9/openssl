import 'package:flutter_test/flutter_test.dart';
import 'package:vncitizens_authentication/src/models/authentication_status.dart';
import 'package:vncitizens_authentication/vncitizens_authentication.dart';

void main() {
  group("Test authentication module:", () {
    test(
        "Sign in with client credential: AuthenticationStatus should be unauthenticated",
        () async {
      final authenticationController = AuthenticationController(
        ssoURL: 'https://ssotest.vnptigate.vn',
        clientId: 'web-citizensadm',
        username: 'admintest',
        password: 'Vnpt@123',
      );

      await authenticationController.signInWithCredential();

      expect(authenticationController.getAccessToken() != '', true);
      expect(authenticationController.getAuthenticationStatus(),
          AuthenticationStatus.unauthenticated);
    });

    test("Sign in with password: AuthenticationStatus should be authenticated",
        () async {
      final authenticationController = AuthenticationController(
        ssoURL: 'https://ssotest.vnptigate.vn',
        clientId: 'web-citizensadm',
        username: 'admintest',
        password: 'Vnpt@123',
      );

      await authenticationController.signInWithPassword(
          username: 'admintest', password: 'Vnpt@123');

      expect(authenticationController.getAccessToken() != '', true);
      expect(authenticationController.getAuthenticationStatus(),
          AuthenticationStatus.authenticated);
    });
  });
}
