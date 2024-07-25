import 'package:flutter/material.dart';

import 'botton_components.dart';
import 'doctor_item.dart';

class CalendarItem extends StatelessWidget {
  const CalendarItem({
    super.key,
    required this.doctor,
    required this.startTime,
    required this.endTime,
    required this.date,
    this.swipeToCompleteOnPressed,
    this.cancel,
  });

  final String doctor;
  final String startTime;
  final String endTime;
  final String date;
  final void Function()? swipeToCompleteOnPressed;
  final void Function()? cancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0XFFF8F5F5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(2, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          DoctorItem(
            color: Colors.grey.shade200,
            doctorDescription: "Data :",
            doctorName: "Patient : $doctor",
            doctorType: date,
            onTap: null,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer),
                      const SizedBox(width: 5),
                      Text(startTime),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text('to'),
                  ),
                  const Icon(Icons.today),
                  const SizedBox(width: 5),
                  Text(endTime),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          BottonComponents(
            cancel: cancel,
            swipeToCompleteOnPressed: swipeToCompleteOnPressed,
          )
        ],
      ),
    );
  }
}
