import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_todo/pages/auth/login_page.dart';
import 'package:realtime_todo/pages/note_list.dart';

import '../core/product/product.dart';
import '../core/route/route_class.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController age = TextEditingController();
  final NavigationRoutes routes = NavigationRoutes();
  final user = FirebaseAuth.instance;

  late DatabaseReference dbRef;
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('userNotes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 60,
            ),
            FormfieldArea(
              controller: name,
              hintText: 'Title',
            ),
            FormfieldArea(
              controller: surname,
              hintText: 'Description',
            ),
            FormfieldArea(
              controller: age,
              hintText: 'Time',
            ),
            LoadingButton(
              onPressed: () async {
                Map<String, String> job = {
                  'title': name.text,
                  'description': surname.text,
                  'time': age.text,
                  'id': user.currentUser!.uid
                };
                await dbRef
                    .push()
                    .set(job)
                    .whenComplete(() => print('success'))
                    .onError((error, stackTrace) {
                  throw error.toString();
                });
              },
              title: 'Save',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const NoteList()),
                  ),
                );
              },
              child: const Text("List Page"),
            ),
            TextButton(
                onPressed: () async {
                  await user.signOut().whenComplete(() {
                    routes.navigateToPage(context, LoginPage());
                  });
                },
                child: const Text("Exit"))
          ],
        ),
      ),
    );
  }
}
