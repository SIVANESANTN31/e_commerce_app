import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['products'];
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
