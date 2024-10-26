import 'dart:convert';
import 'dart:io';
import 'package:agromarket_app/domain/repository/company_repository_intr.dart';
import 'package:agromarket_app/domain/request/company_request.dart';
import 'package:agromarket_app/services/globals.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

class CompanyRepositoryImpl extends CompanyRepositoryInterface {
  @override
  Future<Response> createCompany(CompanyRequest company) async {
    try {
      /*  Map<String, String> header = {
        "Content-Type": "application/json",
        // "Authorization": "Bearer $token"
      };
      var url = Uri.parse('${baseURL}api/company/create');
      final request = http.MultipartRequest('POST', url);

      request.fields['name'] = company.name;
      request.fields['address'] = company.address;
      request.fields['telephone'] = company.telephone;
      request.fields['user_id'] = company.userId.toString();
      request.headers.addAll(header);

      if (company.image != null) {
        request.files.add(
            await http.MultipartFile.fromPath('photos', company.image!.path));
      }
      final response = await http.Response.fromStream(await request.send()); */
      List<int> imageBytes = await File(company.image!.path).readAsBytes();
      String base64Image = base64Encode(imageBytes);

      Map<String, dynamic> requestBody = {
        'name': company.name,
        'address': company.address,
        'telephone': company.telephone,
        'user_id': company.userId,
        'photos': base64Image
      };

      http.Response response = await http.post(
        Uri.parse("${baseURL}api/company/create"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateCompany(CompanyRequest company) async {
    throw UnimplementedError();
  }

  @override
  Future<Response> getQuotesToCompany(int companyId) async {
    try {
      var url = Uri.parse('${baseURL}api/quote/index/$companyId');
      final response = await http.get(
        url,
        headers: headers,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<File> getPdf(int quoteId) async {
    try {
      final res = await http.get(Uri.parse('${baseURL}api/pdf/show/$quoteId'));
      final bytes = res.bodyBytes;
      final fileName = basename('${baseURL}api/pdf/show/$quoteId');
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (e) {
      throw Exception();
    }
  }
}
