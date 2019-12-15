import 'package:flutter/material.dart';

import 'download_item_widget.dart';

class DownloadListWidget extends StatefulWidget {
  DownloadListWidget({@required items});

  List<DownloadItemWidget> items = [];

  @override
  _DownloadListWidgetState createState() => _DownloadListWidgetState();
}

class _DownloadListWidgetState extends State<DownloadListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return widget.items[index];
        },
        itemCount: widget.items.length,
      ),
    );
  }
}
