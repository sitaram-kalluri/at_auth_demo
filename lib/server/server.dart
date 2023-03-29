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
          'MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCb8aqNJTn5JOPy5uEIeM4bqSm3MN2F2zYcLQMYCru9efxAOYVAgSbzfilNmNSAIHiULRvkZlgqvNJcIMVA6/Bsf4rVI2LahuzFXMzYstZArzfpwAxE4ri38IjG2brV8GJiuN/Nd90/GD7i1LhtEp9kt/4L+1HLzO90FVC0YWW61lgbg0pvGbzkHCV0SMq5SqbeAnPmlDaQPkDpzv6O6L66+U+D1gSkqhqJ9avwiBuw3BFshNGPB/O1/OUz2IwwUcv24O89VEoXhITqpPP13fLRAJQph/bLAoD3lqng7IfOeiWskEyYbTbt8gySLX/FyxaYUxRKBD8i5WkXJU7sFEu5AgMBAAECggEATNEXnV2YGCVW8EFQ2pZ/mNqUhPvaM2TPW8PEgWRQJL7hRlXPUP4NzOX5vJKrIs5b90ndMn5DshG/Ych2wks27ItLPUCoIlNScMoM0jYOGmD1nvyOTqSML3eaOLHqOhamsFC3VgRUhQ8RczUr//arc7a6uvY6zbSOw9T4I1LTBNxlq4cYK8UVlpEkpH5mJHhnrFmgmzeWBTaNL7+N22vd1tPmg3b/hJnR/6ANc+xHC4m6tCtPeFevmKUFJtg5TbTwc8bW92hPhzNKUumGahQtaP+27gCPm5qjq/RrquxO3+WYHJQG86na3yvk1r9eFQn02il/1RBeUegG1h+aiXekzQKBgQD34wKoYf9H5t2me8pccggJOBtMLrNcQr+JJiRtYdU0Q9TEpow/UnPWe+F1R7lK26puto3C0TWMspqCgwdpXpFW3cNuEvdsao4gzQXoK3mcPckWzec4ItCNbyy7oA+ikvveH524JWMJzMdUjm6twRpFRwZFNbHOSy/QBzwj/IPSswKBgQChDEmSBJ/Rls7lsnT5K8tz1/5ZsYx8JyhPkD49ghpDaotTo00HtIwwbM8MbtvIBi+4+orfi7AhRntj13LC7pEni9WZOQXcIhiUnPnnZ0+7hVq2+H4iS2XXmWILH5DHOWFV3NT9RNN0uGAgW9QpOEpA6ehYbZ5j2e9WWto/E70t4wKBgQC+Sdivc9Lo2jPKanrUboD2ushRugPbzi2EVfBeu1xUa8G4V/WPYncj7iMLycxWx7vUk3TNWZZW9IAhsf4NiBff7Arqw8qFwmJqkZh4Om93XgKw680UTb105SQcv+lgrp6ETBbh1mlpi3Z01YXnAjZtefE5Tde5egQxGGy1X1G+ewKBgArCwmuySWd8tyhb6zr29SoxZXpixatKBoSCc9YySkT06ohVIgGAy9k0fAUtpxvPZgLrIrpbIBKpHfeG3tEtlZ9Z1ZTeXYje8luDvaL7oTU7bNtK8UqjVRO52PY7TrYxHFLbZZPitGpZI3smB6AVdciumGrIMEwltLtFaM3MKNjXAoGAV3GdTRxFjv5rBApOJRlsMVnaPEv0Qv2lUkDz4xiW6HTtQBVTy9KsfCDneOEO2PBCo0zyu/oefFrpXGH8sqzRY5vWYFT9jpLbn+vRZgRIXx8BYnpTvQGhS8luuW9KtsfYOQNYDYebVDrqNeHzRlkdSkpHolfnjkYUi33wvNA4dd0=';
    await AtClientManager.getInstance()
        .setCurrentAtSign('@scorpiopersonal', 'buzz', atClientPreference);

    String oAuthEncryptionPrivateKey =
        'MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCWNYRIAPHcFkZr+oYrSrB+AmsQ+GnzecGgEiZe9d+9gt/WroZHFrlGvEAa+sVBmMxfMQwrx5m4X4nFekuXKpUmzf0GXCMwHcL9kZxxkEa4rBjOn49apO85HdNCvWHayL9cVoOZoD9skpxcItaWx3OVmC+73TUaimhZY5Kha3kEXan51tOKzzZ3iOuIjS0jbgPE7hU0LzKBwJKdB4s/gkz+37aYSKDFAl+/CWLeJwZX84BJv81KZovqanzB61FNVLJo4b3PyRLVgyfBHYZ6tg/WfuzozKak6g2ezOQvurxxDUx1XFvON/SKvsURuZp4+S+BkAxbBV5BJ8Y/Vv91vEDDAgMBAAECggEAW5LQzFzXFkf2MsoOlcH5CzlKMJRhc2/dHUszXV0kRBLPh7/qWNh/p6IIquoK68zNe5MZSm9rRb3o7h16i/QH7hpSkVgGk8TxJUlqSMmec+NnVEBuUuKOfRGzw9JVH96W2yJbJINPZ0+SR5FtpYp+6spW/38CauXKbASKViKBKqlD+FDqJ1XAlpM/lykahAMgVrne7DGSCwAX9Ka3bIimdsCIfOSWti2kyHVIedlXZ6bi+9uzHZ2XGAgqZaWFLDBK16DM4AWZ9SU5GkoMFKGiEQIZRx3EE6gUlLOCf3EzLh6gyZWH7GdlDM0L8TBH/CrBNsPxSI7XappLCYcW0A3LQQKBgQDtrHmFpec+kk3fwlAZC9WHpO9wQs3YudTiSLrhJbI95JX+4p9asm3OyZqHWa13+Itf1PUQyJoF1ggs2y7bdCkQ4syUyIVJiHQHPZoRnfIvmrXmjDvQ3rFPycAhfzpsueTSHM78FWrItwVPP1CNILhLQ+sCuxsMe3zhzm8uuLTIUwKBgQChyovEeuqBkyqG2DAFuD5UuHnVqgMIYMlqgoSWZYWPf1NlyebQB/erVK8+3OXOmAHwIIfZmdJwilx6iYJuElckqFAn9aDv0TxMIBorEh1em72ule4/MSjc0DFGWtLl/ETrurYJyWNZwPnS62KFm7FVADDLeFElIRBpum+IuZ3X0QKBgQDNKWENGRTwUmKekKGLvUdpe9qkUUZXmrJFUvredyfRfYxtJTrhk7xuEGEwDR1MvmOxKacSAdfSydrsvZdJIJCCXwSyOhW0T/G4fliMdIcmyKnUhaDswA7XDRSo1aadTCpVpUCXIfW3pSUUL1ddO61aaxpmlRTYRZCbaxNWhWKouQKBgDPcJ8b4G1kjYhtNCr+amigv5aWuVECIPaetZHCM5C3mA0Z6XEjMdP/vKik9R1BceyqMUt9WJhU61H/Wuf8sU9CFPwRAALE+YVSJabnqmY1s4HUoy/BngpCdD15c2IMtxK3G8Hjcm8L2T13jY3YuPL5hTEK8M05ydb9eKkgqL0UxAoGAAmVwiaVc1erQ3p8CcC4eXIhj5YU93rHa0yM6MxkoQfCRXGKvB3/gs63s3uuZglPJ1rQVpf98ZzN39PRAVuN30qSxMXO3d71LjtMnlxxA8XdBciE5w/Yo8j4bXNwSWcKq+Jc4GCPBs9K1btoJlH3X3dt7UTMoXqisvf92K6oSmVU=';
    await AtClientManager.getInstance()
        .atClient
        .getLocalSecondary()!
        .putValue('privatekey:privatekey', oAuthEncryptionPrivateKey);

    String oAuthEncryptionPublicKey =
        'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAljWESADx3BZGa/qGK0qwfgJrEPhp83nBoBImXvXfvYLf1q6GRxa5RrxAGvrFQZjMXzEMK8eZuF+JxXpLlyqVJs39BlwjMB3C/ZGccZBGuKwYzp+PWqTvOR3TQr1h2si/XFaDmaA/bJKcXCLWlsdzlZgvu901GopoWWOSoWt5BF2p+dbTis82d4jriI0tI24DxO4VNC8ygcCSnQeLP4JM/t+2mEigxQJfvwli3icGV/OASb/NSmaL6mp8wetRTVSyaOG9z8kS1YMnwR2GerYP1n7s6MympOoNnszkL7q8cQ1MdVxbzjf0ir7FEbmaePkvgZAMWwVeQSfGP1b/dbxAwwIDAQAB';

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