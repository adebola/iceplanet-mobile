class LoginResponse {
  const LoginResponse({
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresIn: json['expires_in'],
    );
  }

  final String accessToken;
  final String refreshToken;
  final int expiresIn;
}
