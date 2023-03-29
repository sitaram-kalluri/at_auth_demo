import 'dart:convert';
import 'dart:math';
import 'package:at_client/at_client.dart';
import 'package:atsign_login_app/model/contact_info.dart';
import 'package:atsign_login_app/model/personal_info.dart';
import 'package:crypton/crypton.dart';

class AuthenticationService {
  late AtClient oAuthAtClient;
  String atSign = "";
  String encryptCode = "";
  String messageString = "";
  String decryptCode = "";
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
    print('Decrypt Code: $messageString');
    return encryptCode;
  }

  getEncryptionPrivateKey(String atSign) {
    switch (atSign) {
      case '@general57':
        return 'MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCMOz1ko7FYU23R77zVX1nQUEIV9qcb3M9JUQEZg4AZlzNO2KgYyxBNNTUjHGE0z3lx4B+TZZxksJLOEn372ryraMAuYyINJLmRQv49F4fxRGbO+NlSIATYsqq1O993SYp41KkAppBG3P+ahVTYZANLFAgvW4LhTpJpH0u2yIJICT3+AEV8K1EPhACxiF5KRF6dUEwSliP0fRTlX8lCfb3pFtQ/MDGjhTS3DrEcsZmttJPsKa+A46fWbVQ8hfY6GwXn7uvGHaoWwrJHHKQb5v7QYYe/vKzXwIkAuTV9lT6CZccezC8ku9iSrPY7mZea77eS0lvzOOZIJn+J390ENQZ3AgMBAAECggEAcTi7XvBTlg72UlSQUG7GI01JrlYRootrybRfgOwNl5vez0BaqHn71XqqRoj5axxA39Kna+jUlu+B+GQx2BFJ19Ohp1JfAeGu+jvu7gB7wC8MGvwM6yPzBctrzRxkVvnHlbuOIHpbbvusXGRelsBZcFriKOpoB+XajIm6JgBKQEITMj+SlYUbP460XkvQhvcNHLVyh4VzQzPUWNdF5BeUnOKFIp6aVB0Q9qQpxfxdhxdsh9F8TdK9qqTKTUH07CMtst3kKhlematNNq4QGMx4iYE+YajLqA+Rb6tTkBEc+UJv6gsV3tciYvEQcAosUMY44j0Shlnv8FEfh8xPqmMzoQKBgQDMi+UvDSWZVYf6bgbXXBH1O9OnOQe+47+naWcGLpZ4/DnnF+sErw3uXnmVoxyLqM6b0ifJu7L58010ApSRkKatSmmHoa1SzAiW/+w6XU5sWpVLZi/mM4f5f0xavTZMjK64p/cGWLIYewllVDoAFF7kXz0qaeD9LaQo1j/R9JczmQKBgQCvgavAKolbZOcnTXsqeMUjqnOUxe7o7YX+36+AOpJRzUZY3yVgG+Enp6jarGtwt78QP0AkphYQFUEKeMwopoMwpyQc0exp+Kyfni449pa1NQIBmhpeisbPn3m1QnPq+M35NBoBTLSppLp93Zj9Gbx8MSUGU2+MPbImH5AFr/lUjwKBgDZTWXVbqobE/q52ln6QR3y4fQhGz1XVq0tNZT1xFinf44kLAzJlQ+/xS52Ais5U8TrVYBfmMCzOf9216buXjY0s3EZXnG8HHajtI9KEgZWpoUk7RLGBMjYDp0XaRxehra4BfkxDNlnmI6Kz8gufXWyOFvKy2Dyl6Jmn/Z9HtPjRAoGARwRqkjTkJeZbnsy8dQAvjXIQmPfK59gNK4gqBPIueQleWOHaxtwhLKGsMugoBZFkr9dYRjwqm1FuYyVkP2K5nTtU4pCTYIIun9wrCgPGEgckC6/m0bDIKAV5Az6jl0YcWqWZjEMUq7yrdfjwSiJa4colGD002wOwDbsh1RtTAcMCgYEAh0SjepB+GTK97Ud2deNjsseGR3ENMfd+89zLuJpnhkoXRKBvTtltNgeMg89C6h+AOqYOd37b3q2naiDpAQajpPCfPOWHXTM7yY0w90lGRJjrXZt86uZCGhu6PmGkqs4AmnTXscM7ScLMpbq9/ofMiOu/b6rNysQZwunJzYqk1Ms=';

      case '@criminalbatagor':
        return 'MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCmZc+kHnkwWhMfnhufYhIr9/yqW/OszebasCJZ8K7FV9tgcLjFZlDVMkpdGjLfBLkTjl5xeMoS4rBvIYX+IEt3s1y1QIIFu8GkddhSh72r7l/l1dUqiGsynjAooiYOg7U8FpsKwjN7w0fB38A83BfewT0ceXKRpB+rDA5LbH8vzFjSvFkZgrex+o6kLz+KIPGySyayJlHC9pHnQh/353EL8saDXzE78jG1qGg55biVZGcRMQg0yLinFg3dSzdWnQSUI/TGSAvlZYye02gnhtG8G97hllQQyxKvpUY/HLS+5rV4vmWM2VqNc7zAJCAPoU/jHVk5AKGOTLkFFnN0ic3fAgMBAAECggEAOuJckJ+YE1xM2CuDauuxso2XhFH18XkL8OfTwDBEKOHmaEJ7oJ+Mi2W4myniRrnNJPaExXMRT42ZEjqyyDN1gW6fqCSj3pOK+0AYxVvz6xv4I8WAIgUUql0AfeCjxw8k25bEVxJSVcHNavZbeS4J5HJNxf3UZWXHLyidBmPmvmrneUl09ERtxSeU5JeXEM2JOSJQMas1+Qxpt1nz6gsqKsriRSF5taDUruyeXdQvZnFLtFJ56nat7Zo78e/RO7sQa+9W3ixdIxIzVs+fan2y/U67Wa1iuhnAuvxOUvbGcVro/2EUOThlVxUHzwSLrtQCjr+TqxcFTqSIfFV9Jw+3AQKBgQDhyVIg4J078pblc7e4YO1LaTlsQ3PsBobziCcZJs509L1TV8sXdVGY3ailkOMDahehJHDrfP61LZrIcBvf94hJ2tEFj1a52X7SYSudYUe+MZpeIzKh/3s91T4VtnsnFEgEkGPL4NrCMQxW5nIC6gCXS8Q7gbjXpgp8FbPYTsuwsQKBgQC8qgipGlPBZ2CMLcSq1RVWjzvV8KVrmwemzq8rJ6XgCCQWAcSulPic6JYWb5VTpmQmjuaiGB/uaQ4E6rcIeYaCqRQHhrxjcvZJdmdZGdDl2n4NPAqLv5Q8018NCuo2xYnTJSyNjGsNG4+W52xpDZykx7dmigm0eYCXhx4m+XKLjwKBgQDDtAFI2AfRXzrl1UBIQ1NLCwCn02uWCC5OxhPFnDpVa5DyvWUehyTb0D0OjSAH5JxoozJxGx2XItlHpMy0e1SZV13XaN+uJVPkvC7WsexCcbIwqGeJvO0wsjWnEk16mPy3YAPwQoy6x1K/u+zUk8lBWn3TamQyHwx1c0Y4Vkv9cQKBgCWECkTWH2GOFPzK/RibVqrnwJZCTCKhqVvaLar/L1TlSYe2wk2VAfrxpSbA+YiwxamFMQd6lJ7r9QW1RsBAqibBSGJWwI9mBOOGz/Y/0/JhCD/JeK9hYTDXN0d4rCpIDagW9E0RZxgsKtlvG3eoZUW/EREq0dM5dgCrtas6XzSxAoGBAM6+l+Uze23V0koVEcvNbWY74ddZTw7QMXnj/ChO89r3ABjVSHF72wmq3+Q4Qvj+udgTbPYpJY3nY2cBXuKXueVFVEnQe4mPdSDz4Gh7XcIA48D3UI6GkZmvTFJRzlkudOcEaO0RqXx0ADjk914vnurcntg4JmwQ+e6Hv64P4qBh';
    }
  }


  checkDecryptValue(String decrypt_code) async {
    if (messageString == decrypt_code) {
      return true;
    } else {
      return false;
    }
  }

  /// Fetches the data shared to the OAUTH atSign
  Future<PersonalInfo> getPersonalInfoSharedBy() async {
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

  Future<ContactInfo> getContactInfoSharedBy() async {
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
