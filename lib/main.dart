import 'package:at_client/at_client.dart';
import 'package:flutter/material.dart';
import 'screens/login_page.dart';

/// OAuth atSign is @scorpiopersonal
/// User 1 is @general57
/// User 2 is @ridiculouscancer

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: LoginPage());
  }
}
