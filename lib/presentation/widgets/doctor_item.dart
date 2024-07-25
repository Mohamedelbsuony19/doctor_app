import 'package:flutter/material.dart';

class DoctorItem extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String doctorName;
  final String doctorType;
  final String doctorDescription;
  final String? price;
  final bool? showPrice;
  final Color? color;

  const DoctorItem({
    super.key,
    this.onTap,
    required this.doctorName,
    required this.doctorDescription,
    required this.doctorType,
    this.price,
    this.showPrice = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  doctorDescription,
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  doctorType,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            const Spacer(),
            showPrice!
                ? Text("$price EGP",
                    style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
