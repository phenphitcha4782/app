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
                  content: const Text('แน่ใจหรือไม่ว่าต้องการจะลบข้อมูลนี้'),
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
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "PASSPORT",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (passport.photoPath.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(passport.photoPath),
                        width: 120,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Container(
                      width: 120,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(child: Text('No Image')),
                    ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Passport No: ${passport.passportNumber}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('full Name: ${passport.fullName}'),
                        Text('Nationality: ${passport.nationality}'),
                        Text('Date of Birth: ${passport.dateOfBirth}'),
                        Text('Gender: ${passport.gender}'),
                        Text('Issue Date: ${passport.issueDate}'),
                        Text('Expiry Date: ${passport.expiryDate}'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey),
              const SizedBox(height: 8),
              Text(
                'Additional Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
