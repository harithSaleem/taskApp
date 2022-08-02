import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/widget/drawer_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfielScreen extends StatefulWidget {
  final String userId;
  const ProfielScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfielScreen> createState() => _ProfielScreenState();
}

class _ProfielScreenState extends State<ProfielScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isloding = false;
  String phonenumber = '';
  String email = '';
  String name = '';
  String jobe = '';
  String? imageurl;
  String joinAt = '';
  bool _issameUser = false;
  @override
  void initState() {
    getUserData();

    super.initState();
  }

  void getUserData() async {
    _isloding = true;
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          email = userDoc.get('email');
          name = userDoc.get('name');
          jobe = userDoc.get('position incompany');
          phonenumber = userDoc.get('phone');
          imageurl = userDoc.get('imageUrl');
          Timestamp joinAttimestap = userDoc.get('cratedAt');
          var joindate = joinAttimestap.toDate();
          joinAt = '${joindate.year}-${joindate.month}-${joindate.day}';
        });
        User? user = _auth.currentUser;
        String _uid = user!.uid;
        setState(() {
          _issameUser = _uid == widget.userId;
        });
      }
    } catch (error) {
      showerror(error);
    } finally {
      setState(() {
        _isloding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              Card(
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          name == null ? "" : name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '$jobe Since join $joinAt',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Contact Info',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      soicalInfo(title: 'Email:', content: email),
                      const SizedBox(
                        height: 10,
                      ),
                      soicalInfo(title: 'Phone number :', content: phonenumber),
                      const SizedBox(
                        height: 20,
                      ),
                      _issameUser
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                soiccalButton(
                                    color: Colors.green,
                                    fct: () {
                                      openwhatsap();
                                    },
                                    icon: FontAwesomeIcons.whatsappSquare),
                                soiccalButton(
                                  color: Colors.pink.shade400,
                                  fct: () {
                                    mailto();
                                  },
                                  icon: (Icons.mail_outline),
                                ),
                                soiccalButton(
                                  color: Colors.purple,
                                  fct: () {
                                    callphone();
                                  },
                                  icon: (Icons.phone),
                                ),
                              ],
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      _issameUser
                          ? Container()
                          : Divider(
                              thickness: 1,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      !_issameUser
                          ? Container()
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: MaterialButton(
                                  color: Colors.pink.shade400,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.logout_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        child: Text(
                                          'Logout',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: MediaQuery.of(context).size.width * 0.18,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 5,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            imageurl == null
                                ? 'https://www.bing.com/th?id=OIP.fJxrw6teXZp64y0riPJr7QHaHa&w=150&h=150&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2'
                                : imageurl!,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openwhatsap() async {
    // String phone = "9100001";
    var whatsap = 'http://wa.me/$phonenumber? text=Hello there';
    await launch(whatsap);
    if (await canLaunch(whatsap)) {
      await launch(whatsap);
    } else {
      throw 'an error ocuread ';
    }
  }

  void mailto() async {
    // String email = 'harith2121996saleem@gmail.com';
    var url = 'mailto:$email';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'an error ocuread ';
    }
  }

  void callphone() async {
    var phoneurl = 'tel://$phonenumber';
    if (await canLaunch(phoneurl)) {
      await launch(phoneurl);
    } else {
      throw 'an error ocuread ';
    }
  }

  Widget soicalInfo({required String title, required String content}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          content,
          style: TextStyle(
            color: Colors.blue.shade900,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget soiccalButton({
    required Color color,
    required IconData icon,
    required Function fct,
  }) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 23,
        child: IconButton(
          onPressed: () {
            fct();
          },
          icon: Icon(icon, color: color),
        ),
      ),
    );
  }

  void showerror(error) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red[900],
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Error ocuerd',
                    style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                ],
              ),
            ),
            content: Text(
              error,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
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
            ],
          );
        });
  }
}
