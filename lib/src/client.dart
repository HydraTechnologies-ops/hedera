import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HederaClient {
  final String apiUrl;
  final String? apiKey;
  final String accountId;
  final String privateKey;

  HederaClient(this.apiUrl, this.apiKey, this.accountId, this.privateKey);

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

  static Future<HederaClient> fromEnv() async {
    await dotenv.load(fileName: "assets/.env");

    final accountId = dotenv.env['MY_ACCOUNT_ID'];
    final privateKey = dotenv.env['MY_PRIVATE_KEY'];
    final apiUrl =
        'https://testnet.mirrornode.hedera.com/api/v1'; // Ensure this URL is correct
    final apiKey = dotenv.env['MY_API_KEY']; // Placeholder for actual API key

    if (accountId == null || privateKey == null) {
      throw Exception(
          'Environment variables MY_ACCOUNT_ID or MY_PRIVATE_KEY are not set');
    }

    return HederaClient(apiUrl, apiKey, accountId, privateKey);
  }
}
