import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late TextEditingController _forgeteditcotroller;
  // late TextEditingController _passwordeditcontroller;

  final loginFormkey = GlobalKey<FormState>();
  @override
  void dispose() {
    _animationController.dispose();

    _forgeteditcotroller.dispose();
    // _passwordeditcontroller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 25,
      ),
    );
    animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  void _Forgetpassword() {
    print('forgetpassword${_forgeteditcotroller.text}');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          // alignment: Alignment.center,
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://th.bing.com/th/id/OIP.30fuPl3x9KvMB2ZYW0k7owHaEK?w=299&h=180&c=7&r=0&o=5&pid=1.7",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Image.network(
                'https://th.bing.com/th/id/OIP.SpU0hjsO_6QnrCDZPcwDTwHaEK?w=282&h=180&c=7&r=0&o=5&pid=1.7',
                fit: BoxFit.fill,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              alignment: FractionalOffset(animation.value, 0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  const Text(
                    'Forget password ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Email Adress',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: TextField(
                      // controller: _forgeteditcotroller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    color: Colors.pink.shade400,
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    onPressed: _Forgetpassword,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Rest Password',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
