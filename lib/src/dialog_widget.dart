import 'package:flutter/widgets.dart';

import 'dialog_factory.dart';
import 'entity/dialog_action.dart';
import 'entity/dialog_style.dart';

/// Represents dialog in Material or Cupertino style,
/// adaptive dialog chooses style depends on platform
///
/// closable flag allows to hide dialog by back press or touch outside
class DialogWidget extends StatelessWidget {
  final bool closable;
  final bool hasBarrier;
  final Widget _widget;

  DialogWidget.alert({
    DialogStyle style = DialogStyle.adaptive,
    String title = '',
    String content = '',
    List<DialogAction> actions = const [],
    this.closable = true,
    this.hasBarrier = true,
  }) : _widget = DialogFactory(style).alert(title, content, actions);

  DialogWidget.progress({
    DialogStyle style = DialogStyle.adaptive,
    this.closable = false,
    this.hasBarrier = true,
  }) : _widget = DialogFactory(style).progress();

  const DialogWidget.custom({
    required Widget child,
    this.closable = true,
    this.hasBarrier = true,
  }) : _widget = child;

  @override
  Widget build(BuildContext context) {
    return _widget;
  }
}
