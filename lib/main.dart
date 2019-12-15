import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttube/models/download.dart';
import 'package:fluttube/resources/constants.dart';
import 'package:fluttube/widgets/download_item_widget.dart';
import 'package:fluttube/widgets/url_input_widget.dart';

void main() => runApp(Fluttube());

class Fluttube extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluttube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final urlTextFieldController = TextEditingController();
  List<DownloadItemWidget> items = [];
  String currentFileFormatSelected = 'mp4';
  String currentPath = Directory.current.path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UrlInputTitle(),
            UrlInputBox(
              urlTextFieldController: urlTextFieldController,
            ),
            Padding(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.folder,
                    size: 32,
                  ),
                  Padding(
                    child: Text(currentPath),
                    padding: EdgeInsets.only(left: 8),
                  ),
                  Spacer(),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: currentFileFormatSelected,
                      iconSize: 24,
                      onChanged: (String newValue) {
                        setState(() {
                          currentFileFormatSelected = newValue;
                        });
                      },
                      items: kFileFormats
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    child: FlatButton(
                      child: Text(
                        "Add To List",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: () => addURLsToList(),
                    ),
                    padding: EdgeInsets.only(left: 16),
                  ),
                ],
              ),
              padding: EdgeInsets.only(top: 8, bottom: 8),
            ),
            Padding(
              child: Text(
                'Download List',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              padding: EdgeInsets.only(bottom: 16),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return items[index];
                },
                itemCount: items.length,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    "Remove",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () => removeSelected(),
                ),
                SizedBox(
                  width: 8,
                ),
                FlatButton(
                  child: Text(
                    "Download",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () => downloadEntireList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    urlTextFieldController.dispose();
    super.dispose();
  }

  void downloadEntireList() {
    for (DownloadItemWidget item in items) {
      if (item.download.isSelected) {
        item.widgetState.startDownload();
      }
    }
  }

  void removeSelected() {
    List<DownloadItemWidget> notSelectedItems = [];

    for (DownloadItemWidget item in items) {
      if (!item.download.isSelected) {
        notSelectedItems.add(item);
      }
    }

    setState(() {
      items = notSelectedItems;
    });
  }

  void addURLsToList() {
    List<String> urls = urlTextFieldController.text.split('\n');

    for (var url in urls) {
      Download download = Download(url: url, format: currentFileFormatSelected);
      DownloadItemWidget widget = DownloadItemWidget(download: download);

      if (!items.contains(widget)) {
        setState(() {
          items.add(widget);
        });
      }
    }
  }
}
