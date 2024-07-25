import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem(
      {super.key, required this.text, required this.icon, this.onTap});
  final String text;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return ListTile(
      onTap: () => onTap?.call(),
      title: Text(
        text,
        style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 17,
            fontWeight: FontWeight.bold),
      ),
      leading: Icon(icon, color: theme.colorScheme.onSurface),
    );
  }
}
