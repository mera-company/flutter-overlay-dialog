import 'package:example/cupertino_page.dart';
import 'package:example/material_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      home: MaterialExamplePage(togglePlatform),
    );
  }

  Widget _getCupertionApp() {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.light,
      ),
      home: CupertinoExamplePage(togglePlatform),
    );
  }

  void togglePlatform() {
    setState(() {
      isMaterial = !isMaterial;
    });
  }
}
