import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:user_list/models/user.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String _error = '';

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _users = data.map((json) => User.fromJson(json)).toList();
        final box = await Hive.openBox('userBox');
        box.put('users', response.body);
      } else {
        _error = 'Ошибка! не удалось загрузить данные';
      }
    } catch (e) {
      final box = await Hive.openBox('userBox');
      if (box.containsKey('users')) {
        final cachedData = box.get('users');
        final List<dynamic> data = json.decode(cachedData);
        _users = data.map((json) => User.fromJson(json)).toList();
        _error = 'Загружено из кэша';
      } else {
        _error = e.toString();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}