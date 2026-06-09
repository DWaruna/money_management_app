

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/local_storage_service.dart';

class AppStateProvider extends ChangeNotifier{
  final LocalStorageService _localStorageService = LocalStorageService();

  bool _isLoggedIn = false;
  bool _isDarkMode = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> init() async {
    _isLoggedIn = await _localStorageService.getIsFirstTime();
    _isDarkMode = await _localStorageService.getIsDarkMode();;
    notifyListeners();
  }

  Future<void> setFirstTime() async {
    await _localStorageService.setFirstTime();
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> setDarkMode() async {
    await _localStorageService.setIsDarkMode(!_isDarkMode);
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

}