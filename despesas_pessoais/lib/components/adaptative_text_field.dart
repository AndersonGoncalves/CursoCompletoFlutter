import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptaviveTextField extends StatelessWidget {
  const AdaptaviveTextField({
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onSubmitted,
    this.label,
    super.key,
  });

  final String? label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: controller,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              placeholder: label,
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            controller:
                controller, //onChanged: (newValue) => _valueController.text = newValue,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              labelText: label,
              //enabledBorder: UnderlineInputBorder(
              //  borderSide: BorderSide(
              //    color: Colors.grey,
              //  ),
              //),
              //focusedBorder: UnderlineInputBorder(
              //  borderSide: BorderSide(
              //    color: Colors.blue,
              //  ),
              //),
            ),
          );
  }
}
