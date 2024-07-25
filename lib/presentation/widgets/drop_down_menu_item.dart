import 'package:flutter/material.dart';

class DropDownMenuItem extends StatelessWidget {
  const DropDownMenuItem({
    super.key,
    this.items,
    required this.hintText,
  });
  final List<DropdownMenuItem<String>>? items;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        menuMaxHeight: 300,
        itemHeight: 50,
        isExpanded: true,
        dropdownColor: const Color(0xFFBCCBF9),
        hint: Text(hintText),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        borderRadius: BorderRadius.circular(10),
        items: items,
        onChanged: (value) {});
  }
}
