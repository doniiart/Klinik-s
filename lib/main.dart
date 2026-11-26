import 'package:flutter/material.dart';
import 'helpers/user_info.dart';
import 'ui/beranda.dart';
import 'ui/login.dart';

Future<void> main() async {
  // Code by : Doni Arianto || 19232429
  WidgetsFlutterBinding.ensureInitialized();
  var token = await UserInfo().getToken();
  print(token);
  runApp(
    MaterialApp(
      title: 'Klinik APP',
      debugShowCheckedModeBanner: false,
      home: token == null ? const Login() : const Beranda(),
    ),
  );
}
