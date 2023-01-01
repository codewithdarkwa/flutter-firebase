import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/fire_auth.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        actions: [
          IconButton(
            onPressed: () async {
              await Authentication.signOutWithGoogle();
              Authentication.signOut();
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              }
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Sign in as ${_auth.currentUser!.email}',
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
