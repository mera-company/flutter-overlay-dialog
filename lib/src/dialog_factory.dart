import 'dart:io';

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

    if (Platform.isAndroid) {
      return _MaterialDialogFactory();
    } else {
      return _CupertinoDialogFactory();
    }
  }

  Widget alert(String title, String content, List<DialogAction> actions);

  Widget progress();
}

class _MaterialDialogFactory implements DialogFactory {
  @override
  Widget alert(String title, String content, List<DialogAction> actions) {
    return Center(
      child: AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions
            .map((action) => TextButton(onPressed: action.handler, child: Text(action.title.toUpperCase())))
            .toList(growable: false),
      ),
    );
  }

  @override
  Widget progress() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _CupertinoDialogFactory implements DialogFactory {
  @override
  Widget alert(String title, String content, List<DialogAction> actions) {
    return Center(
      child: CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions
            .map(
              (action) => CupertinoDialogAction(
                onPressed: action.handler,
                isDefaultAction: action.isDefault,
                isDestructiveAction: action.isDestructive,
                child: Text(action.title),
              ),
            )
            .toList(growable: false),
      ),
    );
  }

  @override
  Widget progress() {
    return const Center(
      child: CupertinoActivityIndicator(animating: true),
    );
  }
}
