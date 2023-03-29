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
        return 'MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCST9oCPaeWsfNxRmnXnmmYfL13FfIfAb71wqk47Id1k+TRl5gqGIRynB2WVINZfu8Tc4jiYfXnMNmUP3ZfFFcP6ChCegxUAn3HRfsJVWIsznr5gzHA9tfofDVuq1ZGGbjapKX8vIzozNQAycL2rx7XUkkgCZNrg9Wy6aFX343L/ewgk3SYvWQwwAmCm4vNfGOX8Wt4cvlFAdJancHo174pU/dnneuc/zOEul382WA7j9G6QXFSZrNy32v3GYmbRhHPyuXTo1pUy6WilBaAtagMO1H2y1ladiaWKsyjo1OxGwhaRqZ6QdZgfT/s24chrvHTPXs4mIiW/OpHdaSgUgLbAgMBAAECggEAFRsrydL3EAgPpDGSJyaU+QhVlI435T0tPOqd2rZUPCPfiFSkAL6UrKvUoNEEOa7T8ixifLXA8V7cpEQbYU/f102YMS7GBIBvgIWZ1xjYFrqahs/kJ3/0WXdBhft1cJtZTUEfKLxSX2rc0lhIpalRe6JFJjf7ajEUbMDDI5f+LoT06nJDxKL4bPq1Av8qyip/AcVYUATQicjLjNp8QwB7sRODstRlhun4PRANjw+hYi05lXMsdf72uyzlfMiZBci+hq52pTuoBh2Ruq8dOdOo7LKelLfHEqVW81WcrzP3D9cpPuOqNphIHvfeyOpv5n8uFbBqD19+IZ0SHKMwvybGgQKBgQDC1HmNsL9VNggNNWcqZ9FxM+Ow6SnpQtaxapUVjdvrzEfnOv2rA3oLWPst8WaSibaWXMkJ4NomxA2KYyBTrbA81ZLbZ0MCyXHlKxcYEhHRCHVMmCF3zHhw36T7BtN15lH/lNcyinrf5tapE+GHOOhCU7yKV6wNvhD1QGK9P+ei4QKBgQDAP7ivNVzbzWmswMVPb2GWJ38hlV/m1Tx6FurpMARcGLj3JPy+J3qsZO2+708MQFGu+NN/nrtEbwh0FM+D2X/V98FK7rlXjO6iL6c9HtfBjxPdNAhIR2nRbE/8e5iefObKiyNHQAZAvqWfAQUGi5jMgK5+ZYMalJjjRaTfn3eZOwKBgQCmKn+NeByHeXC+izh081yvNvlQDlzfhFEFughy/K1/25fLwAVP0MRLX1XDJms8OdYPQg14rlyAyZ9e0xJkK/PuvpzlIZoGi3bnZKvqrKajaJpafDm3Kh3i7uuP6Y96s7hlyjUL9w27Xu7f/4PPR5rXzwEz4HhutBdUhNhx3koaIQKBgQC+xr00CUVjzdzfFND4efQiOIGdRwlLHTINie6FhyPcbKAoiSjSXoUKzIFtJzePVch5VO00yMTXLUP7RaeEFPMZ1umWvX1pVy57/cP9ED1VE/HHYloRt+RXcR+S0ufp5tJ0Dkzs6KkL2OSr/CwLib4QumXugjfuyaVKa5MoYqwhfwKBgFAsLwH38AD6pStdrQD5ff/NYyB49Q1Sj6nlV2/ztSKK4/V91tlhBVzLb8SqwsuDXT7UukBNQcVT5xF1PKkml+Y6OKfo+jF1UijQN2kbwS4aPcSE43vfmiCO60TuI/ySr9M5qWfJSFZicCDuQLoJTE7ZhDyXfBVFyQBGPNzj80ka';

      case '@ridiculouscancer':
        return 'MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCZKAkM2CMU7TCzOrDWa+R3PCT66TTURsAqJlbM9W8QJgf4CJo2t3umhSyF1FxVzzvZYAELJ8sr/0pMoljp4LODODdVBEvRw5Hxkxnzmk0TLaA+9Fd9JTAP3cbmWH8imu+hSjiFwjKqdhqLj0BXsWUbRTvKtOtiiOCYml5VETp9JiiftjqGAxW3/VeumKTws2jjVs095eWBMX9E5/sy6C2/katlj3/IhwtLq7Fa0yI+0819TBpkH5tuUbOiy25zKHI9zBhgM8jrBnVJOHIZy4zN8OwuWbcWzI0PZMcpyoM/2HIBCpi1qxQrRyozaKbAfcQRSG/9ZGZpMXhthSbLvPQ3AgMBAAECggEAU5x5pFtye4ApsA8Ab26jYTyia6BYyPJ/AgPAK1Bp+4TnoM8BcZGlnXjin4UZi3cBE2DH8REeZ7yNEV0n8TZMifxsqKsZwUBlMl6+MjEwlqG38+ZsxNNCc8b9SM9TSM8QtxrP1KX6BvlG8J2Z4MXljoezZqxyPG7BPk435XTsW1lV8WB/7cVyXBZcRW+LB5PcBE+BDDOQ/FmnMwfugAGSiSRQXMezy3xThVQKskpCpvVEEMv5IcLBqd9DzvztisW2hYoocfzP0BkQpsVWLvF/nPrdUjn/ub3e58c4US6dw1ok98goek0CYB2WrGvCSlqtfsmNc+zEn55m+uz+5j90IQKBgQD36Z++MG9L/DgIOLg5AiiPyjUx3yxuqSU7OD/vBh4PbdBQo5eguZcDe67oPHLtKSEQhYJUV1592AmLQMWdk4ljZbQ0/AqBVyaJxzsf2UDf2psBslDtVO79ILj3aZ25UNE3XGD5fbgkYQCfDufEDDZrxuT2zmTEVVK0+XRei+YwOQKBgQCeJxSEC7JiA7f4cKBDsnJD+1rIJks8iy6K6PVBgrHbukXb1I6dG3Gww6tUiw6Wh8R9eM+kNRxVqk9UXxkd8AMbh05L+JvsFZQZBChcQM0zc4LVmQSUyCLn+Qua6d51+XJphlv4stnYeGfWna5x7C7KCLXXvJIKI/2ge8Adh+dn7wKBgBEh2wE4tahJoNGoocqGxKjTL4PnyVlIZSNHituIz7D/RMMd2w+nY7FA7eBstQCAtCFBKLWNaCFIObie3Ek8deUhlSeIN22iyS4CT6qux9XwdH/Ug9Uy5mUlysKGUPkKhbrOroDvWDdjYLidPhUFRwmBsDcCImKTBuksyAb0og65AoGBAJTGaKtLIZTIsMDamjj03j8LbjwIohAjUjZErarh2pS8J0mELGCo14uUllDiu2dp8rKh+psbhzsjCptxFnyuMw4re8FF7s/pALeDzL/0CdVT3Yk3+DJKD2QvSPaC+M38Sd/xEAXlob7cjbo7/UWYC+/sv7th3fQCJW5Z28Er/skrAoGAAKnMCHP6SzEeoH9Z7BoLlJtItC6vVNaztq/FXIvpXf4QEwdWIoyZWbcDpii66iQRLIFVx3ORs5Lqcet70VP/w/ak605vrW39UVq67cnxNw+S23iVkE64s+5hxlge/w1NBgk53zTSxw6fvTAaTybhBa1Sajvv89n7dLyRF2T5E14=';
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
