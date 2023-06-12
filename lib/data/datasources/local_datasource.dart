import 'package:shared_preferences/shared_preferences.dart';

class LocalDatasource {
  Future<void> saveToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
  }

  Future<String> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString('token') ?? '';
  }
}
