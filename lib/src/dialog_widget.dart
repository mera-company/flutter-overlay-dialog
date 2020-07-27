import 'package:flutter/widgets.dart';
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
    DialogStyle style = DialogStyle.adaptive,
    String title,
    String content,
    List<DialogAction> actions,
    this.closable = true,
  }): _widget = DialogFactory(style).alert(title, content, actions);

  /*DialogWidget.input();*/

  DialogWidget.progress({
    DialogStyle style = DialogStyle.adaptive,
    this.closable = false
  }): _widget = DialogFactory(style).progress();

  DialogWidget.custom({
    @required Widget child,
    this.closable = true
  }): _widget = Center(child: child);

  @override
  Widget build(BuildContext context) {
    return _widget;
  }
}