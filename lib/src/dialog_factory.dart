import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'entity/dialog_action.dart';
import 'entity/dialog_style.dart';

// Platform dialog factory
abstract class DialogFactory {
  factory DialogFactory(DialogStyle type) {
    if (type == DialogStyle.material) {
      return _MaterialDialogFactory();
    }

    if (type == DialogStyle.cupertino) {
      return _CupertinoDialogFactory();
    }

    if (kIsWeb) {
      return _MaterialDialogFactory();

    } else if (Platform.isAndroid) {
      return _MaterialDialogFactory();

    } else {
      return _CupertinoDialogFactory();
    }
  }

  Widget alert(String title, String content, List<DialogAction> actions);

  Widget progress();

  Widget custom(Widget child);
}

class _MaterialDialogFactory implements DialogFactory {
  @override
  Widget alert(String title, String content, List<DialogAction> actions) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions
          .map((action) => TextButton(
              onPressed: action.handler,
              child: Text(action.title.toUpperCase())))
          .toList(growable: false),
    );
  }

  @override
  Widget progress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget custom(Widget child) {
    return Center(
      child: child,
    );
  }
}

class _CupertinoDialogFactory implements DialogFactory {
  @override
  Widget alert(String title, String content, List<DialogAction> actions) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions
          .map((action) => CupertinoDialogAction(
                onPressed: action.handler,
                child: Text(action.title),
                isDefaultAction: action.isDefault,
                isDestructiveAction: action.isDestructive,
              ))
          .toList(growable: false),
    );
  }

  @override
  Widget progress() {
    return Center(
      child: CupertinoActivityIndicator(animating: true),
    );
  }

  @override
  Widget custom(Widget child) {
    return Center(
      child: child,
    );
  }
}
