import 'dart:convert';
import 'dart:io';

import 'package:at_client/at_client.dart';
import '../services/authentication_service.dart';
import 'package:atsign_login_app/model/contact_info.dart';
import 'package:atsign_login_app/model/personal_info.dart';

void main() async {

  final server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
  AuthenticationService authenticationService = AuthenticationService();

  Future<AtClient> initializeOAuthAtClient() async {
    final appDocumentDirectory = Directory.current;
    String path = appDocumentDirectory.path;

    var atClientPreference = AtClientPreference()
      ..rootDomain = 'root.atsign.org'
      ..rootPort = 64
      ..isLocalStoreRequired = true
      ..hiveStoragePath = path
      ..commitLogPath = path
      ..privateKey =
          'MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCgBixsDZMtOUxrgOw2zcUEoyYptak3gX4hoeHGN2kkio20jtO8VvVm3mkayD9SibN+uz3vxQpA1RbFXlRolp1n+aCyNoJt9Cz0k4O3iJVFhc3pKauqx4ffToi3wICAonLUx4vNImEZR4/c85ILIw24I6H74RK+ctbrqJ4jV5v0QoemB/x2Y+x8GWQ8l1uB3cykTVY4e4M4Ys8qHNAWGPvgbxRA2/OtYzyakWMpMlk3QYC8eTSgNEWKqKL7m3HItKr1FhpNQ7wNBt7oxp+MPE1v7mUjBuQ0kT1Gep+4K4F7B4goHYSkKt/LSWo1v9CYoUta8ST5/tbl0dtMr9VM1A7pAgMBAAECggEARxEWz1HkB9SHhMK3pMsTcTDHdQSRRu5CRstuyim3jxvdPM+lZuIzj+C8SsGdpZkz1tdu9TnLiOlZeIOg9uXUt+VboWml2RD0mhWdDHgi2sJGpQL1kx2T0O8+tmRObVI3rxmDk7Ft790hHd4qALorkJh6irL1MREtM3Ep8cYpo3rkf3FflWrarL2NTBevQpmBU0HyaGRWznOw2/2E+3JpccdLYdp1SG78RAyaEwqCe6xvZE5J6KpdnQjOoVXzw+OnwrgWIn82tD2Wz46LynAdNZTyvIVTn8MRxsrZ67tAoL1K/M83DNZ3gQLzKVCJ9lxhhEmZI7ImM/Y4R3MBMNSXlQKBgQD6odSF5xyCEIfq1kgHFYE0i4FYhuH0V7JeIX/ny197/3MrBJ/FZSSmf2VY7n+Rdf4iQySboDpWLRWAIKPH9oQ7G6EwsKtc40oRUtNRC/1v6HXQicobkEloxkXWOPXtkdksmhNNP9okPf1XqsaX93DfXUDd7i0ADaZXrk4KpWpWfwKBgQCjc45kq8X3znTuhJ7C0OzqUA7eMXc6AmqghA7LfHPG0tfAGKhgQHL3tk/8r968ni+8gvAvALr2wBwWuYnbQScOEFxtLpn2RRS1DZrBwq49d4yhx35hkEyi+SRgc/wBqgdDUlmpJY2fXb5PWrJDd4VNQvZ7OoyFWdVC0IhmN4P2lwKBgQC6GuDMbUhl7BCA+IyTdgxzEAQD0GSII3Z3HzjyzbkhQhYqo0xgLzJ/z6lZ1/8x7APBPUo5pUisJN4KPjJfkVWu7l1K4mTcnImrQ21WiSivqFWTfD1vKjzYaCIDaFh1CA/TZrVeb0N0FfPA3TaKMVrHAV/ha7JOj9Qs12lrzlif0QKBgCwKyBSSQG6sX8+hRpIh76SXW9o9I+4qloaX7tCfwSaSy3XEbyI4W4IpytXAodjbGuvFsGhJ3xb73tW0utOsc5STjgQRaYT1SkYa21dYWNDRNMCm24P4eN31GfsvZXkhUoGuX+B28Pk/Ljd9rckGHJIb+ARuW0zXTuKJBCfez50TAoGAH/aOxVI7WkKwfIDD2by4Mtw7CdItfs7aIieIm63VGWd7HwmeJmQz++kcVOPSZ+FErLiryu/4Pouq7M0RlupOQIAKiJw2ORK7nhmDwq/Z+5ptZODxLKDm0qfqR9mT3/pPV+DJ/kDiztQPLsOPxNOPGD15lrrUW2geBlozg3L+XoY=';
    await AtClientManager.getInstance()
        .setCurrentAtSign('@scorpiopersonal', 'buzz', atClientPreference);

    String oAuthEncryptionPrivateKey =
        'MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC6lfckezTbaU2hC728fyuR++ridRXR+SnY1a5dgrSDWwhyqbli8wlSCbv8Ae+zTPOOvRFNlDD9xPBpx9ZKhQZngZ0sMXfsG1IM0vMhXRk1kOaOhhdqTZCDCzGdj1E9y1JUSilaVz4TR00yu3Jyk+xwfc494hcgw/E/ryCaspQ0SfI4X1zbE9M3+0oq+eBNVhekiv/NQQUzgSB7l010T6XCi4iItPXFDRDVug2OUNzi8LuJNUVB22N0eLOLj1GQT7hcGoLxh3eIyT8WuryCW1nLkKOHz/rOny/7sx0NxRIp+0SDe6qXpngi2nvBnjBmnxfXwoUEK88u7gw4WDSQ6xIzAgMBAAECggEAXPD4k4Z/tM+GaLMVhwB9rpEi1jzmappHmwgNe+zwiAHfemZKvxw6x0+sAQLh6JlrNO2+4brwkGf6LWbqumH657IrnWjiyIxvWY32p+bc+M692b63iS8rzerUgxxxpmtSDkSGxsZwWGAK9zth7er7OqmgAzlMtfiEgml0vzo3ErfsPiZUQU0GYiZfu6pQFj/25ef53mF1uxzyIV/lCZotpUOFZ+aOktWocsiaStVA0ux4XoLKTDlQaK/0iX0i1Dxqy/QaXoEQpAcWMgaiI7FamP3RZeAWTk+CBdC8aS0BjTjbZ4jx/Ut0wocnSWywc/53MumvoaNmHbxDvXLxUvkKMQKBgQDvLqNh49zWJOqzCcE9vA1i3vTQlrnBD6xSZ4ap9Zvw+82iMdHoBkNbVJOU29Uw3BJV12Wb/yyda8jW0FTABometj71hnRkgBFjeWFYN6QUzBwDQ6QE8NqllgQigjV+mYXqaw5YCU8qVcHFc/EUybDuBribj0fHJADq7H1chs6/awKBgQDHtJMAx4qeEWt+t68g7ZVMEz0OA+n4xEGcJXFJi0VaPNsRBxBsZPTsdxSxdiic5foz0+4g66PoU6MoEr1QipJf4Joz+el2wlzLqcuxzIsJ6f0qsc5XitU3wZ/PhGPaF8aQ4kqaJKbaIfpzmGr6T4/67Tk51XrJZnZUL1QQ+v8SWQKBgGj64nFLzxka2Py+UlfjW0jDLVcEYQGQ/ISqtduRVuG907LWBRi+7v9+LsyOdJNedJnC0fFXXeC2d09530jtVagYu6eOXTXjVD6B/yz2Nwl90OnJ3YrhoEY/gw8WcZ5gifurA3+2jk25mDQvQGhsYkEHKC33BH0um0yBgkCDVumDAoGBAK9v9bg4k5C7Euj2KpZNwNtdB0TZsWBF4LFwvy3xeFKGpZg20Xm30uYs0nP3rkPvULbZFhe7inldiDZ7B+7KXT53DGBeynb21hhgqL4gR4DFGw+3teJ350mdAmyGDEYanujGsuzpB98W/HMyUcBlxsGURrKE1OI67faUwVBNf2i5AoGBALdTdX497WWbtPwTZapBpvvHAGM49+bojB0p9gOww1TrxqMUZeMGAIMuEieexgc6QhjQXZV4fk+I2t++qCdcdJ9BoapQZdbiI8ZCUKe3xove+Pqhyfnp4fZ/TgxWOaR5j/0I4Ib/dXiaKKYpwvJD+4d3r7geElW2xF8d+OjxmyH0';
    await AtClientManager.getInstance()
        .atClient
        .getLocalSecondary()!
        .putValue('privatekey:privatekey', oAuthEncryptionPrivateKey);

    String oAuthEncryptionPublicKey =
        'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAupX3JHs022lNoQu9vH8rkfvq4nUV0fkp2NWuXYK0g1sIcqm5YvMJUgm7/AHvs0zzjr0RTZQw/cTwacfWSoUGZ4GdLDF37BtSDNLzIV0ZNZDmjoYXak2QgwsxnY9RPctSVEopWlc+E0dNMrtycpPscH3OPeIXIMPxP68gmrKUNEnyOF9c2xPTN/tKKvngTVYXpIr/zUEFM4Ege5dNdE+lwouIiLT1xQ0Q1boNjlDc4vC7iTVFQdtjdHizi49RkE+4XBqC8Yd3iMk/Frq8gltZy5Cjh8/6zp8v+7MdDcUSKftEg3uql6Z4Itp7wZ4wZp8X18KFBCvPLu4MOFg0kOsSMwIDAQAB';

    var metadata = (Metadata()..isPublic = true);
    var atKey = AtKey()
      ..key = 'publickey'
      ..metadata = metadata;
    await AtClientManager.getInstance()
        .atClient
        .put(atKey, oAuthEncryptionPublicKey);

    return AtClientManager.getInstance().atClient;
  }

  authenticationService.oAuthAtClient = await initializeOAuthAtClient();

  print('Server started on port ${server.port}');

  void handleGetRequest(HttpRequest request) {
    final response = request.response;

    // Set headers
    response.headers.contentType = ContentType.json;
    response.headers.add('Access-Control-Allow-Origin', '*');

    // Check for custom endpoint
    if (request.uri.path == '/@sign') {
      // Send custom response
      final message = {'message': 'Hello, @sign!'};
      response.write(message);
      response.close();
    } else if (request.uri.path == '/view/persona=basicInfo&sharedBy=@raj') {
      // Send custom response
      final message = {'firstName': 'Rajasekhar', 'lastName':'Kothapalli', 'profilePic':'image.jpg'};
      response.write(message);
      response.close();
    }
    else {
      // Send default response
      final message = {'message': 'Hello, world!'};
      response.write(message);
      response.close();
    }
  }


  Future<void> handlePostRequest(HttpRequest request) async {
    final response = request.response;

    // Set headers
    response.headers.contentType = ContentType.json;
    response.headers.add('Access-Control-Allow-Origin', '*');


    // Check for custom endpoint
    if (request.uri.path == '/@sign') {
      // print("params start");
      // print(request.uri.queryParametersAll);
      // print(request.uri.queryParameters);
      // print(request.uri.query);
      // print(request.requestedUri.queryParametersAll);
      // print(request.requestedUri.queryParameters);
      // print(request.requestedUri.query);
      // print("params end");
      String data = request.uri.query;
      String atsign = data.split("=")[1];
      print(atsign);

      // Send custom response
      authenticationService.atSign = atsign;
      await authenticationService
          .getPublicKeyForAtsign(authenticationService.atSign);
      final message = {"encrypted_code": authenticationService.encryptCode, "decrypted_code" : authenticationService.messageString};
      String str = json.encode(message);
      response.write(str);
      response.close();
    }

    else if (request.uri.path == '/validateAtsign') {
      String data = request.uri.query;
      String decryptCode = data.split("=")[1];
      print(decryptCode);

      bool result = await authenticationService.checkDecryptValue(decryptCode);

      print(result);

      var personalInfo = PersonalInfo();
      var contactInfo = ContactInfo();

      if(result == true) {
        personalInfo = await authenticationService.getPersonalInfoSharedBy();
        contactInfo = await authenticationService.getContactInfoSharedBy();
        print(personalInfo.toString());
        print(contactInfo.toString());
      }

      // Send custom response
      final message = {"personal_info": personalInfo.toString(), "contact_info" : contactInfo.toString()};
      String str = json.encode(message);
      response.write(str);
      response.close();
    }
    else {
      // Send default response
      final message = {'message': 'Hello, world!'};
      response.write(message);
      response.close();
    }
  }

  await for (HttpRequest request in server) {
    if (request.method == 'GET') {
      handleGetRequest(request);
    } else if (request.method == 'POST') {
      handlePostRequest(request);
    } else {
      request.response.statusCode = HttpStatus.methodNotAllowed;
      request.response.write('Unsupported request: ${request.method}.');
      request.response.close();
    }
  }

}