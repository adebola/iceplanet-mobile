
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_mobile/models/login_response.dart';

// final authProvider = StateProvider<LoginResponse>((ref) {
//   //return null;
// });

class AuthProvider extends StateNotifier<LoginResponse> {
  AuthProvider() : super(const LoginResponse(accessToken: 'xxx', expiresIn: 0, refreshToken: 'xxx'));

  void login(String email, String password) {
    state = const LoginResponse(accessToken: 'temp_token', expiresIn: 3600, refreshToken: 'temp_refresh');
  }

  void logout() {
    state = const LoginResponse(accessToken: 'xxx', expiresIn: 0, refreshToken: 'xxx');
  }
}


final authProvider = StateNotifierProvider<AuthProvider, LoginResponse>(
  (ref) => AuthProvider(),
);