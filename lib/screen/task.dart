import 'package:flutter/material.dart';

import '../widget/drawer_widget.dart';
import '../widget/tasks_widget.dart';

List<String> Taskcategorylist = [
  'Business',
  'programming',
  'Information technology',
  'Marketing',
  'Design',
  'Acounting',
];

class TasksScreen extends StatelessWidget {
  TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: Builder(
          builder: (ctx) => IconButton(
            onPressed: () {
              Scaffold.of(ctx).openDrawer();
            },
            icon: const Icon(
              Icons.menu_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Tasks',
          style: TextStyle(
            color: Colors.pink.shade400,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showdialog(context);
            },
            icon: const Icon(Icons.filter_list),
            color: Colors.black,
          ),
        ],
        // elevation: 10,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: ((context, index) => Taskwidget()),
      ),
    );
  }

  Future<dynamic> showdialog(BuildContext context) {
    return showDialog(
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
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Taskcategorylist.length,
              itemBuilder: ((context, index) => InkWell(
                    onTap: () {
                      print(Taskcategorylist[index]);
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
                            Taskcategorylist[index],
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
            TextButton(
              onPressed: () {},
              child: Text(
                'Canscel fillter',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
