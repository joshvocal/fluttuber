import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() async {
    print(myController.text);
    print(myController.text.split("\n"));

    List<String> urls = myController.text.split('\n');

    for (var url in urls) {
      Process.start('youtube-dl', [url, '--format', dropdownValue])
          .then((Process process) async {
        process.stdout.transform(utf8.decoder).listen((data) {
          setState(() {
            progress = data;
          });
        });

        process.stdin.writeln('Download has started!');

        process.exitCode.then((exitCode) {
          print('exit code: $exitCode');
        });
      });
    }
  }

  String path = Directory.current.path;
  final myController = TextEditingController();
  String dropdownValue = 'mp4';
  String progress = 'This thing';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Enter URLs below'),
                  Spacer(),
                  Icon(Icons.settings),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 8,
                ),
                child: TextField(
                  controller: myController,
                  maxLines: null,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.folder,
                  size: 48,
                ),
                Padding(
                  child: Text(path),
                  padding: EdgeInsets.only(left: 8),
                ),
                Spacer(),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    iconSize: 24,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'mp4',
                      'mp3',
                      'wav',
                      'aac',
                      '3gp',
                      'm4a',
                      'flv',
                      'ogg',
                      'webm',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                FlatButton(
                  child: Text(
                    "Download",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () => _incrementCounter(),
                ),
              ],
            ),
            Text(progress),
          ],
        ),
      ),
    );
  }
}
