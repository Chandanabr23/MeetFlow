import 'package:hive/hive.dart';

class AuthRepo {
  final _box = Hive.box('cacheBox');

  Future<bool> login(String email, String password) async {
    if (email == 'test@test.com' && password == '123456') {
      _box.put('loggedIn', true);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _box.delete('loggedIn');
  }

  Future<bool> isLoggedIn() async {
    return _box.get('loggedIn', defaultValue: false);
  }
}
