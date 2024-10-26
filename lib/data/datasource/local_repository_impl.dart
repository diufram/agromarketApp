import 'package:agromarket_app/domain/models/company_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repository/local_repository_intr.dart';

const _prefToken = "TOKEN";
const _prefName = "NAME";
const _prefId = "ID";
const _prefEmail = "EMAIL";
const _phone = "0";

const _companyImg = "IMGCOMPANY";
const _companyId = "IDCOMPANY";
const _companyName = "NAMECOMPANY";
const _companyAddress = "ADDRESSCOMPANY";
const _companyPhone = "PHONECOMPANY";

class LocalRepositoryImpl extends LocalRepositoryInterface {
  @override
  Future<void> clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_prefToken).toString();
  }

  @override
  Future<User> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final id = sharedPreferences.getString(_prefId);
    final nameU = sharedPreferences.getString(_prefName);
    final email = sharedPreferences.getString(_prefEmail);
    final phone = sharedPreferences.getString(_phone);
    final user = User(
      id: int.parse(id.toString()),
      name: nameU!,
      email: email!,
      phone: int.parse(phone.toString()),
    );
    return user;
  }

  @override
  Future<String> saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_prefToken, token);
    return token;
  }

  @override
  Future<void> saveUser(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_prefId, user.id.toString());
    sharedPreferences.setString(_prefName, user.name).toString();
    sharedPreferences.setString(_prefEmail, user.email.toString());
    sharedPreferences.setString(_phone, user.phone.toString());
  }

  @override
  Future<void> saveCompany(Company company) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_companyId, company.id.toString());
    sharedPreferences.setString(_companyName, company.name);
    sharedPreferences.setString(_companyPhone, company.telephone);
    sharedPreferences.setString(_companyAddress, company.address);
    sharedPreferences.setString(_companyImg, company.image);
  }

  @override
  Future<Company> getCompany() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final id = sharedPreferences.getString(_companyId);
    final name = sharedPreferences.getString(_companyName);
    final phone = sharedPreferences.getString(_companyPhone);
    final address = sharedPreferences.getString(_companyAddress);
    final img = sharedPreferences.getString(_companyImg);
    final userId = sharedPreferences.getString(_prefId);
    final company = Company(
        name: name.toString(),
        address: address.toString(),
        telephone: phone.toString(),
        userId: int.parse(userId!),
        image: img.toString(),
        id: int.parse(id.toString()));
    return company;
  }

  @override
  Future<void> saveCompanyId(int companyId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_companyId, companyId.toString());
  }

  @override
  Future<int> getCompanyId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final id = sharedPreferences.getString(_companyId);
    return int.parse(id.toString());
  }
}
