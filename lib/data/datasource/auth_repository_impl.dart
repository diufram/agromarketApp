import 'dart:convert';

import 'package:agromarket_app/services/globals.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../domain/repository/auth_repository_intr.dart';
import '../../domain/request/login_request.dart';
import '../../domain/request/register_request.dart';

class AuthRepositoryImpl extends AuthRepositoryInterface {
  @override
  Future<Response> login(LoginRequest login) async {
    try {
      Map data = {
        "email": login.email,
        "password": login.password,
      };
      var body = json.encode(data);
      var url = Uri.parse('${baseURL}api/login');
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> logout(String token) async {
    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    var url = Uri.parse('${baseURL}logout');
    await http.get(url, headers: header);
  }

  @override
  Future<Response> register(RegisterRequest register) async {
    try {
      Map data = {
        "name": register.name,
        "email": register.email,
        "password": register.password,
        "phone": register.phone
      };
      var body = json.encode(data);
      var url = Uri.parse('${baseURL}api/register');
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Response> getCompany(int companyId) async {
    try {
      var url = Uri.parse('${baseURL}api/company/show/$companyId');
      final response = await http.get(
        url,
        headers: headers,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
