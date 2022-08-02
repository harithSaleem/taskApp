import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/screen/auth/forget.dart';
import 'package:taskapp/screen/auth/singup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late final TextEditingController _emaileditcotroller =
      TextEditingController(text: '');

  late final TextEditingController _passwordeditcontroller =
      TextEditingController(text: '');
  final FocusNode _emailfoucsNod = FocusNode();
  final FocusNode _passwordfoucsNod = FocusNode();
  bool _obscureText = true;
  final loginFormkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloding = false;
  @override
  void dispose() {
    _animationController.dispose();
    _emailfoucsNod.dispose();
    _passwordfoucsNod.dispose();
    _emaileditcotroller.dispose();
    _passwordeditcontroller.dispose();

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

  void submatFormonLogin() async {
    final isvalid = loginFormkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isvalid) {
      setState(() {
        isloding = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emaileditcotroller.text.toLowerCase().trim(),
            password: _passwordeditcontroller.text.trim());
        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (e) {
        setState(() {
          isloding = false;
        });
        showerror(e.toString());

        print(e);
      }
    } else {
      print('is not valid');
    }
    setState(() {
      isloding = false;
    });
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
                    'Login ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Don\'t have an account ? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' Sign Up',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SingUpScreen()));
                            },
                          style: TextStyle(
                            color: Colors.blue.shade300,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Form(
                    key: loginFormkey,
                    child: Column(
                      children: [
                        TextFormField(
                          focusNode: _emailfoucsNod,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passwordfoucsNod),
                          controller: _emaileditcotroller,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter vaild email adress';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade300,
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          focusNode: _passwordfoucsNod,
                          textInputAction: TextInputAction.done,
                          controller: _passwordeditcontroller,
                          obscureText: _obscureText,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 8) {
                              return 'Please enter vaild  password';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                )),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade300,
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetScreen()));
                      },
                      child: const Text(
                        'Forget Password ?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  isloding
                      ? const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          ),
                        )
                      : MaterialButton(
                          color: Colors.pink.shade400,
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22)),
                          onPressed: submatFormonLogin,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'Login',
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
                              Icon(
                                Icons.login,
                                color: Colors.white,
                              )
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
