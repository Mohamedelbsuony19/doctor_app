import 'package:flutter/material.dart';

class ReusableSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final double scale;

  const ReusableSwitch(
      {super.key,
      required this.label,
      required this.value,
      required this.onChanged,
      this.scale = 1.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 24),
        ),
        Transform.scale(
          scale: scale,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.green,
            inactiveThumbColor: Colors.red,
            activeTrackColor: Colors.green.shade200,
            inactiveTrackColor: Colors.red.shade200,
          ),
        ),
      ],
    );
  }
}
