// import 'dart:developer';

// import 'package:clinc_vandor/core/dependecy_injection/di_container.dart';
// import 'package:clinc_vandor/presentation/bloc/appointment/appointment_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../widgets/data_timer_picker.dart';

// class RescheduleScreen extends StatelessWidget {
//   final String appointmentId;
//   final String date;
//   final String startTime;
//   final String endTime;
//   final String calenderId;
//   final String patientId;
//   const RescheduleScreen({
//     super.key,
//     required this.appointmentId,
//     required this.date,
//     required this.startTime,
//     required this.endTime,
//     required this.calenderId,
//     required this.patientId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Update Appointment"),
//       ),
//       body: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             children: [
//               Center(
//                 child: DateTimePicker(
//                   patientId: patientId,
//                   calenderId: calenderId,
//                   selectedDate: date,
//                   startTime: startTime,
//                   endTime: endTime,
//                   onPressed: (calenderId, startTime, endTime, selectedDate,
//                       patientId) {
//                     String? userId = preferences.getString('userId');
//                     context
//                         .read<AppointmentBloc>()
//                         .add(AppointmentEvent.(
//                           calenderId: calenderId,
//                           startTime: startTime,
//                           endTime: endTime,
//                           date: selectedDate,
//                           patientId: patientId,
//                           doctorId: userId ?? "",
//                         ));
//                   },
//                   onDateTimeChanged: (DateTime dateTime) {
//                     log("Selected DateTime: ");
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: MediaQuery.sizeOf(context).height * 0.02,
//               ),
//               // CustomBotton(
//               //     onPressed: () {
//               //       showModalBottomSheet(
//               //           isScrollControlled: true,
//               //           context: context,
//               //           builder: (context) {
//               //             return Padding(
//               //               padding: EdgeInsets.only(
//               //                 right: 16,
//               //                 left: 16,
//               //                 bottom: MediaQuery.of(context).viewInsets.bottom,
//               //               ),
//               //               child: const ShowModelBottomSheetComponant(),
//               //             );
//               //           });
//               //     },
//               //     color: const Color(0xFFBCCBF9),
//               //     text: 'Add Precription'),
//               const Spacer(),
//             ],
//           )),
//     );
//   }
// }
