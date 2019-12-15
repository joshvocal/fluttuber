import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:io';

class Download {
  Download({
    @required url,
    @required format,
  }) {
    this.url = url;
    this.format = format;
  }

  bool isSelected = false;
  String url;
  String format;
  String progress = 'n/a';
}
