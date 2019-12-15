import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UrlInputTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Enter URLs line separated below',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Icon(Icons.settings),
        ],
      ),
    );
  }
}

class UrlInputBox extends StatelessWidget {
  UrlInputBox({@required this.urlTextFieldController});

  final urlTextFieldController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          controller: urlTextFieldController,
          maxLines: null,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
