import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widget/all_worker_widget.dart';
import '../widget/drawer_widget.dart';

List<String> Taskcategorylist = [
  'Business',
  'programming',
  'Information technology',
  'Marketing',
  'Design',
  'Acounting',
];

class AllworkerScreen extends StatelessWidget {
  AllworkerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          leading: Builder(
            builder: (ctx) => IconButton(
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              },
              icon: const Icon(
                Icons.menu_outlined,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'All worker',
            style: TextStyle(
              color: Colors.pink.shade400,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_list),
              color: Colors.black,
            ),
          ],
          // elevation: 10,
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                  color: Colors.red,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) => AlworkerWidget(
                        userId: snapshot.data!.docs[index]['id'],
                        userName: snapshot.data!.docs[index]['name'],
                        userEmail: snapshot.data!.docs[index]['email'],
                        phonNumber: snapshot.data!.docs[index]['phone'],
                        postionIncompany: snapshot.data!.docs[index]
                            ['position incompany'],
                        userImagurl: snapshot.data!.docs[index]['imageUrl'],
                      )),
                );
              } else {
                return const Center(
                  child: Text(
                    'no task has been uploaded',
                  ),
                );
              }
            }
            return const Center(
              child: Text(
                'some thing went wrong',
              ),
            );
          },
        ));
  }
}
// ListView.builder(
//         itemCount: 10,
//         itemBuilder: ((context, index) => AlworkerWidget()),
//       ),