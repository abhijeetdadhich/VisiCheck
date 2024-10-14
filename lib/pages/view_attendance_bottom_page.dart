import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:visicheck/components/view_attendance_dropdown.dart';
import 'package:visicheck/pages/view_attendance_page.dart';

final List<String> yearList = <String>[
  'First Year',
  'Second Year',
  'Third Year',
  'Fourth Year'
];

final List<String> branchList = <String>[
  'Computer Science & Engineering',
  'ECE',
  'IT',
  'CSAI',
  'ME',
  'CE',
  'AIDS'
];

final List<String> sectionList = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G'];

final _formKey = GlobalKey<FormState>();

class ViewAttendanceBottomPage extends StatefulWidget {
  const ViewAttendanceBottomPage({super.key});

  @override
  State<ViewAttendanceBottomPage> createState() =>
      _ViewAttendanceBottomPageState();
}

class _ViewAttendanceBottomPageState extends State<ViewAttendanceBottomPage> {
  String? yearDropdownValue;
  String? branchDropdownValue;
  String? sectionDropdownValue;

  @override
  Widget build(BuildContext context) {
    

    return Container(
      width: double.infinity,
      height: 500,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.98),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ViewAttendanceDropdown(
                    dropdownValue: yearDropdownValue,
                    list: yearList,
                    title: 'year',
                    dropdownWidth: 200,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ViewAttendanceDropdown(
                    dropdownValue: sectionDropdownValue,
                    list: sectionList,
                    title: 'section',
                    dropdownWidth: 200,
                  ),
                ]),
                const SizedBox(
                  height: 21,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const SizedBox(
                    width: 0,
                  ),
                  ViewAttendanceDropdown(
                    dropdownValue: branchDropdownValue,
                    list: branchList,
                    title: 'branch',
                    dropdownWidth: 390,
                  ),
                ]),
              ],
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          SizedBox(
            height: 60,
            width: 340,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const ViewAttendancePage()));  
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 7, 189, 128),
              ),
              icon: const Icon(
                Icons.remove_red_eye,
                color: Color.fromRGBO(14, 19, 24, 1.000),
              ),
              label: const Text(
                'View Attendance',
                style: TextStyle(
                  color: Color.fromRGBO(14, 19, 24, 1.000),
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
