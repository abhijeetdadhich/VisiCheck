import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class ViewAttendanceDropdown extends StatefulWidget {
  ViewAttendanceDropdown(
      {super.key,
      required this.dropdownValue,
      required this.list,
      required this.title,
      required this.dropdownWidth});

  final List<String> list;
  String? dropdownValue;
  final String title;
  final double dropdownWidth;

  @override
  State<ViewAttendanceDropdown> createState() => _ViewAttendanceDropdownState();
}

class _ViewAttendanceDropdownState extends State<ViewAttendanceDropdown> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField2<String>(
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        value: widget.dropdownValue,
        hint: Row(
          children: [
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Select ${widget.title}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.list
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        validator: (value) {
          if (value == null) {
            return ('Please select ${widget.title}.');
          }
          return null;
        },
        onChanged: (value) {
          // setState(() {
          //   widget.dropdownValue = value!;
          // });
        },
        onSaved: (value) {
          widget.dropdownValue = value!;
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                // color: Theme.of(context).colorScheme.onBackground,
                ),
            // color: const Color.fromARGB(255, 140, 188, 252),
          ),
          elevation: 2,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: widget.dropdownWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).colorScheme.background,
          ),
          offset: const Offset(-10, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
