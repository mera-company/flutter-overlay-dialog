# OverlayDialog

A Flutter package for showing platform dialogs without using new routes.

  - No confusing navigation - dialog added to the current route
  - Supports Material and Cupertino dialogs
  - Flutter-based solution, no additional imports needed

![Overlay Dialog Demo](https://github.com/mera-company/flutter-overlay-dialog/blob/master/doc/overlay_dialog_demo.gif?raw=true =300x533)

# What's the problem?

During project develop we stucks with several problems with Flutter dialogs. This package solves several problems of standart Flutter approach.
  - Flutter creates a new route when adding dialogs with `showDialog<T>`. It causes problems in case when app handles lifecycle (route) events and relies on calls look like `ModalRoute.of(context).isCurrent`. Actually Dialog route becomes active and page route goes background.
  - `showDialog<T>` call is asynchronous, there is no straight-forward way to detect if it is really opened. If app needs to open / close several dialogs rapidly, the synchronization mechanism would be tricky.
  - Dialog shares the same navigator with app pages and can't be named. `Navigator.of(context).pop()` closes the dialog or the page, which may be confusing.

OverlayDialog solves these problems by adding dialog to route overlay, so app navigation and lifecycle becomes easier.

# Features

  - OverlayDialog uses Flutter dialogs under the cover, so widgets UI is the same. Material and Cupertino alert and progress dialogs are available. Dialog style is set via App theme.
  - OverlayDialog adds dialog to the route overlay without new route creating. This makes lifecycle and navigation calls clearly.
  - OverlayDialog follows design guidelines and handles back press for android devices (this may be disabled if needed). It animates dialog appear and disappear to follow native design.
  - DialogHelper consolidates all logic for show / hide actions. Previously opened dialogs closes automatically when new dialog added.

### Usage

For a complete usage, please see the [example](https://github.com/mera-company/flutter-overlay-dialog/-/tree/master/example).

Alert Dialog instance is created by call `DialogWidget.alert(...)`. Additional flags may be set for `DialogAction` to highlight Cupertino buttons. These settings doesn't make sense for Material dialogs. Alert dialog is closable by default, this option may be disabled by setting `closable` parameter.

```express
DialogWidget.alert(
  closable: true,
  style: DialogStyle.material,
  title: "Title",
  content: "Content",
  actions: [
    DialogAction(
      title: "Button One",
      handler: buttonOneHandler,
      isDestructive: true,
    ),
    DialogAction(
      title: "Button Two",
      handler: buttonTwoHandler,
      isDefault: true,
    ),
  ],
)
```

Progress dialog isn't closable by default and shows circular spinner.

```
DialogWidget.progress(
  style: DialogStyle.material
)
```

Custom dialog allows to show any widget on gray-out layout.

```
DialogWidget.custom(
  child: widget
)
```

`DialogHelper()` uses to show and hide dialogs. This is singleton instanse so it is no need to keep it inside app variables.

```
DialogHelper().show(
  context,
  widget,
)
```

### Dialog Theme

Dialog customization may be achieved via app theme setup.

```
ThemeData(
  brightness: Brightness.light,                           // Light or Dark theme
  accentColor: Colors.red,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.accent,
  ),
  buttonBarTheme: ButtonBarThemeData(
    buttonTextTheme: ButtonTextTheme.accent,              // Button style
    alignment: MainAxisAlignment.end,                     // Button position
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.blue,                         // Dialog background
    titleTextStyle: TextStyle(color: Colors.green),       // Title style
    contentTextStyle: TextStyle(color: Colors.purple),    // Content style
  )
)
```

### Development

This package is actively developed alongside production apps, and the API will change as we continue our way to version 1.0.

Please be fully prepared to deal with breaking changes.

### Contributing

Please read CONTRIBUTING.md for details on our code of conduct, and the process for submitting pull requests to us.

### Contributors/People

Anastasia Artemyeva (anastasia.artemyeva@orioninc.com)

### Todos

 - Add input dialogs
 - Add custom animation
 - Add tests

License
----

Apache License, Version 2.0

**Free Software, Hell Yeah!**
