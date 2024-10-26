import 'package:http/http.dart';
import '../request/login_request.dart';
import '../request/register_request.dart';

abstract class AuthRepositoryInterface {
  Future<Response> login(LoginRequest login);
  Future<Response> register(RegisterRequest register);
  Future<void> logout(String token);
  Future<Response> getCompany(int companyId);
}
