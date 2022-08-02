import 'package:flutter/material.dart';

import '../widget/commite_widget.dart';

class TaskDeatilesScreen extends StatefulWidget {
  const TaskDeatilesScreen({Key? key}) : super(key: key);

  @override
  State<TaskDeatilesScreen> createState() => _TaskDeatilesScreenState();
}

class _TaskDeatilesScreenState extends State<TaskDeatilesScreen> {
  bool iscommenting = false;
  final _style = TextStyle(
    color: Colors.blue[900],
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Back',
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Task Titel',
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Uploaded by',
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: Colors.pink.shade800,
                              ),
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://th.bing.com/th/id/OIP.CsCEiIgcxJ54PXFJ-Ep5nQHaHa?pid=ImgDet&rs=1'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Uploader name',
                                style: _style,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text('Uploader jobe', style: _style),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Uploader on :',
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(' 6/15/2022',
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                )),
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'DeadLine Date :',
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              ' 6/15/2022',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: Text(
                          'date: 6/15/2022',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Text(
                        'Done State :',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Done  :',
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          const Opacity(
                            opacity: 0,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Flexible(
                            child: Text(
                              ' Not Done  :',
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                          const Opacity(
                            opacity: 0,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Text(
                        'Task decription :',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Task decription :',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        child: iscommenting
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      maxLines: 6,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        errorBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.pink.shade900),
                                        ),
                                      ),
                                      // controller: ,
                                      maxLength: 200,
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          MaterialButton(
                                            color: Colors.pink.shade900,
                                            elevation: 12,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            onPressed: () {},
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16),
                                              child: Text(
                                                'Post',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                iscommenting = !iscommenting;
                                              });
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: MaterialButton(
                                  color: Colors.pink.shade900,
                                  elevation: 12,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    setState(() {
                                      iscommenting = !iscommenting;
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Text(
                                      'Add a commite ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return CommiteWidget();
                        }),
                        separatorBuilder: (ctx, index) {
                          return const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          );
                        },
                        itemCount: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
