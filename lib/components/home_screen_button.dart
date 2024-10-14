import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:visicheck/pages/autocheck.dart';
import 'package:visicheck/pages/check_in_out.dart';
import 'package:visicheck/pages/mark_attendance_page.dart';
import 'package:visicheck/pages/view_attendance_bottom_page.dart';

class HomeScreenButton extends StatelessWidget {
  const HomeScreenButton({
    super.key,
    required this.buttonIcon,
    required this.buttonTitle,
  });

  final IconData buttonIcon;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final isWidthGreater = (screenWidth > screenHeight);

    final buttonSide =
        isWidthGreater ? (screenHeight * 0.41) : (screenWidth * 0.41);

    void _onButtonTap() {
      if (buttonTitle == 'Manual \n Check-in/out') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const CheckInOut(),
          ),
        );
      }

      if (buttonTitle == 'Automatic \n Check-in/out') {
        showModalBottomSheet(
          useSafeArea: true,
          isScrollControlled: true,
          context: context,
          builder: (ctx) => const AutoCheckInOut(),
        );

        // Navigator.of(context).push(MaterialPageRoute(
        //           builder: (ctx) => const ViewAttendancePage()));
        // ViewAttendancePage;
      }
    }

    return Container(
      height: (buttonSide + (buttonSide * (50 / 100))),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 39, 46, 53),
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _onButtonTap,
            child: Container(
              width: buttonSide,
              height: buttonSide,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 7, 189, 128),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Icon(
                buttonIcon,
                size: 80,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            buttonTitle,
            style: TextStyle(
                fontSize: 17, color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
