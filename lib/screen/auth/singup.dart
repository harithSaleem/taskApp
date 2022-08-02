import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskapp/screen/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import '../task.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _LoginScreenState();
}

List jobs = [
  'Mobile Devloper',
  'web Devloper',
  'Desinger',
  'Manager',
  'Officer',
];

class _LoginScreenState extends State<SingUpScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

  late final TextEditingController _emaileditcotroller =
      TextEditingController(text: '');
  late final TextEditingController _phoneditcotroller =
      TextEditingController(text: '');
  late final TextEditingController _fullnameleditcotroller =
      TextEditingController(text: '');
  late final TextEditingController _postioncomleditcotroller =
      TextEditingController(text: '');
  late final TextEditingController _passwordeditcontroller =
      TextEditingController(text: '');
  bool _obscureText = true;
  final sinupFormkey = GlobalKey<FormState>();

  final FocusNode _fullnamefoucsNod = FocusNode();
  final FocusNode _emailfoucsNod = FocusNode();
  final FocusNode _passwordfoucsNod = FocusNode();
  final FocusNode _postionfoucsNod = FocusNode();
  final FocusNode _phoneNummberFoucsNod = FocusNode();
  File? imgfiel;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloding = false;
  String? url;
  @override
  void dispose() {
    _animationController.dispose();
    _phoneditcotroller.dispose();
    _emaileditcotroller.dispose();
    _passwordeditcontroller.dispose();
    _fullnameleditcotroller.dispose();
    _postioncomleditcotroller.dispose();
    _fullnamefoucsNod.dispose();
    _emailfoucsNod.dispose();
    _passwordfoucsNod.dispose();
    _postionfoucsNod.dispose();
    _phoneNummberFoucsNod.dispose();

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
    final isvalid = sinupFormkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isvalid) {
      if (imgfiel == null) {
        showerror('pleas pick up an image ');
        return;
      }
      setState(() {
        isloding = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _emaileditcotroller.text.toLowerCase().trim(),
            password: _passwordeditcontroller.text.trim());
        final User? _user = _auth.currentUser;
        final uid = _user!.uid;
        final ref = FirebaseStorage.instance
            .ref()
            .child('userimages')
            .child(uid + 'jpg');
        await ref.putFile(imgfiel!);
        url = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'id': uid,
          'name': _fullnameleditcotroller.text,
          'email': _emaileditcotroller.text,
          'phone': _phoneditcotroller.text,
          'imageUrl': url,
          'position incompany': _postioncomleditcotroller.text,
          'cratedAt': Timestamp.now(),
        });
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
                    'SingUp ',
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
                          text: 'Already  have an account ? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' Login ',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
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
                    key: sinupFormkey,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_fullnamefoucsNod),
                          focusNode: _emailfoucsNod,
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
                        Row(
                          children: [
                            Flexible(
                              // flex: ,
                              child: TextFormField(
                                focusNode: _fullnamefoucsNod,
                                controller: _fullnameleditcotroller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'field can\' be missing';
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter your full Name ',
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
                            ),
                            Flexible(
                              flex: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    InkWell(
                                      onTap: (() {
                                        // print('show pick image dilog');
                                        shwoDilogimag(context);
                                      }),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          child: imgfiel == null
                                              ? Image.network(
                                                  'https://th.bing.com/th/id/OIP.WrYj8Me0PE9dHatcFb1PPwAAAA?pid=ImgDet&rs=1',
                                                  fit: BoxFit.fill,
                                                  // width: MediaQuery.of(context)
                                                  //         .size
                                                  //         .width *
                                                  //     0.2,
                                                  // height: MediaQuery.of(context)
                                                  //         .size
                                                  //         .height *
                                                  //     0.2,
                                                )
                                              : Image.file(
                                                  imgfiel!,
                                                  fit: BoxFit.fill,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.pink.shade900,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Icon(
                                              imgfiel == null
                                                  ? Icons.add_a_photo_outlined
                                                  : Icons.edit_outlined,
                                              size: 17,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_postionfoucsNod),
                          focusNode: _passwordfoucsNod,
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
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          onChanged: ((value) {
                            print(_phoneditcotroller.text);
                          }),
                          focusNode: _phoneNummberFoucsNod,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_phoneNummberFoucsNod),
                          controller: _phoneditcotroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'field can\' be missing';
                            }
                            return null;
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your Phone number ',
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
                          // enabled: false,
                          onTap: (() {
                            showdialogJobs(context);
                          }),
                          textInputAction: TextInputAction.done,
                          focusNode: _postionfoucsNod,
                          controller: _postioncomleditcotroller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'field can\' be missing';
                            }
                            return null;
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter your postion',
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
                                  'Sing Up',
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
                                Icons.app_registration_rounded,
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

  Future<dynamic> shwoDilogimag(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Pleas choose an option ',
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 20,
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.camera_alt,
                        color: Colors.purple,
                      ),
                      TextButton(
                        onPressed: () {
                          Pickedimagefromcammera();
                        },
                        child: const Text(
                          'Cammera',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.browse_gallery,
                        color: Colors.purple,
                      ),
                      TextButton(
                        onPressed: () {
                          Pickedimagefromgallery();
                        },
                        child: const Text(
                          'Gallery',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _cropimage(filepath) async {
    File? cropimage = (await ImageCropper().cropImage(
      sourcePath: filepath,
      maxHeight: 1080,
      maxWidth: 1080,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
    )) as File?;
    if (cropimage != null) {
      setState(() {
        imgfiel = cropimage;
      });
    }
  }

  void Pickedimagefromcammera() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, maxHeight: 10, maxWidth: 10);
      if (image == null) return;
      imgfiel = File(image.path);

      _cropimage(imgfiel);
    } catch (error) {
      showerror(error);
    }
    Navigator.pop(context);
  }

  void Pickedimagefromgallery() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, maxHeight: 10, maxWidth: 10);
      if (image == null) return;
      imgfiel = File(image.path);

      _cropimage(imgfiel);
    } catch (error) {
      showerror(error);
    }
    Navigator.pop(context);
    // PickedFile? pickedFile = await ImagePicker().getImage(
    //   source: ImageSource.gallery,
    //   maxHeight: 100,
    //   maxWidth: 100,
    // );
    // setState(() {
    //   imgfiel = File(pickedFile!.path);
    // });
    // Navigator.pop(context);
    // PickedFile? pickedFile = (await ImagePicker().pickImage(
    //   source: ImageSource.gallery,
    //   maxHeight: 1080,
    //   maxWidth: 1080,
    // )) as PickedFile?;
    // setState(() {
    //   imgfiel = (pickedFile!.path) as File;
    // });
    // Navigator.pop(context);
  }

  Future<dynamic> showdialogJobs(BuildContext context) {
    return showDialog(
      context: context,
      builder: (contaxt) {
        return AlertDialog(
          title: Text(
            'Jobs',
            style: TextStyle(
              color: Colors.pink.shade400,
              fontSize: 20,
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: jobs.length,
              itemBuilder: ((context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        _postioncomleditcotroller.text = jobs[index];
                        Navigator.pop(context);
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: Colors.pink.shade300,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            jobs[index],
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Text(
                'Close',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     'Canscel fillter',
            //     style: TextStyle(
            //       color: Colors.blue[800],
            //       fontSize: 15,
            //       fontWeight: FontWeight.w600,
            //       fontStyle: FontStyle.italic,
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
