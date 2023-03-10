import 'package:atsign_login_app/screens/login_page.dart';
import 'package:flutter/material.dart';

import '../services/authentication_service.dart';

class DataSharedScreen extends StatefulWidget {
  final AuthenticationService authenticationService;

  const DataSharedScreen(this.authenticationService, {super.key});

  @override
  _DataSharedScreen createState() => _DataSharedScreen();
}

class _DataSharedScreen extends State<DataSharedScreen> {
  // Authentication_Service authentication_service = new Authentication_Service();
  String personalInfo = "No data";
  String contactInfo = "No data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Shared Page'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${widget.authenticationService.atSign}'),
            const Text('Data Shared To you'),
            ElevatedButton(
              onPressed: () async {},
              child: const Text('View Claims'),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    personalInfo =
                        await widget.authenticationService.getPersonalInfo();
                    setState(() {});
                  },
                  child: const Text('Personal Info'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    contactInfo =
                        await widget.authenticationService.getContactInfo();
                    setState(() {});
                  },
                  child: const Text('Contact Info'),
                ),
              ],
            ),
            Text('Personal Info $personalInfo'),
            const SizedBox(
              width: 10,
            ),
            Text('Contact Info $contactInfo'),
          ],
        ),
      ),
    );
  }
}
