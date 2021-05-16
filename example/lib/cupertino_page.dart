import 'package:flutter/cupertino.dart';
import 'package:overlay_dialog/overlay_dialog.dart';

class CupertinoPage extends StatelessWidget {
  final void Function() handler;

  CupertinoPage(this.handler);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertion App"),
        trailing: CupertinoButton(
          padding: EdgeInsets.all(0),
          child: Text("Material"),
          onPressed: handler,
        ),
      ),
      child: SafeArea(
        child: Column(
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
                CupertinoButton(
                  child: Text("Alert"),
                  onPressed: () => _showDialog(context),
                ),
                CupertinoButton(
                  child: Text("Progress"),
                  onPressed: () => _showProgress(context),
                ),
                CupertinoButton(
                  child: Text("Custom"),
                  onPressed: () => _showCustom(context),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showProgress(BuildContext context) {
    DialogHelper().show(context, DialogWidget.progress(style: DialogStyle.cupertino));

    Future.delayed(Duration(seconds: 3)).then((_) => DialogHelper().hide(context));
  }

  void _showDialog(BuildContext context) {
    DialogHelper().show(
        context,
        DialogWidget.alert(
          style: DialogStyle.cupertino,
          title: "Alert Dialog Example",
          content: "This is an example of overlay dialog with three buttons. Do you like it?",
          actions: [
            DialogAction(
              title: "Later",
              handler: () => DialogHelper().hide(context),
            ),
            DialogAction(title: "No", handler: () => DialogHelper().hide(context), isDestructive: true),
            DialogAction(title: "Yes", handler: () => DialogHelper().hide(context), isDefault: true),
          ],
        ));
  }

  void _showCustom(BuildContext context) {
    DialogHelper().show(
        context,
        DialogWidget.custom(
          child: CustomDialogWidget(),
        ));
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
          padding: EdgeInsets.all(10),
          width: 200,
          height: 150,
          decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.activeBlue),
              borderRadius: BorderRadius.circular(8.0),
              color: CupertinoColors.white),
          child: Text(
            "This is an example of custom overlay dialog. Do you like it?",
            style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                color: CupertinoColors.activeBlue,
                decoration: TextDecoration.none),
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
                    border: Border.all(color: CupertinoColors.systemRed),
                    borderRadius: BorderRadius.circular(60),
                    color: CupertinoColors.white),
                child: Icon(
                  CupertinoIcons.clear,
                  color: CupertinoColors.systemRed,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => DialogHelper().hide(context),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: CupertinoColors.activeBlue),
                    borderRadius: BorderRadius.circular(60),
                    color: CupertinoColors.white),
                child: Icon(
                  CupertinoIcons.check_mark,
                  color: CupertinoColors.activeBlue,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
