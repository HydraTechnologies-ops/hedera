import 'client.dart';

class Account {
  final HederaClient client;
  final String address;

  Account(this.client, this.address);

  Future<String> getBalance() async {
    final response = await client.call('accountBalance', [address]);
    if (response['result'] != null) {
      return response['result']['balance'];
    } else {
      throw Exception('Error getting balance: ${response['error']}');
    }
  }
}

