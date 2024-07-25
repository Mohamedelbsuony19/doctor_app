import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveInfoWidget extends StatelessWidget {
  final String? startDate;
  final String? endDate;
  final String? description;
  final String? leaveType;
  final VoidCallback? deleteOnPressed;

  const LeaveInfoWidget({
    super.key,
    this.startDate,
    this.endDate,
    this.description,
    this.leaveType,
    this.deleteOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.26,
      child: Card(
        margin: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateRow(Icons.calendar_today, 'Start Date', startDate),
              const SizedBox(height: 8.0),
              _buildDateRow(Icons.calendar_today, 'End Date', endDate),
              const SizedBox(height: 16.0),
              _buildDescription(),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLeaveType(),
                  IconButton(
                      onPressed: deleteOnPressed,
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRow(IconData icon, String label, String? date) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 8.0),
        Text(
          '$label: ${date != null ? DateFormat.yMMMd().format(DateTime.parse(date)) : 'N/A'}',
          style: const TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Row(
      children: [
        const Icon(Icons.description, color: Colors.blue),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            description ?? 'No description provided',
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaveType() {
    return Row(
      children: [
        const Icon(Icons.category, color: Colors.blue),
        const SizedBox(width: 8.0),
        Text(
          'Leave Type: ${leaveType != null ? leaveType.toString().split('.').last : 'N/A'}',
          style: const TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
