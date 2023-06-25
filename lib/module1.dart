import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget rowInputField(
    String labelText,
    TextEditingController fieldTextController,
    Function(String value) onchanged) {
  return SizedBox(
    width: 100,
    child: TextField(
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.cyanAccent),
        ),
      ),
      keyboardType: const TextInputType.numberWithOptions(),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow((RegExp("[.0-9]")))
      ],
      controller: fieldTextController,
      onChanged: onchanged,
    ),
  );
}

Widget textField(String text, TextAlign textAlign) {
  return SizedBox(
    width: 100,
    height: 50,
    child: Text(
      text,
      textAlign: textAlign,
    ),
  );
}

Widget dateTextField() {
  DateTime now = DateTime.now();
  DateTime date = DateTime(now.year, now.month, now.day);
  return SizedBox(
    width: 100,
    child: Text(
      date.toString().replaceAll("00:00:00.000", ""),
      textAlign: TextAlign.center,
    ),
  );
}

Widget labelTextField(String text, TextAlign textAlign) {
  return SizedBox(
    width: 100,
    child: Text(
      text,
      textAlign: textAlign,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget subLabelTextField(String text, TextAlign textAlign) {
  return SizedBox(
    width: 100,
    child: Text(
      text,
      textAlign: textAlign,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget elevetedButtonWidget(String text, Function onpressed) {
  return SizedBox(
    width: 120,
    child: ElevatedButton(
      onPressed: () => onpressed(),
      child: Text(text),
    ),
  );
}
