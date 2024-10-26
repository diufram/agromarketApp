import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages

import 'package:agromarket_app/domain/repository/quote_repository_intr.dart';
import 'package:agromarket_app/domain/request/quote_request.dart';
import 'package:agromarket_app/services/globals.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

class QuoteRepositoryImpl extends QuoteRepositoryInterface {
  @override
  Future<Response> createQuote(List<QuoteRequest> quotes, double total,
      int companyId, double discount) async {
    try {
      var url = Uri.parse('${baseURL}api/quote/create');
      final List<Map<String, dynamic>> listaDeObjetosJson =
          quotes.map((objeto) => objeto.toJson()).toList();

      Map data = {
        'subtotal': (total - discount),
        'total': total,
        'company_id': companyId,
        "discount": discount,
        'details': jsonEncode(listaDeObjetosJson)
      };

      final request = json.encode(data);

      final response = await http.post(url, body: request, headers: headers);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteQuote() {
    throw UnimplementedError();
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
