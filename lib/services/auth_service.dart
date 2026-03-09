class AuthService {
  Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    // Fake success response
    return {
      "success": true,
      "message": "Account created successfully",
      "token": "fake_jwt_token_123",
    };
  }
}