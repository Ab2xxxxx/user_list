import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_list/provider/user_provider.dart';
import 'package:user_list/theme/theme_provider.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  String _filterText = '';

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    dynamic filteredUsers = userProvider.users.where((user) => user.name.toLowerCase().contains(_filterText.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Фильтрация по имени'),
                  content: TextField(
                    decoration: InputDecoration(hintText: 'Введите имя'),
                    onChanged: (value) {
                      setState(() {
                        _filterText = value;
                      });
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Закрыть'),
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Provider.of<ThemeProvider>(context).isDarkMode ? Icons.brightness_7 : Icons.brightness_2),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: (){
              setState(() {
                userProvider.fetchUsers(); 
                _filterText = '';
              });
            } 
          ),
        ],
      ),
      body: userProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : userProvider.error.isNotEmpty
              ? Center(child: Text(userProvider.error))
              : ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    return ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserDetailScreen(user: user),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}