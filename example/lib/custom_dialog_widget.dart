import 'package:flutter/material.dart';

import 'package:overlay_dialog/overlay_dialog.dart';

class CustomDialogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(10),
          width: 200,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
          child: Text(
            "This is an example of custom overlay dialog. Do you like it?",
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              color: Colors.blue,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () => DialogHelper().hide(context),
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(right: 40),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.clear,
                  color: Colors.blue,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => DialogHelper().hide(context),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
