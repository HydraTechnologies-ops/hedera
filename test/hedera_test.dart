import 'package:flutter_test/flutter_test.dart';
import 'package:hedera/hedera.dart';

void main() {
  test('get network version', () async {
    final client = HederaClient('https://your-hedera-node-url', 'your-api-key');
    final networkVersion = await client.call('net_version', []);
    expect(networkVersion, isNotNull);
    print('Network Version: $networkVersion');
  });

  test('get account balance', () async {
    final client = HederaClient('https://your-hedera-node-url', 'your-api-key');
    final account = Account(client, 'your-account-address');
    final balance = await account.getBalance();
    expect(balance, isNotNull);
    print('Account Balance: $balance');
  });

  test('send transaction', () async {
    final client = HederaClient('https://your-hedera-node-url', 'your-api-key');
    final transaction = Transaction(client);
    final transactionId = await transaction.sendTransaction(
      'from-address',
      'to-address',
      'amount',
    );
    expect(transactionId, isNotNull);
    print('Transaction ID: $transactionId');
  });
}
