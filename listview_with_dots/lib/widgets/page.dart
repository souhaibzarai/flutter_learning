import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget {
  final String text;

  const PageWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
          ),
        ),
        SizedBox(height: 30),
        Text(
          'Lorem ipsum dolor sit amet consectetur adipisicing elit. Id provident reprehenderit assumenda suscipit perspiciatis eligendi necessitatibus, molestiae excepturi impedit corrupti totam hic unde modi, quis non aliquam saepe optio repellendus rerum eveniet nostrum mollitia! Ipsam, amet, ratione ipsum reiciendis totam ullam tempore assumenda commodi harum facilis fugiat facere voluptas? Sint?',
          style: TextStyle(
            color: const Color.fromARGB(255, 32, 66, 147),
            fontSize: 18,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
