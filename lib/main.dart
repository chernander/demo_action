import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  String envValue = 'desarrollo'; // fallback por defecto

  final envPath = "${Directory.current.path}/.env";
  final envFile = File(envPath);

  if (await envFile.exists()) {
    await dotenv.load(fileName: envPath);
    envValue = dotenv.env['APP_ENV'] ?? envValue;
  } else {
    debugPrint('⚠️ Archivo .env no encontrado, usando valor por defecto');
  }

  runApp(MyApp(envValue: envValue));
}

class MyApp extends StatelessWidget {
  final String envValue;
  const MyApp({super.key, required this.envValue});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Ambiente')),
        body: Center(child: Text('Esto es ambiente $envValue')),
      ),
    );
  }
}
