import 'dart:convert';
import 'dart:math';
import 'package:at_client/at_client.dart';
import 'package:atsign_login_app/model/contact_info.dart';
import 'package:atsign_login_app/model/personal_info.dart';
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
  Future<PersonalInfo> getPersonalInfo() async {
    var personalInfo = PersonalInfo();
    // Set firstName
    var firstNameAtKey = AtKey()
      ..key = 'firstname**personal'
      ..sharedBy = atSign;
    var getResponse = await oAuthAtClient.get(firstNameAtKey);
    personalInfo.firstName = jsonDecode(getResponse.value)['value'];
    // Set lastName
    var lastNameAtKey = AtKey()
      ..key = 'lastname**personal'
      ..sharedBy = atSign;
    getResponse = await oAuthAtClient.get(lastNameAtKey);
    personalInfo.lastName = jsonDecode(getResponse.value)['value'];
    personalInfo.age = 30;
    personalInfo.gender = 'male';

    return personalInfo;
  }

  Future<ContactInfo> getContactInfo() async {
    var contactInfo = ContactInfo();
    // Set Phone Number
    var phoneAtKey = AtKey()
      ..key = 'phone**contact_details'
      ..sharedBy = atSign;
    var getResponse = await oAuthAtClient.get(phoneAtKey);
    contactInfo.phoneNumber = jsonDecode(getResponse.value)['value'];

    // Set Email
    var emailAtKey = AtKey()
      ..key = 'email**contact_details'
      ..sharedBy = atSign;
    getResponse = await oAuthAtClient.get(emailAtKey);
    contactInfo.email = jsonDecode(getResponse.value)['value'];

    return contactInfo;
  }
}
