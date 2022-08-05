import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Allsers extends StatefulWidget {
  const Allsers({Key? key}) : super(key: key);

  @override
  State<Allsers> createState() => _AllsersState();
}

class _AllsersState extends State<Allsers> {
  final user = FirebaseAuth.instance.currentUser!;
  late Query dbRef;

  @override
  void initState() {
    super.initState();

    dbRef = FirebaseDatabase.instance.ref().child('usersInfo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fetching data'),
          centerTitle: true,
        ),
        body: SizedBox(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map users = snapshot.value as Map;
              users['key'] = snapshot.key;

              return listItem(users: users);
            },
          ),
        ));
  }

  Widget listItem({required Map users}) {
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
                users['email'],
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const Spacer(),
              Text(
                users['id'],
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            users['password'],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
