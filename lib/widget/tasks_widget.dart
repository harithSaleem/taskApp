import 'package:flutter/material.dart';
import 'package:taskapp/innerScreen/task_detiels.dart';

class Taskwidget extends StatefulWidget {
  const Taskwidget({Key? key}) : super(key: key);

  @override
  State<Taskwidget> createState() => _TaskwidgetState();
}

class _TaskwidgetState extends State<Taskwidget> {
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
                builder: ((context) => TaskDeatilesScreen()),
              ));
        },
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              });
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
                "https://img.icons8.com/material/452/checked-checkbox--v1.png"),
          ),
        ),
        title: Text(
          'Titel',
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
              'subtitle/descrbtion',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            )
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Colors.pink.shade700,
        ),
      ),
    );
  }
}
