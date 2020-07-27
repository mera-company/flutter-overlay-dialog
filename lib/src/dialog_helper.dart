import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:overlay_dialog/src/animation/appear_widget.dart';
import 'package:overlay_dialog/src/dialog_widget.dart';

///Helper class to handle dialog appearance
///Keeps the latest dialog and closes the previous dialog automatically
class DialogHelper {
  static const Color BACKGROUND_COLOR = Color(0x61000000);
  static const Duration DEFAULT_DURATION = Duration(milliseconds: 150);

  static final DialogHelper _instance = DialogHelper._();

  factory DialogHelper() => _instance;

  DialogHelper._();

  OverlayEntry _currentOverlay;
  Function _currentCallback;
  StreamController<double> _currentController;

  void show(BuildContext context, DialogWidget dialog, {bool rootOverlay = true}) {
    hideImmediate(context);

    OverlayState overlayState = rootOverlay
      ? context.findRootAncestorStateOfType<OverlayState>()
      : context.findAncestorStateOfType<OverlayState>();

    if (dialog.closable) {
      _currentCallback = () {
        hide(context);
        return Future.value(false);
      };

      ModalRoute.of(context).addScopedWillPopCallback(_currentCallback);
    }

    _currentController = StreamController();

    _currentOverlay = OverlayEntry(
      builder: (context) => AppearWidget(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () => dialog.closable ? hide(context) : (){},
              child: Container(
                color: BACKGROUND_COLOR,
              ),
            ),
            dialog,
          ],
        ),
        progress: _currentController.stream,
        duration: DEFAULT_DURATION,
        style: AppearStyle.blur,
      ),
    );

    overlayState.insert(_currentOverlay);
    _currentController.add(1.0);
  }

  void hide(BuildContext context) {
    if (_currentCallback != null) {
      ModalRoute.of(context)?.removeScopedWillPopCallback(_currentCallback);
      _currentCallback = null;
    }

    if (_currentController != null) {
      _currentController.add(0.0);

      Future
        .delayed(DEFAULT_DURATION)
        .then((_) {
          _currentController?.close();
          _currentController = null;
          _currentOverlay?.remove();
          _currentOverlay = null;
        })
        .catchError((_){});
    }
  }

  void hideImmediate(BuildContext context) {
    //reset back press handler
    if (_currentCallback != null) {
      ModalRoute.of(context)?.removeScopedWillPopCallback(_currentCallback);
      _currentCallback = null;
    }

    _currentController?.close();
    _currentController = null;

    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}