import 'package:http/http.dart' as http;
import 'dart:convert';

class HederaClient {
  final String apiUrl;
  final String apiKey;

  HederaClient(this.apiUrl, this.apiKey);

  Future<Map<String, dynamic>> call(String method, List<dynamic> params) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'jsonrpc': '2.0',
        'method': method,
        'params': params,
        'id': 1,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to call JSON-RPC: ${response.statusCode}');
    }
  }
}
