import 'dart:developer';

import 'package:clinc_vandor/presentation/widgets/custom_text_filed.dart';
import 'package:clinc_vandor/presentation/widgets/data_save_botton.dart';
import 'package:clinc_vandor/presentation/widgets/show_snack_bar.dart';
import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../widgets/calendar_item.dart';
import '../widgets/patient_details_btm_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController name;
  late TextEditingController description;
  late TextEditingController medicine;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    name = TextEditingController();
    description = TextEditingController();
    medicine = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    medicine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointments",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: BlocConsumer<AppointmentBloc, AppointmentState>(
          listener: (context, state) {
            state.maybeMap(
              orElse: () {},
              success: (value) {
                if (value.changedToCompleted == true) {
                  context
                      .read<AppointmentBloc>()
                      .add(const AppointmentEvent.getAppointmentsForDoctor());
                  ShowSnackbar.showCheckTopSnackBar(context,
                      text: "Appointment Completed",
                      type: SnackBarType.success);
                  context.pop();
                }
                if (value.isDeleted == true) {
                  context
                      .read<AppointmentBloc>()
                      .add(const AppointmentEvent.getAppointmentsForDoctor());
                }
              },
            );
          },
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => const Center(child: CircularProgressIndicator()),
              success: (state) {
                final appointment = state.appointments
                    .where((e) => e.status == "Scheduled")
                    .toList();
                return state.appointments.isNotEmpty
                    ? ListView.builder(
                        itemCount: appointment.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              context.read<MedicalHistoryBloc>().add(
                                  MedicalHistoryEvent.getMedicalHistory(
                                      appointment[index].patientId));
                              showModalBottomSheet(
                                isScrollControlled: true,
                                useSafeArea: true,
                                context: context,
                                builder: (BuildContext context) {
                                  log(appointment[index].patientId);
                                  return ModalBottomSheet(
                                      patientName:
                                          appointment[index].patientName,
                                      startTime: appointment[index].startTime,
                                      endTime: appointment[index].endTime,
                                      day: appointment[index].date);
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CalendarItem(
                                date: appointment[index].date.substring(0, 10),
                                endTime: appointment[index].endTime,
                                startTime: appointment[index].startTime,
                                doctor:
                                    "${appointment[index].patientName}\n${appointment[index].status}",
                                cancel: appointment[index].status == "Canceled"
                                    ? null
                                    : () async {
                                        context.read<AppointmentBloc>().add(
                                            AppointmentEvent.deleteAppointment(
                                                id: appointment[index]
                                                    .id
                                                    .toString()));

                                        // await Future.delayed(
                                        //     const Duration(seconds: 2),
                                        //     () async {
                                        //   context.read<AppointmentBloc>().add(
                                        //       const AppointmentEvent
                                        //           .getAppointment());
                                        // });
                                      },
                                swipeToCompleteOnPressed: () {
                                  showBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Form(
                                          key: formKey,
                                          child: IntrinsicHeight(
                                            child: Container(
                                              padding: const EdgeInsets.all(20),
                                              decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      90, 217, 217, 217),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(20),
                                                  )),
                                              child: Center(
                                                  child: Column(
                                                children: [
                                                  SizedBox(
                                                    child: Text(
                                                      'Add Prescription',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: theme
                                                              .colorScheme
                                                              .primary,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  CustomTextField(
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Email can't be empty";
                                                        }
                                                        return null;
                                                      },
                                                      controller: name,
                                                      hintText: 'Enter Name'),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  CustomTextField(
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Medicine can't be empty";
                                                        }
                                                        return null;
                                                      },
                                                      controller: medicine,
                                                      hintText:
                                                          'Enter Medicine'),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  CustomTextField(
                                                      mixLine: 3,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "description can't be empty";
                                                        } else if (value
                                                                .length <
                                                            8) {
                                                          return 'description must be at least 8 characters';
                                                        }
                                                        return null;
                                                      },
                                                      controller: description,
                                                      obscureText: false,
                                                      hintText:
                                                          'Enter Your Description'),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  const Spacer(),
                                                  BlocListener<PrescriptionBloc,
                                                      PrescriptionState>(
                                                    listener: (context, state) {
                                                      state.maybeMap(
                                                          orElse: () {},
                                                          failure: (value) {
                                                            if (value
                                                                    .hasPreviousPrescription ==
                                                                true) {
                                                              context
                                                                  .read<
                                                                      AppointmentBloc>()
                                                                  .add(AppointmentEvent.changeAppointmentStatus(
                                                                      appointmentId:
                                                                          appointment[index]
                                                                              .id
                                                                              .toString()));
                                                            }
                                                            ShowSnackbar
                                                                .showCheckTopSnackBar(
                                                                    context,
                                                                    text: value
                                                                        .message,
                                                                    type: SnackBarType
                                                                        .error);
                                                            Navigator.of(
                                                                context);
                                                          },
                                                          success: (state) {
                                                            context
                                                                .read<
                                                                    AppointmentBloc>()
                                                                .add(AppointmentEvent.changeAppointmentStatus(
                                                                    appointmentId:
                                                                        appointment[index]
                                                                            .id
                                                                            .toString()));
                                                          });
                                                    },
                                                    child: DataSaveButton(
                                                      text: 'Swipe To Complete',
                                                      onPressed: () {
                                                        // authDataSource.login('admin', 'Admin123');
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          context.read<PrescriptionBloc>().add(PrescriptionEvent.add(
                                                              inputs: PrescriptionInputs(
                                                                  appointmentId:
                                                                      appointment[index]
                                                                          .id
                                                                          .toString(),
                                                                  datetime: DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS")
                                                                      .format(DateTime
                                                                          .now()),
                                                                  description:
                                                                      description
                                                                          .text,
                                                                  name:
                                                                      name.text,
                                                                  medicines: [
                                                                    medicine
                                                                        .text
                                                                  ],
                                                                  doctorId: appointment[
                                                                          index]
                                                                      .doctorId,
                                                                  patientId:
                                                                      appointment[index]
                                                                          .patientId)));
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              )),
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                            ),
                          );
                        })
                    : Center(child: Lottie.asset('assets/no_data_found.json'));
              },
              failed: (value) {
                return Center(
                  child: Text(value.message),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
