class LoginResponse {
  const LoginResponse({
    required this.accessToken,
    required this.expiresIn,
    required this.scope,
    required this.tokenType,
  });

  final String accessToken;
  final int expiresIn;
  final String scope;
  final String tokenType;
}