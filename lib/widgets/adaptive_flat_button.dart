import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String buttonText;
  final Function buttonAction;

  const AdaptiveFlatButton(this.buttonText, this.buttonAction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: () => buttonAction,
            child: Text(
              buttonText,
            ))
        : TextButton(onPressed: () => buttonAction, child: Text(buttonText));
  }
}
