import 'package:flutter/cupertino.dart' show CupertinoApp, CupertinoThemeData;
import 'package:flutter/material.dart' show MaterialApp, ThemeData, Brightness;
import 'package:flutter/widgets.dart';

import 'cupertino_page.dart';
import 'material_page.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  bool isMaterial = true;

  @override
  Widget build(BuildContext context) {
    return isMaterial ? _getMaterialApp() : _getCupertionApp();
  }

  Widget _getMaterialApp() {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,

          /// Material dialog theme customization
          /*accentColor: Colors.red,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
        ),
        buttonBarTheme: ButtonBarThemeData(
          buttonTextTheme: ButtonTextTheme.accent,
          alignment: MainAxisAlignment.end,
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(color: Colors.green),
          contentTextStyle: TextStyle(color: Colors.purple),
        )*/
        ),
        home: MaterialPage(togglePlatform));
  }

  Widget _getCupertionApp() {
    return CupertinoApp(
        theme: CupertinoThemeData(
          brightness: Brightness.light,
        ),
        home: CupertinoPage(togglePlatform));
  }

  void togglePlatform() {
    setState(() {
      isMaterial = !isMaterial;
    });
  }
}
