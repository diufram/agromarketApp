import '../models/user_model.dart';

class RegisterResponse {
  const RegisterResponse(this.token, this.user);
  final String token;
  final User user;
}
