import 'data_save_botton.dart';
import 'package:flutter/material.dart';

import 'custom_text_filed.dart';
import 'drop_down_menu_item.dart';

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.4,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const CustomTextField(hintText: 'Name'),
          const SizedBox(
            height: 10,
          ),
          const CustomTextField(hintText: 'description'),
          const SizedBox(
            height: 10,
          ),
          const DropDownMenuItem(
            hintText: 'Select Medicine',
            items: [
              DropdownMenuItem(
                value: 'Morning',
                child: Text('Morning'),
              ),
              DropdownMenuItem(
                value: 'Afternoon',
                child: Text('Afternoon'),
              ),
              DropdownMenuItem(
                value: 'Evening',
                child: Text('Evening'),
              ),
            ],
          ),
          const Spacer(),
          DataSaveButton(
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
