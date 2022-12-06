import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'register.dart';

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
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _auth.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const RegisterPage()));
          },
          child: const Text('SignOut'),
        ),
      ),
    );
  }
}
