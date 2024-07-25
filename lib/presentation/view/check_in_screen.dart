import 'package:clinc_vandor/presentation/widgets/rusable_switch.dart';
import 'package:clinc_vandor/presentation/widgets/show_snack_bar.dart';
import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckInCheckOutScreen extends StatefulWidget {
  const CheckInCheckOutScreen({super.key});

  @override
  State<CheckInCheckOutScreen> createState() => _CheckInCheckOutScreenState();
}

class _CheckInCheckOutScreenState extends State<CheckInCheckOutScreen> {
  bool isCheckedIn = false;

  @override
  void initState() {
    super.initState();
    _initializeCheckInState();
  }

  void _initializeCheckInState() {
    final state = context.read<AttendanceBloc>().state;
    isCheckedIn = state.maybeMap(
      orElse: () => false,
      success: (value) => value.isCheckIn,
    );
  }

  void _onSwitchChanged(bool value) {
    setState(() {
      isCheckedIn = value;
      _handleRequest(value);
    });
  }

  void _handleRequest(bool checkIn) {
    final state = context.read<AttendanceBloc>().state;
    final currentState = state.maybeMap(
      orElse: () => false,
      success: (value) => value.isCheckIn,
    );

    if (checkIn) {
      if (!currentState) {
        context.read<AttendanceBloc>().add(const AttendanceEvent.checkIn());
      } else {
        _showSnackBar('Already Checked In', SnackBarType.error);
      }
    } else {
      context.read<AttendanceBloc>().add(const AttendanceEvent.checkOut());
    }
  }

  void _showSnackBar(String message, SnackBarType type) {
    ShowSnackbar.showCheckTopSnackBar(context, text: message, type: type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-In/Check-Out'),
      ),
      body: BlocListener<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          state.maybeMap(
            orElse: () {},
            success: (value) {
              if (value.attendance.isSuccess == true) {
                _showSnackBar(value.attendance.successMessage ?? "",
                    SnackBarType.success);
              }
            },
            failure: (value) {
              _showSnackBar(value.message, SnackBarType.error);
            },
          );
        },
        child: Center(
          child: ReusableSwitch(
            scale: 1.7,
            label: isCheckedIn ? 'Check-Out' : 'Check-In',
            value: isCheckedIn,
            onChanged: _onSwitchChanged,
          ),
        ),
      ),
    );
  }
}
