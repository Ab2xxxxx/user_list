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
      body: Column(
        children: [
          SizedBox(height: 15),
          CircleAvatar(
              child: Icon(Icons.person_outline, size: 70),
              radius: 70,
          ),
          SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
                  leading: Icon(Icons.face),
                ),
                ListTile(
                  title: Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
                  leading: Icon(Icons.email),
                ),
                ListTile(
                  title: Text('Phone: ${user.phone}', style: TextStyle(fontSize: 18)),
                  leading: Icon(Icons.phone),
                ),
                ListTile(
                  title: Text('Website: ${user.website}', style: TextStyle(fontSize: 18)),
                  leading: Icon(Icons.cloud),
                ),
                ListTile(
                  title: Text('Address: ${user.address}', style: TextStyle(fontSize: 18)),
                  leading: Icon(Icons.location_city),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
