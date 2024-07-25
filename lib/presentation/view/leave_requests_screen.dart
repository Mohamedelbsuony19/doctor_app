import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clinc_vandor/presentation/view/error_screen.dart';
import 'package:clinc_vandor/presentation/widgets/custom_date_field.dart';
import 'package:clinc_vandor/presentation/widgets/custom_text_filed.dart';
import 'package:clinc_vandor/presentation/widgets/data_save_botton.dart';
import 'package:clinc_vandor/presentation/widgets/leave_info_widget.dart';
import 'package:clinc_vandor/presentation/widgets/show_snack_bar.dart';
import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LeaveRequestsScreen extends StatefulWidget {
  const LeaveRequestsScreen({super.key});

  @override
  State<LeaveRequestsScreen> createState() => _LeaveRequestsScreenState();
}

class _LeaveRequestsScreenState extends State<LeaveRequestsScreen> {
  final String doctorId = preferences.getString(SharedKeys.userId) ?? "";
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController description = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context
        .read<LeaveRequestBloc>()
        .add(LeaveRequestEvent.getLeaveRequestForDoctor(doctorId: doctorId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeaveRequestBloc, LeaveRequestState>(
      listener: (context, state) {
        state.maybeMap(
          orElse: () {},
          success: (value) {
            if (value.added) {
              context.read<LeaveRequestBloc>().add(
                  LeaveRequestEvent.getLeaveRequestForDoctor(
                      doctorId: doctorId));
              ShowSnackbar.showCheckTopSnackBar(context,
                  text: "Leave request added successfully",
                  type: SnackBarType.success);
              context.pop();
            }
          },
        );
      },
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          success: (value) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  addLeaveRequestMethod();
                },
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(title: const Text('Leave Requests')),
              body: ListView.builder(
                itemBuilder: (context, index) {
                  final data = value.leaveRequestEntity.value?.data?[index];
                  return LeaveInfoWidget(
                    description: data?.description,
                    endDate: data?.endDate,
                    startDate: data?.startDate,
                    leaveType: data?.leaveType?.typeName,
                    deleteOnPressed: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'Delete Leave Request',
                        desc:
                            'Are you sure you want to delete this leave request?',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          context.read<LeaveRequestBloc>().add(
                              LeaveRequestEvent.deleteLeaveRequest(
                                  leaveRequestId: data?.id.toString() ?? "",
                                  doctorId: doctorId));
                        },
                      ).show();
                    },
                  );
                },
                itemCount: value.leaveRequestEntity.value?.data?.length,
              ),
            );
          },
          failure: (value) {
            return ErrorScreen(errorMessage: value.message);
          },
        );
      },
    );
  }

  void addLeaveRequestMethod() {
    ThemeData theme = Theme.of(context);

    showModalBottomSheet(
      isScrollControlled: true, // Add this line to allow scrolling
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Adjust padding for keyboard
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(90, 217, 217, 217),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child: Text(
                          'Add Leave Request',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      CustomDateField(
                        controller: startDate,
                        hintText: 'Enter Your Start Date',
                        labelText: 'Start Date',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Start Date can't be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomDateField(
                        controller: endDate,
                        hintText: 'Enter Your End Date',
                        labelText: 'End Date',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "End Date can't be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Description can't be empty";
                          }
                          return null;
                        },
                        controller: description,
                        obscureText: false,
                        hintText: 'Enter Your Description',
                      ),
                      const SizedBox(height: 20),
                      const Spacer(),
                      DataSaveButton(
                        text: 'Submit',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<LeaveRequestBloc>().add(
                                  LeaveRequestEvent.addLeaveRequest(
                                    input: AddLeaveRequestInput(
                                      leaveTypeId: 1,
                                      description: description.text,
                                      employeeId: doctorId,
                                      endDate: endDate.text,
                                      startDate: startDate.text,
                                    ),
                                  ),
                                );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
