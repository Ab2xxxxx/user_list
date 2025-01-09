import 'package:flutter/material.dart';
import 'package:user_list/models/user.dart';


class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Phone: ${user.phone}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Website: ${user.website}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Address: ${user.address}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
