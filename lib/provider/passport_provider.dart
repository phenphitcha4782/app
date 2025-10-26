import 'package:flutter/material.dart';
import '../services/database_helper.dart';
import '../models/passport.dart';

class PassportProvider extends ChangeNotifier {
  final _db = DatabaseHelper();
  List<Passport> _passports = [];

  List<Passport> get passports => _passports;

  Future<void> loadPassports() async {
    final data = await _db.queryAll('passports');
    _passports = data.map((item) => Passport.fromMap(item)).toList();
    notifyListeners();
  }

  Future<void> addPassport(Passport passport) async {
    await _db.insert('passports', passport.toMap());
    await loadPassports();
  }

  Future<void> updatePassport(Passport passport) async {
    if (passport.id == null) return;
    await _db.update('passports', passport.toMap(), passport.id!);
    await loadPassports();
  }

  Future<void> deletePassport(int id) async {
    await _db.delete('passports', id);
    await loadPassports();
  }
}
