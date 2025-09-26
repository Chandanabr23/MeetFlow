import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/user.dart';

class UserListScreen extends StatefulWidget {
  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];
  bool loading = true;
  final _box = Hive.box('cacheBox');

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => loading = true);
    try {
      final res = await http.get(Uri.parse('https://randomuser.me/api/?results=10'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        users = (data['results'] as List).map((e) => User.fromJson(e)).toList();
        _box.put('users', data['results']); // cache
      } else {
        throw Exception('API error');
      }
    } catch (e) {
      final cached = _box.get('users');
      if (cached != null) {
        users = (cached as List)
            .map((e) => User.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else {
        users = [];
      }
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users'), actions: [
        IconButton(icon: Icon(Icons.refresh), onPressed: _load),
      ]),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, idx) {
                final user = users[idx];
                return ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
                  title: Text("${user.firstName} ${user.lastName}"),
                );
              },
            ),
    );
  }
}
