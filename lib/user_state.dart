import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/screen/auth/login.dart';
import 'package:taskapp/screen/task.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, usersnapshot) {
          if (usersnapshot.data == null) {
            return LoginScreen();
          } else if (usersnapshot.hasData) {
            return TasksScreen();
          } else if (usersnapshot.hasError) {
            return const Center(
              child: Text(
                ' An Error ocrured',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text(
                ' An Error ocrured',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 40,
                ),
              ),
            ),
          );
        }));
  }
}



//  if (usersnapshot.data == null) {
//             print('user didnt login');
//             return const LoginScreen();
//           } else if (usersnapshot.hasData) {
//             print('user login');
//             TasksScreen();
//           } else if (usersnapshot.hasError) {
//             return const Center(
//               child: Text(
//                 ' An Error ocrured',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 40,
//                 ),
//               ),
//             );
//           }
//           return const Scaffold(
//             body: Center(
//               child: Text(
//                 ' An Error ocrured',
//                 style: TextStyle(
//                   color: Colors.amber,
//                   fontSize: 40,
//                 ),
//               ),
//             ),
//           );