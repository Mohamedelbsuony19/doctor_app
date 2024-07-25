// import 'package:clinc_vandor/core/styles/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';

// import '../bloc/home_bloc/doctor_bloc.dart';
// import 'custom_loading_indicator.dart';
// import 'data_save_botton.dart';

// // ignore: must_be_immutable
// class DateTimePicker extends StatefulWidget {
//   String selectedDate;
//   String startTime;
//   String endTime;
//   String calenderId;
//   final String? patientId;
//   final Function(DateTime) onDateTimeChanged;
//   final Function(String calenderId, String startTime, String endTime,
//       String selectedDate, String patientId) onPressed;

//   DateTimePicker(
//       {super.key,
//       required this.calenderId,
//       required this.onDateTimeChanged,
//       required this.selectedDate,
//       required this.startTime,
//       required this.endTime,
//       this.patientId,
//       required this.onPressed});

//   @override
//   // ignore: library_private_types_in_public_api
//   _DateTimePickerState createState() => _DateTimePickerState();
// }

// class _DateTimePickerState extends State<DateTimePicker> {
//   DateTime date = DateTime.now();
//   DateTime toTime = DateTime.now();

//   TimeOfDay selectedTime = TimeOfDay.now();

//   void _pickDate() async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: date,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (pickedDate != null && pickedDate != date) {
//       setState(() {
//         DateFormat('yyyy-MM-dd').format(date);

//         date = pickedDate;

//         widget.selectedDate = DateFormat('yyyy-MM-dd').format(date);
//       });
//     }
//   }

//   void _pickFromTime() async {
//     final TimeOfDay? pickFromTime = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );
//     if (pickFromTime != null && pickFromTime != selectedTime) {
//       setState(() {
//         selectedTime = pickFromTime;
//         widget.startTime =
//             "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00";
//         widget.endTime =
//             "${(selectedTime.hour + 1).toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00";

//         setState(() {});
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<DoctorBloc, HomeState>(
//       listener: (context, state) {
//         state.maybeMap(
//           orElse: () {},
//           loading: (value) {
//             customLoadingIndicator(context);
//           },
//           success: (value) {
//             if (value.updatedAppointment) {
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   behavior: SnackBarBehavior.floating,
//                   backgroundColor: Colors.green,
//                   content: const Text("Updated Successfully",
//                       style: TextStyle(color: Colors.white))));
//             }

//             context
//                 .read<DoctorBloc>()
//                 .add(const HomeEvent.getAppointmentForDoctor());
//           },
//           failed: (value) {
//             context.pop();
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(value.message)));
//           },
//         );
//       },
//       builder: (context, state) {
//         return Column(
//           children: [
//             Row(
//               children: [
//                 Text(
//                   "Date :${widget.selectedDate}",
//                   style: const TextStyle(fontSize: 16, color: Colors.black),
//                 ),
//                 const Expanded(child: SizedBox()),
//                 IntrinsicWidth(
//                   child: MaterialButton(
//                     height: 40,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     color: AppColors.greenColor,
//                     onPressed: _pickDate,
//                     child: const Text('Select Date',
//                         style: TextStyle(color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Text(
//                   "From :${widget.startTime}",
//                   style: const TextStyle(fontSize: 16, color: Colors.black),
//                 ),
//                 const Expanded(child: SizedBox()),
//                 IntrinsicWidth(
//                   child: MaterialButton(
//                     height: 40,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     color: AppColors.greenColor,
//                     onPressed: () {
//                       _pickFromTime();
//                       setState(() {});
//                     },
//                     child: const Text('Select Time',
//                         style: TextStyle(color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.01,
//             ),
//             Row(
//               children: [
//                 Text(
//                   "TO :${widget.endTime}",
//                   style: const TextStyle(fontSize: 16, color: Colors.black),
//                 ),
//                 const Expanded(child: SizedBox()),
//               ],
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.1,
//             ),
//             DataSaveButton(
//               onPressed: widget.onPressed.call(
//                 widget.calenderId,
//                 widget.startTime,
//                 widget.endTime,
//                 widget.selectedDate,
//                 widget.patientId!,
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
