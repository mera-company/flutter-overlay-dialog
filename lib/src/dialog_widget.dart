import 'package:flutter/widgets.dart';
import 'package:overlay_dialog/overlay_dialog.dart';
import 'package:overlay_dialog/src/dialog_factory.dart';
import 'package:overlay_dialog/src/entity/dialog_action.dart';
import 'package:overlay_dialog/src/entity/dialog_style.dart';

/// Represents dialog in Material or Cupertino style,
/// adaptive dialog chooses style depends on platform
///
/// closable flag allows to hide dialog by back press or touch outside
class DialogWidget extends StatelessWidget {
  final bool closable;
  final Widget _widget;

  DialogWidget.alert({
    DialogStyle? style,
    required String title,
    required String content,
    required List<DialogAction> actions,
    this.closable = true,
  }): _widget = DialogFactory(style ?? DialogHelper.defaultStyle).alert(title, content, actions);

  /*DialogWidget.input();*/

  DialogWidget.progress({
    DialogStyle? style,
    this.closable = false
  }): _widget = DialogFactory(style ?? DialogHelper.defaultStyle).progress();

  DialogWidget.custom({
    DialogStyle? style,
    required Widget child,
    this.closable = true
  }): _widget = DialogFactory(style ?? DialogHelper.defaultStyle).custom(child);

  @override
  Widget build(BuildContext context) {
    return _widget;
  }
}