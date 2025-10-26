import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/passport.dart';
import '../provider/passport_provider.dart';
import 'passport_form_screen.dart';

class PassportDetailScreen extends StatelessWidget {
  final Passport passport;
  const PassportDetailScreen({super.key, required this.passport});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PassportProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(passport.fullName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PassportFormScreen(passport: passport),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Confirm Delete'),
                  content: const Text('Are you sure you want to delete this?'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete')),
                  ],
                ),
              );
              if (confirm == true) {
                await provider.deletePassport(passport.id!);
                if (context.mounted) Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (passport.photoPath.isNotEmpty)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(passport.photoPath),
                    width: 150,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                width: 150,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Text('No Image')),
              ),
              const Text(
              'ข้อมูลส่วนตัว',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            Text('Passport Number: ${passport.passportNumber}'),
            Text('Full Name: ${passport.fullName}'),
            Text('Nationality: ${passport.nationality}'),
            Text('Date of Birth: ${passport.dateOfBirth}'),
            Text('Gender: ${passport.gender}'),
            Text('Issue Date: ${passport.issueDate}'),
            Text('Expiry Date: ${passport.expiryDate}'),
          ],
        ),
      ),
    );
  }
}
