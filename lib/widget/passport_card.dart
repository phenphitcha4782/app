import 'package:flutter/material.dart';
import '../models/passport.dart';

class PassportCard extends StatelessWidget {
  final Passport passport;
  const PassportCard({super.key, required this.passport});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: const Icon(Icons.badge, color: Colors.blue),
        title: Text(passport.fullName),
        subtitle: Text('Passport: ${passport.passportNumber}\n'
            'Expiry: ${passport.expiryDate}'),
        isThreeLine: true,
      ),
    );
  }
}
