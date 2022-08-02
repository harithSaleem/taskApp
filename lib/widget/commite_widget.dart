import 'package:flutter/material.dart';

class CommiteWidget extends StatelessWidget {
  CommiteWidget({Key? key}) : super(key: key);
  List<Color> color = [
    Colors.amber,
    Colors.orange,
    Colors.purple,
    Colors.green,
    Colors.red,
    Colors.pink.shade800
  ];

  @override
  Widget build(BuildContext context) {
    color.shuffle();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: color[0],
              ),
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: NetworkImage(
                    'https://th.bing.com/th/id/OIP.CsCEiIgcxJ54PXFJ-Ep5nQHaHa?pid=ImgDet&rs=1'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'commiter name ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'commiter Body  ',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
