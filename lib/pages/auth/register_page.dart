import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_todo/pages/add_note.dart';
import 'package:realtime_todo/pages/auth/login_page.dart';
import '../../core/product/product.dart';
import '../../core/route/route_class.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late DatabaseReference dbRef;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final NavigationRoutes routes = NavigationRoutes();
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref();
  }

  Future register() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: _email.text.trim(), password: _password.text.trim())
          .then((_) {
        Map<String, String> user = {
          'email': _email.text,
          'password': _password.text,
          'id': auth.currentUser!.uid
        };

        dbRef.child('usersInfo').push().set(user).whenComplete(() {
          _email.clear();
          _password.clear();
          navigate();
        }).onError((error, stackTrace) {
          throw error.toString();
        });
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  void navigate() {
    routes.navigateToPage(context, const AddNotePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
            title: 'Register',
            onPressed: () async {
              await register();
            },
          ),
          TextButton(
              onPressed: () {
                routes.navigateToPage(context, LoginPage());
              },
              child: const Text('Login'))
        ],
      ),
    );
  }
}
