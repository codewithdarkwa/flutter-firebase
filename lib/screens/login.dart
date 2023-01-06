import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_app/screens/register.dart';
import 'package:ionicons/ionicons.dart';

import '../auth/fire_auth.dart';
import '../auth/validator.dart';
import 'profile.dart';
import 'reset_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _emailTextController,
                    validator: (value) =>
                        Validator.validateEmail(email: value!),
                    decoration: const InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.all(8),
                      hintText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _passwordTextController,
                    validator: (value) =>
                        Validator.validatePassword(password: value!),
                    decoration: const InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.all(8),
                      hintText: 'Password',
                    ),
                    obscureText: true,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Authentication.signInWithEmailAndPassword(
                        context: context,
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      );
                    }
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((_) => const ProfilePage())));
                  },
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ResetPassword(),
                      ),
                    );
                  },
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account yet ? ',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Text(
                      'Continue with Google',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 57, 54, 54),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () async {
                    try {
                      User? user = await Authentication.signInWithGoogle(
                          context: context);
                      if (mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfilePage(),
                          ),
                        );
                      }
                    } on PlatformException catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  icon: const Icon(
                    Ionicons.logo_google,
                  ),
                  label: const Text('Continue with google'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
