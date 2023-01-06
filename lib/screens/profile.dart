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
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return const Center(
                child: Text('There is no available data'),
              );
            }
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final user = documents[index].data() as Map<String, dynamic>;
                final userId = documents[index].id;
                final String name = user['name'];
                final String email = user['email'];
                return ListTile(
                  title: Text(name),
                  subtitle: Text(email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('An error occured'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
