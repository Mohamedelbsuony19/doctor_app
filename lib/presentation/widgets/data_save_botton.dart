import 'package:flutter/material.dart';

class DataSaveButton extends StatelessWidget {
  const DataSaveButton({
    super.key,
    this.text,
    this.onPressed,
  });
  final String? text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: double.infinity,
        height: 50,
        onPressed: onPressed,
        color: const Color(0xFFBCCBF9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text ?? 'Save',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ));
  }
}
