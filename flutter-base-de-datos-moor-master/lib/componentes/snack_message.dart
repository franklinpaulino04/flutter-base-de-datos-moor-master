import 'package:flutter/material.dart';

snackMessage(String message) => SnackBar(
      duration: Duration(milliseconds: 1500),
      content: Text(message),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
