import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realtime_todo/pages/auth/register_page.dart';

import '../../core/product/product.dart';
import '../../core/route/route_class.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final NavigationRoutes routes = NavigationRoutes();

  Future signIn() async {
    try {
      await auth
          .signInWithEmailAndPassword(
            email: _email.text.trim(),
            password: _password.text.trim(),
          )
          .then((value) => print(value));
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FormfieldArea(
            controller: _email,
            hintText: 'email',
            textInputType: TextInputType.emailAddress,
          ),
          FormfieldArea(
            controller: _password,
            hintText: 'password',
            obscureText: true,
          ),
          LoadingButton(
            title: 'Login',
            onPressed: () async {
              await signIn();
            },
          ),
          TextButton(
              onPressed: () {
                routes.navigateToWidget(context, const RegisterPage());
              },
              child: const Text('Register'))
        ],
      ),
    );
  }
}
