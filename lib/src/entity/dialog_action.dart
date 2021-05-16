// Default action to handle dialog button tap
// isDefault and isDestructive flags are used for Cupertino dialogs
class DialogAction {
  final String title;
  final void Function()? handler;
  final bool isDefault;
  final bool isDestructive;

  DialogAction({required this.title, this.handler, this.isDefault = false, this.isDestructive = false});
}
