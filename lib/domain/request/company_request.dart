import 'dart:io';

class CompanyRequest {
  final String name;
  final String address;
  final String telephone;
  final int userId;
  final File? image;

  CompanyRequest(
    this.image, {
    required this.name,
    required this.address,
    required this.telephone,
    required this.userId,
  });
}
