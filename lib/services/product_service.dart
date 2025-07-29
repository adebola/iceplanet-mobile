
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  Future<Products> getProducts() {
    final baseUrl = dotenv.env['AWS_BUCKET_NAME']!;
    return http.get(Uri.parse(baseUrl))
        .then((response) {
      if (response.statusCode == 200) {
        final results = json.decode(response.body);
        return Products.fromJson(results);
      } else {
        throw Exception('Failed to load products');
      }
    });
  }
}