import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/passport_provider.dart';
import 'screens/passport_list_screen.dart';

void main() {
  runApp(const PassportApp());
}

class PassportApp extends StatelessWidget {
  const PassportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PassportProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Passport Manager',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const PassportListScreen(),
      ),
    );
  }
}
