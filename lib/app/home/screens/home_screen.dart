import 'package:flutter/material.dart';
import 'package:grossery/app/core/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              // Navigate to the login screen
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome, ${_authService.currentUser?.displayName}'),
      ),
    );
  }
}
