import 'package:flutter/widgets.dart';

class DialogAction {
  String title;
  Function handler;
  bool isDefault = false;
  bool isDestructive = false;

  DialogAction({@required this.title, this.handler, this.isDefault = false, this.isDestructive = false});
}