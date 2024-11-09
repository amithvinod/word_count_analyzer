import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = '[your-backend-url]/analyze';

  Future<List<Map<String, dynamic>>> fetchWordFrequency(
      String url, int topN) async {
    
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"url": url, "n_value": topN}),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception("Failed to fetch word frequency data");
    }
  }
}
