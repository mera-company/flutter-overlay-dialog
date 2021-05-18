import 'package:flutter/material.dart';

import 'package:overlay_dialog/overlay_dialog.dart';

class MaterialExamplePage extends StatelessWidget {
  final Function handler;

  MaterialExamplePage(this.handler);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Material App"),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Cupertino",
              style: TextStyle(color: Colors.white)
            ),
            onPressed: handler,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                'Tap the button to show a dialog',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                child: Text("Alert".toUpperCase()),
                onPressed: () => _showAlert(context),
              ),
              MaterialButton(
                child: Text("Progress".toUpperCase()),
                onPressed: () => _showProgress(context),
              ),
              MaterialButton(
                child: Text("Custom".toUpperCase()),
                onPressed: () => _showCustom(context),
              )
            ],
          )
        ],
      ),
    );
  }

  void _showProgress(BuildContext context) {
    DialogHelper().show(
      context,
      DialogWidget.progress(style: DialogStyle.material)
    );

    Future
      .delayed(Duration(seconds: 3))
      .then((_) => DialogHelper().hide(context));
  }

  void _showAlert(BuildContext context) {
    DialogHelper().show(
      context,
      DialogWidget.alert(
        style: DialogStyle.material,
        title: "Alert Dialog Example",
        content: "This is an example of overlay dialog with three buttons. Do you like it?",
        actions: [
          DialogAction(
            title: "Later",
            handler: () => DialogHelper().hide(context),
          ),
          DialogAction(
            title: "No",
            handler: () => DialogHelper().hide(context),
          ),
          DialogAction(
            title: "Yes",
            handler: () => DialogHelper().hide(context),
          ),
        ],
      )
    );
  }

  void _showCustom(BuildContext context) {
    DialogHelper().show(
      context,
      DialogWidget.custom(
        child: CustomDialogWidget(),
      )
    );
  }
}

class CustomDialogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(16),
          width: 200,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white
          ),
          child: Text(
            "This is an example of custom overlay dialog. Do you like it?",
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              color: Colors.blue,
              decoration: TextDecoration.none
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
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.white
                ),
                child: Icon(
                  Icons.clear,
                  color: Colors.red,
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
                  color: Colors.white
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
