import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/passport_provider.dart';
import 'passport_form_screen.dart';
import 'passport_detail_screen.dart';

class PassportListScreen extends StatefulWidget {
  const PassportListScreen({super.key});

  @override
  State<PassportListScreen> createState() => _PassportListScreenState();
}

class _PassportListScreenState extends State<PassportListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PassportProvider>().loadPassports();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PassportProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passport '),
        centerTitle: true,
      ),
      body: provider.passports.isEmpty
          ? const Center(child: Text('No passports found.'))
          : ListView.builder(
              itemCount: provider.passports.length,
              itemBuilder: (context, index) {
                final passport = provider.passports[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PassportDetailScreen(passport: passport),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PassportFormScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
