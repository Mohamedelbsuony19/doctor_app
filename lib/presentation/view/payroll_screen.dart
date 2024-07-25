import 'dart:developer';

import 'package:clinic_package/clinic_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PayrollScreen extends StatelessWidget {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {

        ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (context) =>
          PayrollBloc(getIt())..add(const PayrollEvent.getPayrollAllMonths()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payroll'),
        ),
        body: RefreshIndicator(
          onRefresh: () async => context
              .read<PayrollBloc>()
              .add(const PayrollEvent.getPayrollAllMonths()),
          child: BlocBuilder<PayrollBloc, PayrollState>(
            builder: (context, state) {
              return state.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                success: (payrolls) {
                  return payrolls.isEmpty
                      ? const Center(child: Text('No data found'))
                      : ListView.separated(
                          itemCount: payrolls.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                          itemBuilder: (BuildContext context, int index) =>
                              Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: ListTile(
                              isThreeLine: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              title: Text(
                                "${DateFormat.MMM().format(DateTime.parse(payrolls[index].salaryDate!))} \nTotal Salary \n${(payrolls[index].totalSalary!.toInt())}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              subtitle: Text(
                                "Base Salary + Bonus + Deductions: \n ${payrolls[index].baseSalary!.toInt()} + ${payrolls[index].bonusAmount!.toInt()} + ${payrolls[index].deductionAmount!.toInt()}",
                                style:  TextStyle(
                                  color:  theme.colorScheme.primary,
                                  fontSize: 16.0,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                   Text(
                                    "Total Working Hours",
                                    style: TextStyle(
                                      color: theme.colorScheme.primary,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.01),
                                  Text(
                                    "${payrolls[index].totalHoursWorked!.toInt()}",
                                    style:  TextStyle(
                                      color:  theme.colorScheme.primary,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                },
                failure: (message) {
                  log(message);
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 100,
                        ),
                        Text("Something went wrong please try again."),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
