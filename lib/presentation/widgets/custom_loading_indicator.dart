import 'package:flutter/material.dart';

Future<dynamic> customLoadingIndicator(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
              height: MediaQuery.sizeOf(context).height * 0.09,
              width: MediaQuery.sizeOf(context).width * 0.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ))),
        );
      });
}
