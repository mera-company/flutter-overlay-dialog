import 'package:flutter/widgets.dart';

// Default action to handle dialog button tap
// isDefault and isDestructive flags are used for Cupertino dialogs
class DialogAction {
  String title;
  Function handler;
  bool isDefault = false;
  bool isDestructive = false;

  DialogAction({@required this.title, this.handler, this.isDefault = false, this.isDestructive = false});
}