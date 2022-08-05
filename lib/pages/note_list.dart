import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:realtime_todo/pages/auth/all_users.dart';

import '../core/route/route_class.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final user = FirebaseAuth.instance.currentUser!;
  late Query dbRef;
  late DatabaseReference reference;
  final NavigationRoutes routes = NavigationRoutes();

  @override
  void initState() {
    super.initState();
    reference = FirebaseDatabase.instance.ref().child('userNotes');

    dbRef = FirebaseDatabase.instance.ref().child('userNotes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Users'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  routes.navigateToPage(context, const Allsers());
                },
                icon: const Icon(Icons.person))
          ],
        ),
        body: SizedBox(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map soldier = snapshot.value as Map;
              soldier['key'] = snapshot.key;

              return listItem(soldier: soldier);
            },
          ),
        ));
  }

  Widget listItem({required Map soldier}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.tealAccent, borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                soldier['title'],
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              Text(
                soldier['id'],
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            soldier['description'],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            soldier['time'],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateRecord(studentKey: student['key'])));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              IconButton(
                  onPressed: () {
                    reference.child(soldier['key']).remove();
                  },
                  icon: const Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}
