import 'dart:io';


import 'package:agromarket_app/domain/request/company_request.dart';
import 'package:http/http.dart';

abstract class CompanyRepositoryInterface {
  Future<Response> createCompany(CompanyRequest company);
  Future<void> updateCompany(CompanyRequest company);
  Future<Response> getQuotesToCompany(int companyId);
  Future<File> getPdf(int quoteId);
}
