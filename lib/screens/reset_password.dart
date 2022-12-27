import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/auth/validator.dart';

import '../auth/fire_auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _resetpasswordController = TextEditingController();

  @override
  void dispose() {
    _resetpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Reset your password through this email',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                controller: _resetpasswordController,
                validator: (value) => Validator.validateEmail(email: value!),
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  filled: true,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await Authentication.resetPassword(
                  email: _resetpasswordController.text,
                  context: context,
                );
              },
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
