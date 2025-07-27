import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thamra/core/di/service_locator.dart';
import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
