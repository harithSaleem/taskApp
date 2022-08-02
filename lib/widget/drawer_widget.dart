import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/innerScreen/add_task_screen.dart';
import 'package:taskapp/screen/all_worker.dart';
import 'package:taskapp/screen/task.dart';
import 'package:taskapp/user_state.dart';

import '../innerScreen/profielscreen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.cyan,
            ),
            child: Column(
              children: [
                Flexible(
                  child: Image.network(
                    'https://img.icons8.com/material/452/checked-checkbox--v1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Flexible(
                  child: Text(
                    'My Work os',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Listtile(
            title: 'All Tasks',
            ontap: () {
              NavigatorToTaskScreen(context);
            },
            icon: Icons.task,
          ),
          Listtile(
              title: 'My Account',
              ontap: () {
                NavigateMyprofiel(context);
              },
              icon: Icons.account_circle),
          Listtile(
            title: 'Register Worker ',
            ontap: () {
              NavigateAllworker(context);
            },
            icon: Icons.work,
          ),
          Listtile(
            title: 'Add Tasks',
            ontap: () {
              NavigatorToAddTask(context);
            },
            icon: Icons.add_task_outlined,
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
            height: 12,
          ),
          Listtile(
              title: 'Log out',
              ontap: () {
                Logout(context);
              },
              icon: Icons.logout_sharp),
        ],
      ),
    );
  }

  void NavigateAllworker(context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: ((context) => AllworkerScreen()),
        ));
  }

  void NavigateMyprofiel(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: ((context) => ProfielScreen(
                userId: uid,
              )),
        ));
  }

  void NavigatorToAddTask(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => AddTaskScreen()),
      ),
    );
  }

  void NavigatorToTaskScreen(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => TasksScreen()),
      ),
    );
  }

  void Logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    color: Colors.blue[900],
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'LogOut',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                ],
              ),
            ),
            content: const Text(
              'Do you want Logout',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: ((context) => UserState()),
                    ),
                  );
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          );
        });
  }

  ListTile Listtile({
    required String title,
    required Function ontap,
    required IconData icon,
  }) {
    return ListTile(
      onTap: () {
        ontap();
      },
      title: Text(
        title,
        style: TextStyle(
          color: Colors.blue[900],
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.blue[900],
      ),
    );
  }
}
