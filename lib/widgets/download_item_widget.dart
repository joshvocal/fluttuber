import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttube/models/download.dart';

class DownloadItemWidget extends StatefulWidget {
  DownloadItemWidget({@required this.download});

  Download download;

  _DownloadItemWidgetState test = _DownloadItemWidgetState();

  @override
  _DownloadItemWidgetState createState() => test;
}

class _DownloadItemWidgetState extends State<DownloadItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.download.isSelected = !widget.download.isSelected;
        });
      },
      child: Card(
        color: widget.download.isSelected ? Colors.blue : Colors.red,
        child: ListTile(
          title: Text(widget.download.url),
          subtitle: Text(widget.download.info),
        ),
      ),
    );
  }

  void start() {
    Process.start('youtube-dl', [
      widget.download.url,
      '--format',
      widget.download.format
    ]).then((Process process) async {
      process.stdout.transform(utf8.decoder).listen((data) {
        setState(() {
          this.widget.download.info = data;
        });
      });

      process.exitCode.then((exitCode) {
        print('exit code: $exitCode');
      });
    });
  }
}
