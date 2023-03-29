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
    // widget.authenticationService
    //     .getPublicKeyForAtsign(widget.authenticationService.atSign);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text("Authentication Page",style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        children: <Widget>
        [
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  readOnly: true,
                  initialValue: widget.authenticationService.encryptCode ?? ' ',
                  decoration: const InputDecoration(
                    labelText:
                    'Encrypted String',
                  ),
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
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange[100], // background
                    onPrimary: Colors.black, // foreground
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      widget.authenticationService.decryptCode =
                          decryptCodeController.text;
                      await widget.authenticationService.checkDecryptValue(decryptCodeController.text);
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
          ]
      ),
    );
  }
}
