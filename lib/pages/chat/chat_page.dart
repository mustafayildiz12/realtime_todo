import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../core/product/product.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _chat = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('messages');
  }

  sendMessage() async {
    Map<String, String> message = {
      'message': _chat.text,
      'receiverId': widget.uid,
      'senderId': user.uid,
      'time': DateTime.now().toIso8601String()
    };
    await dbRef
        .child(user.uid)
        .child(widget.uid)
        .push()
        .set(message)
        .whenComplete(() => print('success'))
        .onError((error, stackTrace) {
      throw error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormfieldArea(
              controller: _chat,
            ),
            LoadingButton(
                title: 'Send',
                onPressed: () async {
                  await sendMessage();
                  _chat.clear();
                })
          ],
        ),
      ),
    );
  }
}
