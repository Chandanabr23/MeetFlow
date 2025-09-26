import 'package:flutter/material.dart';
import '../models/user.dart';


class UserTile extends StatelessWidget {
  final User user;
  const UserTile({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.avatar),
      ),
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle: Text(user.email),
    );
  }
}
