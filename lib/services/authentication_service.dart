import 'dart:convert';
import 'dart:math';
import 'package:at_client/at_client.dart';
import 'package:crypton/crypton.dart';

class AuthenticationService {
  late AtClient oAuthAtClient;
  String atSign = '';
  String encryptCode = '';
  String messageString = '';
  String decryptCode = '';
  bool authStatus = false;

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  RSAKeypair rsaKeypair = RSAKeypair.fromRandom();

  String generateRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<String> getPublicKeyForAtsign(String atSign) async {
    // Get a Encryption Public Key of the atSign
    var atKey = AtKey()
      ..key = 'publickey'
      ..sharedBy = atSign
      ..metadata = (Metadata()
        ..isPublic = true
        ..namespaceAware = false);
    var encryptionPublicKey = await oAuthAtClient.get(atKey);

    messageString = generateRandomString(5);
    encryptCode = RSAPublicKey.fromString(encryptionPublicKey.value)
        .encrypt(messageString);
    print('Challenge: $encryptCode');
    return encryptCode;
  }

  Future<void> checkDecryptValue() async {
    if (messageString == decryptCode) {
      authStatus = true;
    }
  }

  /// Fetches the data shared to the OAUTH atSign
  Future<String> getPersonalInfo() async {
    var responseJSON = {};
    var firstNameAtKey = AtKey()
      ..key = 'firstname**personal'
      ..sharedBy = atSign;
    var getResponse = await oAuthAtClient.get(firstNameAtKey);
    responseJSON.putIfAbsent(
        'firstName', () => jsonDecode(getResponse.value)['value']);
    var lastNameAtKey = AtKey()
      ..key = 'lastname**personal'
      ..sharedBy = atSign;
    getResponse = await oAuthAtClient.get(lastNameAtKey);
    responseJSON.putIfAbsent(
        'lastName', () => jsonDecode(getResponse.value)['value']);
    return jsonEncode(responseJSON);
  }

  Future<String> getContactInfo() async {
    var responseJson = {};
    var phoneAtKey = AtKey()
      ..key = 'phone**contact_details'
      ..sharedBy = atSign;
    var getResponse = await oAuthAtClient.get(phoneAtKey);
    responseJson.putIfAbsent(
        'phone', () => jsonDecode(getResponse.value)['value']);

    var emailAtKey = AtKey()
      ..key = 'email**contact_details'
      ..sharedBy = atSign;
    getResponse = await oAuthAtClient.get(emailAtKey);
    responseJson.putIfAbsent(
        'email', () => jsonDecode(getResponse.value)['value']);

    var addressAtKey = AtKey()
      ..key = 'address**contact_details'
      ..sharedBy = atSign;
    getResponse = await oAuthAtClient.get(addressAtKey);
    responseJson.putIfAbsent(
        'address', () => jsonDecode(getResponse.value)['value']);

    return jsonEncode(responseJson);
  }
}
