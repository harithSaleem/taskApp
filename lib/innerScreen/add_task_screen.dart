import 'package:flutter/material.dart';
import 'package:taskapp/widget/drawer_widget.dart';

import '../screen/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

DateTime? picked;

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController categorycontroler =
      TextEditingController(text: 'Task Category');
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descrptioncontroller = TextEditingController();
  TextEditingController daTecontroller =
      TextEditingController(text: 'Pick up  Date');
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    categorycontroler.dispose();
    titlecontroller.dispose();
    descrptioncontroller.dispose();
    daTecontroller.dispose();
    super.dispose();
  }

  void uploadfct() {
    final isvalid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isvalid) {
      print('isvalid');
    } else {
      print('is not valid');
    }
  }

  void _PickeDate(BuildContext context) async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(days: 0),
      ),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        daTecontroller.text = '${picked!.year}/${picked!.month}/${picked!.day}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'All field are  required',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textWidget(title: ' Task Category'),
                          textformfield(
                            controller: categorycontroler,
                            enabled: false,
                            maxLength: 100,
                            ontap: () {
                              showDialog(
                                context: context,
                                builder: (contaxt) {
                                  return AlertDialog(
                                    title: Text(
                                      'Task Category',
                                      style: TextStyle(
                                        color: Colors.pink.shade400,
                                        fontSize: 20,
                                      ),
                                    ),
                                    content: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: Taskcategorylist.length,
                                        itemBuilder: ((context, index) =>
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  categorycontroler.text =
                                                      Taskcategorylist[index];
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.check_circle_rounded,
                                                    color: Colors.pink.shade300,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    child: Text(
                                                      Taskcategorylist[index],
                                                      style: TextStyle(
                                                        color: Colors.blue[800],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.italic,
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
                                          Navigator.canPop(context)
                                              ? Navigator.pop(context)
                                              : null;
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
                            },
                            valukey: ' Task Category',
                          ),
                          textWidget(title: ' Task Title'),
                          textformfield(
                            controller: titlecontroller,
                            enabled: true,
                            maxLength: 100,
                            ontap: () {},
                            valukey: ' Task Title',
                          ),
                          textWidget(title: ' Task Descrption'),
                          textformfield(
                            controller: descrptioncontroller,
                            enabled: true,
                            maxLength: 1000,
                            ontap: () {},
                            valukey: ' TaskDescrption',
                          ),
                          textWidget(title: ' Task Deadlin Date'),
                          textformfield(
                            controller: daTecontroller,
                            enabled: false,
                            maxLength: 100,
                            ontap: () {
                              _PickeDate(context);
                            },
                            valukey: ' Pick up a Date',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
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
                                onPressed: uploadfct,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      child: Text(
                                        'Upload',
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
                                      Icons.upload_file,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding textformfield({
    required String valukey,
    required int maxLength,
    required TextEditingController controller,
    required bool enabled,
    required Function ontap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (() {
          ontap();
        }),
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "Field is miising";
            }
            return null;
          },
          enabled: enabled,
          key: ValueKey(valukey),
          style: TextStyle(
            color: Colors.blue[800],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          maxLines: valukey == 'TaskDescrption' ? 3 : 1,
          maxLength: maxLength,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.pink.shade800),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

// void _PickeDate(BuildContext context) async {
//   picked = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime.now().subtract(
//       const Duration(days: 0),
//     ),
//     lastDate: DateTime(2030),
//   );
//   setState(() {
//     daTecontroller.text =
//         '${picked!.year}${picked!.month}${picked!.day}';
//   });
// }

textWidget({required title}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      title,
      style: TextStyle(
        color: Colors.pink[800],
        fontSize: 19,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      ),
    ),
  );
}
