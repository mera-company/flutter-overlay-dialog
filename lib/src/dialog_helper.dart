import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'animation/appear_widget.dart';
import 'dialog_widget.dart';

///Helper class to handle dialog appearance
///Keeps the latest dialog and closes the previous dialog automatically
class DialogHelper {
  static const Color BACKGROUND_COLOR = Color(0x61000000);
  static const Duration DEFAULT_DURATION = Duration(milliseconds: 150);

  static final DialogHelper _instance = DialogHelper._();

  factory DialogHelper() => _instance;

  DialogHelper._();

  OverlayEntry? _currentOverlay;
  Future<bool> Function()? _currentCallback;
  StreamController<double>? _currentController;

  // Shows the dialog
  void show(BuildContext context, DialogWidget dialog, {bool rootOverlay = true}) {
    hideImmediate(context);

    var overlayState = rootOverlay
        ? context.findRootAncestorStateOfType<OverlayState>()
        : context.findAncestorStateOfType<OverlayState>();

    if (dialog.closable) {
      _currentCallback = () {
        hide(context);
        return Future.value(false);
      };

      ModalRoute.of(context)?.addScopedWillPopCallback(_currentCallback!);
    }

    _currentController = StreamController();

    _currentOverlay = OverlayEntry(
      builder: (_) => AppearWidget(
        progress: _currentController!.stream,
        duration: DEFAULT_DURATION,
        style: AppearStyle.opacity,
        child: Stack(
          children: <Widget>[
            if (dialog.hasBarrier)
              GestureDetector(
                onTap: () => dialog.closable ? hide(context) : () {},
                child: Container(
                  color: BACKGROUND_COLOR,
                ),
              ),
            dialog,
          ],
        ),
      ),
    );

    overlayState?.insert(_currentOverlay!);
    _currentController!.add(1.0);
  }

  // Hide opened dialog with animation
  void hide(BuildContext context) {
    if (_currentCallback != null) {
      ModalRoute.of(context)?.removeScopedWillPopCallback(_currentCallback!);
      _currentCallback = null;
    }

    if (_currentController != null) {
      _currentController!.add(0.0);

      Future.delayed(DEFAULT_DURATION).then((_) {
        _currentController?.close();
        _currentController = null;
        _currentOverlay?.remove();
        _currentOverlay = null;
      }).catchError((error) {});
    }
  }

  // Hide opened dialog without animation, clear closable callback if any
  void hideImmediate(BuildContext context) {
    //reset back press handler
    if (_currentCallback != null) {
      ModalRoute.of(context)?.removeScopedWillPopCallback(_currentCallback!);
      _currentCallback = null;
    }

    _currentController?.close();
    _currentController = null;

    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}
