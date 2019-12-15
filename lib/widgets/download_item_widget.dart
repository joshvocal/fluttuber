import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttube/models/download.dart';

class DownloadItemWidget extends StatefulWidget {
  DownloadItemWidget({@required this.download});

  Download download;

  _DownloadItemWidgetState widgetState = _DownloadItemWidgetState();

  @override
  _DownloadItemWidgetState createState() => widgetState;
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
        color: widget.download.isSelected ? Colors.blue : Colors.grey,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("URL: " + widget.download.url),
              Text("Format: " + widget.download.format),
              Text(
                "Progress: " + widget.download.progress,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startDownload() {
    Process.start('youtube-dl', [
      widget.download.url,
      '--format',
      widget.download.format
    ]).then((Process process) async {
      process.stdout.transform(utf8.decoder).listen((data) {
        setState(() {
          this.widget.download.progress = data;
        });
      });

      process.exitCode.then((exitCode) {
        print('exit code: $exitCode');
      });
    });
  }
}
