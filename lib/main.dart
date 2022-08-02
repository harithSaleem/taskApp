import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:taskapp/user_state.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _intializeapp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _intializeapp,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text(
                    ' App is Looding',
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text(
                    ' An Error ocrured',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            );
          }

          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xffEDE7DC),
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: const UserState(),
          );
        }));
  }
}
