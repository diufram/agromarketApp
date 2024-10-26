import 'package:agromarket_app/domain/models/company_model.dart';

import '../models/user_model.dart';

abstract class LocalRepositoryInterface {
  Future<String> getToken();
  Future<void> clearAllData();
  Future<void> saveUser(User user);
  Future<String> saveToken(String token);
  Future<User> getUser();
  Future<void> saveCompany(Company company);
  Future<Company> getCompany();
  Future<void> saveCompanyId(int companyId);
  Future<int> getCompanyId();
}
