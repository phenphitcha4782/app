import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/passport.dart';
import '../provider/passport_provider.dart';
import 'package:image_picker/image_picker.dart';

class PassportFormScreen extends StatefulWidget {
  final Passport? passport;
  const PassportFormScreen({super.key, this.passport});

  @override
  State<PassportFormScreen> createState() => _PassportFormScreenState();
}

class _PassportFormScreenState extends State<PassportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _numberCtrl;
  late TextEditingController _nameCtrl;
  late TextEditingController _nationCtrl;
  late TextEditingController _dobCtrl;
  late TextEditingController _genderCtrl;
  late TextEditingController _issueCtrl;
  late TextEditingController _expiryCtrl;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    final p = widget.passport;
    _numberCtrl = TextEditingController(text: p?.passportNumber ?? '');
    _nameCtrl = TextEditingController(text: p?.fullName ?? '');
    _nationCtrl = TextEditingController(text: p?.nationality ?? '');
    _dobCtrl = TextEditingController(text: p?.dateOfBirth ?? '');
    _genderCtrl = TextEditingController(text: p?.gender ?? '');
    _issueCtrl = TextEditingController(text: p?.issueDate ?? '');
    _expiryCtrl = TextEditingController(text: p?.expiryDate ?? '');
  }
 
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _numberCtrl.dispose();
    _nameCtrl.dispose();
    _nationCtrl.dispose();
    _dobCtrl.dispose();
    _genderCtrl.dispose();
    _issueCtrl.dispose();
    _expiryCtrl.dispose();
    super.dispose();
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final newPassport = Passport(
        id: widget.passport?.id,
        passportNumber: _numberCtrl.text,
        fullName: _nameCtrl.text,
        nationality: _nationCtrl.text,
        dateOfBirth: _dobCtrl.text,
        gender: _genderCtrl.text,
        issueDate: _issueCtrl.text,
        expiryDate: _expiryCtrl.text,
        photoPath: _imageFile?.path ?? '', 
        
      );

      Provider.of<PassportProvider>(context, listen: false).addPassport(newPassport);
      Navigator.pop(context);

      final provider = context.read<PassportProvider>();
      if (widget.passport == null) {
        await provider.addPassport(newPassport);
      } else {
        await provider.updatePassport(newPassport);
      }
      if (mounted) Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.passport == null ? 'Add Passport' : 'Edit Passport'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => SafeArea(
                        child: Wrap(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('ถ่ายรูปใหม่'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.camera);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: const Text('เลือกรูปจากแกลเลอรี่'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: _imageFile == null
                      ? Container(
                          width: 150,
                          height: 180,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text('แตะเพื่อเลือกรูป'),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(_imageFile!, width: 150, height: 180, fit: BoxFit.cover),
                        ),
                ),
                const SizedBox(height: 20),
              TextFormField(
                controller: _numberCtrl,
                decoration: const InputDecoration(labelText: 'Passport Number'),
                validator: (v) => v!.isEmpty ? 'Enter passport number' : null,
              ),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (v) => v!.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: _nationCtrl,
                decoration: const InputDecoration(labelText: 'Nationality'),
              ),
              TextFormField(
                controller: _dobCtrl,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
              ),
              TextFormField(
                controller: _genderCtrl,
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              TextFormField(
                controller: _issueCtrl,
                decoration: const InputDecoration(labelText: 'Issue Date'),
              ),
              TextFormField(
                controller: _expiryCtrl,
                decoration: const InputDecoration(labelText: 'Expiry Date'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
