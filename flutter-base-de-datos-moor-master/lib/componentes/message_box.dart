import 'package:flutter/material.dart';

messageBox(
    {@required BuildContext context,
    IconData icon = Icons.warning,
    String title = '',
    Widget content = null,
    Function onPressOkBtn,
    Function onPressCancelBtn}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon),
          SizedBox(
            width: 10.0,
          ),
          Text(title)
        ],
      ),
      content: content,
      actions: <Widget>[
        if (onPressOkBtn != null)
          FlatButton(
            child: Text('Ok'),
            onPressed: onPressOkBtn,
          ),
        if (onPressCancelBtn != null)
          FlatButton(
            child: Text('Cancelar'),
            onPressed: onPressCancelBtn,
          ),
      ],
    ),
  );
}
