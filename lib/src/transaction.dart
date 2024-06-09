import 'client.dart';
import 'client.dart';

class Transaction {
  final HederaClient client;

  Transaction(this.client);

  Future<String> sendTransaction(String from, String to, String amount) async {
    final response = await client.call('sendTransaction', [from, to, amount]);
    if (response['result'] != null) {
      return response['result']['transactionId'];
    } else {
      throw Exception('Error sending transaction: ${response['error']}');
    }
  }
}
