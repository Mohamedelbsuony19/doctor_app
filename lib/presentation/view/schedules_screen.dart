import 'dart:developer';

import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_button.dart';
import '../widgets/show_snack_bar.dart';

class SchedulesScreen extends StatefulWidget {
  const SchedulesScreen({super.key});

  @override
  State<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  String? _selectedMinutes;

  String? selectedDay;
  late TextEditingController controller;

  final List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Schedules Slots",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: BlocConsumer<ScheduleBloc, ScheduleState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  success: (value) {
                    if (value.added) {
                      ShowSnackbar.showCheckTopSnackBar(
                        context,
                        text: "Schedule added successfully",
                        type: SnackBarType.success,
                      );
                      context.read<ScheduleBloc>().add(ScheduleEvent.getAll(
                          doctorId:
                              preferences.getString(SharedKeys.userId) ?? ""));
                    }
                  });
            },
            builder: (context, state) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        child: DropdownButtonFormField(
                          hint: const Text("Select Day"),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          isExpanded: true,
                          value: selectedDay,
                          icon: const Icon(Icons.arrow_drop_down),
                          alignment: Alignment
                              .centerLeft, // Align the text to the left
                          onChanged: (newValue) {
                            setState(() {
                              selectedDay = newValue!;
                            });
                          },
                          items: weekdays.map((weekday) {
                            return DropdownMenuItem(
                              value: weekday,
                              child: Text(weekday),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.05,
                              child: ElevatedButton(
                                onPressed: () => _pickFromTime().then((value) {
                                  setState(() {
                                    _selectedStartTime = value;
                                  });
                                }),
                                child: Text(
                                    "Start Time: ${(_selectedStartTime?.hour ?? "00").toString().padLeft(2, '0')} : ${(_selectedStartTime?.minute ?? "00").toString().padLeft(2, '0')}"),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.05,
                              child: ElevatedButton(
                                onPressed: () => _pickFromTime().then((value) {
                                  setState(() {
                                    _selectedEndTime = value;
                                  });
                                }),
                                child: Text(
                                    "End Time: ${(_selectedEndTime?.hour ?? "00").toString().padLeft(2, '0')} : ${(_selectedEndTime?.minute ?? "00").toString().padLeft(2, '0')}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        child: TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                              labelText: 'Enter Duration in minutes',
                              labelStyle: TextStyle(fontSize: 18)),
                          onChanged: (value) {
                            setState(() {
                              if (int.tryParse(value) != null) {
                                int hours = int.tryParse(value)! ~/ 60;
                                int minutes = int.tryParse(value)! % 60;
                                setState(() {
                                  _selectedMinutes =
                                      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
                                });
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          child: CustomButton(
                            color: theme.colorScheme.primary,
                            text: "Add",
                            textColor: Colors.white,
                            onPressed: selectedDay != null &&
                                    _selectedStartTime != null &&
                                    _selectedEndTime != null &&
                                    _selectedMinutes != null
                                ? () async {
                                    log("selectedDay: $selectedDay \n _startTime: ${(_selectedStartTime?.hour ?? "00").toString().padLeft(2, '0')}:${(_selectedStartTime?.minute ?? "00").toString().padLeft(2, '0')}:00\n _selectedEndTime: ${(_selectedEndTime?.hour ?? "00").toString().padLeft(2, '0')}:${(_selectedEndTime?.minute ?? "00").toString().padLeft(2, '0')}:00 \n _selectedMinutes: $_selectedMinutes:00");
                                    String? userId =
                                        preferences.getString('userId');

                                    context
                                        .read<ScheduleBloc>()
                                        .add(ScheduleEvent.add(
                                          doctorId: userId ?? "",
                                          dayOfWeek: weekdays.indexWhere(
                                              (e) => e == selectedDay!),
                                          startTime:
                                              "${(_selectedStartTime?.hour ?? "00").toString().padLeft(2, '0')}:${(_selectedStartTime?.minute ?? "00").toString().padLeft(2, '0')}:00",
                                          endTime:
                                              "${(_selectedEndTime?.hour ?? "00").toString().padLeft(2, '0')}:${(_selectedEndTime?.minute ?? "00").toString().padLeft(2, '0')}:00",
                                          duration: "${_selectedMinutes!}:00",
                                        ));
                                    await Future.delayed(
                                        const Duration(seconds: 5), () {
                                      context.read<ScheduleBloc>().add(
                                          ScheduleEvent.getAll(
                                              doctorId: preferences.getString(
                                                      SharedKeys.userId) ??
                                                  ""));
                                    });
                                  }
                                : null,
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Schedules",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      state.maybeMap(
                          orElse: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          error: (message) => Text(message.message),
                          success: (v) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: v.schedules.length,
                              itemBuilder: (context, index) => ListTile(
                                title: Text(
                                    weekdays[v.schedules[index].dayOfWeek!]),
                                trailing: Text(
                                  "${v.schedules[index].startTime!.substring(0, 5)} - ${v.schedules[index].endTime!.substring(0, 5)}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            );
                          })
                    ]),
                  ));
            },
          ),
        ));
  }

  Future<TimeOfDay> _pickFromTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 0, minute: 0),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: true,
              ),
              child: child!);
        });
    if (pickedTime != null) {
      return pickedTime;
    }
    return const TimeOfDay(hour: 0, minute: 0);
  }
}
