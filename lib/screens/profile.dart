import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../auth/fire_auth.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userCollections =
      FirebaseFirestore.instance.collection('users').snapshots();
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
      body: StreamBuilder(
        stream: userCollections,
        builder: (context, snapshots) {
          return const Text('Data');
        },
      ),
    );
  }
}
