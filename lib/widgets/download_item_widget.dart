import 'package:flutter/material.dart';
import 'package:fluttube/models/download.dart';

class DownloadItemWidget extends StatefulWidget {
  DownloadItemWidget({@required this.download});

  Download download;

  @override
  _DownloadItemWidgetState createState() => _DownloadItemWidgetState();
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
}
