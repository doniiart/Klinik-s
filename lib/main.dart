import 'package:material_ui/material_ui.dart';
import './ui/beranda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Code by : Doni Arianto || 19232429
      title: 'Klinik APP',
      debugShowCheckedModeBanner: false,
      home: Beranda(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text(title),
      ),
      body: const Center(
        child: Text(
          'Hello, World!',
        ),
      ),
    );
  }
}
