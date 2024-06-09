import 'package:hedera/hedera.dart';

void main() async {
  final client = await HederaClient.fromEnv();

  // Get the network version
  final networkVersion = await client.call('net_version', []);
  print('Network Version: $networkVersion');

  // Example account operations
  final account = Account(client, 'your-account-address');
  final balance = await account.getBalance();
  print('Account Balance: $balance');

  // Example transaction operations
  final transaction = Transaction(client);
  final transactionId = await transaction.sendTransaction(
    'from-address',
    'to-address',
    'amount',
  );
  print('Transaction ID: $transactionId');
}
