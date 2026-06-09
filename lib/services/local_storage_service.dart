

class LocalStorageService {

  static const String isFirstTime = 'isFirstTime';
  static const String isDarkMode = 'isDarkMode';

  Future<void> setFirstTime() async {
    final prefs = await SharedPreferences.getInstance;
    return prefs.getBool(isFirstTime) ?? true;
  }

}