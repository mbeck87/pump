import 'package:flutter/material.dart';
import 'manager.dart';

late final Manager manager;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  manager = await Manager.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pump',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Wochentag",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            manager.getCard("bankdrücken"),
          ],
        ),
      ),
    );
  }
}
