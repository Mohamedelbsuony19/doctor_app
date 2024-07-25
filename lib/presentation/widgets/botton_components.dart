import 'package:flutter/material.dart';

import 'custom_button.dart';

class BottonComponents extends StatelessWidget {
  const BottonComponents(
      {super.key, this.swipeToCompleteOnPressed, this.cancel});
  final void Function()? swipeToCompleteOnPressed;
  final void Function()? cancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          onPressed: cancel,
          color: Theme.of(context).colorScheme.error,
          text: 'Cancel',
          textColor: Theme.of(context).colorScheme.onError,
        ),
        SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),
        CustomButton(
          onPressed: swipeToCompleteOnPressed,
          color: Theme.of(context).colorScheme.primary,
          text: 'Add Prescription',
          textColor: Theme.of(context).colorScheme.onPrimary,
        ),
      ],
    );
  }
}
