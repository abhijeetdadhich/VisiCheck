import 'package:flutter/material.dart';
import 'package:visicheck/components/view_attendance_table.dart';

class ViewAttendancePage extends StatefulWidget {
  const ViewAttendancePage({super.key});

  @override
  State<ViewAttendancePage> createState() => _ViewAttendancePageState();
}

class _ViewAttendancePageState extends State<ViewAttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'View Attendance',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            label: Text(
              'Export',
              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            icon: Icon(
              Icons.download,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          )
        ],
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onBackground),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        alignment: Alignment.topCenter,
        child: ViewAttendanceTable(),
      ),
    );
  }
}
