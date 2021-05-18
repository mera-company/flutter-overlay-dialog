// Default action to handle dialog button tap
// isDefault and isDestructive flags are used for Cupertino dialogs
class DialogAction {
  String title;
  void Function()? handler;
  bool isDefault;
  bool isDestructive;

  DialogAction({required this.title, this.handler, this.isDefault = false, this.isDestructive = false});
}