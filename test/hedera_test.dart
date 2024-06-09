import 'package:flutter_test/flutter_test.dart';
import 'package:hedera/hedera.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  setUp(() async {
    await dotenv.load(fileName: "assets/.env");
  });

  test('get network version', () async {
    final client = await HederaClient.fromEnv();
    final networkVersion = await client.call('net_version', []);
    expect(networkVersion, isNotNull);
    print('Network Version: $networkVersion');
  });

  test('get account balance', () async {
    final client = await HederaClient.fromEnv();
    final account = Account(client, 'your-account-address');
    final balance = await account.getBalance();
    expect(balance, isNotNull);
    print('Account Balance: $balance');
  });

  test('send transaction', () async {
    final client = await HederaClient.fromEnv();
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
