import 'package:flutter/material.dart';

import '../services/authentication_service.dart';
import 'data_shared_screen.dart';

class AuthenticationPage extends StatefulWidget {
  final AuthenticationService authenticationService;

  const AuthenticationPage(this.authenticationService, {super.key});

  @override
  _AuthenticationPage createState() => _AuthenticationPage();
}

class _AuthenticationPage extends State<AuthenticationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String authVerify = '';
  final decryptCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.authenticationService
        .getPublicKeyForAtsign(widget.authenticationService.atSign);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication Page'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              readOnly: true,
              initialValue: widget.authenticationService.encryptCode ?? ' ',
            ),
            TextFormField(
              controller: decryptCodeController,
              obscureText: true,
              validator: (input) {
                if (input!.isEmpty) {
                  return 'Enter decryption code';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText:
                    'Enter decrypted value of above string using PKAM private key',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  widget.authenticationService.decryptCode =
                      decryptCodeController.text;
                  await widget.authenticationService.checkDecryptValue();
                  if (widget.authenticationService.authStatus == true) {
                    print("Auth Success");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DataSharedScreen(
                                widget.authenticationService)));
                  } else {
                    authVerify = 'Enter correct decryption code';
                    setState(() {});
                  }
                }
              },
              child: const Text('Submit'),
            ),
            Text(authVerify ?? ''),
          ],
        ),
      ),
    );
  }
}
