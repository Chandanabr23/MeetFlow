import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'package:hive/hive.dart';

class UserRepo {
  final _box = Hive.box('cacheBox');

  Future<List<User>> fetchUsers() async {
    try {
      final res = await http.get(Uri.parse('https://randomuser.me/api/?results=10'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final users = (data['results'] as List)
            .map((e) => User.fromJson({
                  'name': e['name'],
                  'email': e['email'],
                  'picture': e['picture'],
                }))
            .toList();
        _box.put('users', data['results']); // cache
        return users;
      } else {
        throw Exception("API error");
      }
    } catch (e) {
      // offline cache
      final cached = _box.get('users');
      if (cached != null) {
        return (cached as List)
            .map((e) => User.fromJson({
                  'name': e['name'],
                  'email': e['email'],
                  'picture': e['picture'],
                }))
            .toList();
      }
      return [];
    }
  }
}
