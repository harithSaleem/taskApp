import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../innerScreen/profielscreen.dart';

class AlworkerWidget extends StatefulWidget {
  final String userId;
  final String userName;
  final String userEmail;
  final String postionIncompany;
  final String phonNumber;
  final String userImagurl;

  AlworkerWidget({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.postionIncompany,
    required this.userImagurl,
    required this.phonNumber,
  });

  @override
  State<AlworkerWidget> createState() => _TaskwidgetState();
}

class _TaskwidgetState extends State<AlworkerWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => ProfielScreen(
                      userId: widget.userId,
                    )),
              ));
        },
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.only(
            right: 12.0,
          ),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 1.0,
              ),
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: Image.network(
              widget.userImagurl == null
                  ? "https://www.bing.com/th?id=OIP.fJxrw6teXZp64y0riPJr7QHaHa&w=150&h=150&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2"
                  : widget.userImagurl,
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
            ),
          ),
        ),
        title: Text(
          widget.userName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.linear_scale,
              color: Colors.pink.shade800,
            ),
            Text(
              "${widget.postionIncompany}/no:${widget.phonNumber}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            )
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.mail,
            size: 30,
            color: Colors.pink.shade700,
          ),
          onPressed: () {
            mailto();
          },
        ),
      ),
    );
  }

  void mailto() async {
    // String email = 'harith2121996saleem@gmail.com';
    var url = 'mailto:${widget.userEmail}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'an error ocuread ';
    }
  }
}
