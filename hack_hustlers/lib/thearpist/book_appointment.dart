import 'package:flutter/material.dart';
import 'package:hack_hustlers/thearpist/patientDetails.dart';
import 'package:intl/intl.dart';

class book_appointment extends StatefulWidget {
  final String doctorUID;
  const book_appointment({super.key, required this.doctorUID});

  @override
  State<book_appointment> createState() => _book_appointmentState();
}

class _book_appointmentState extends State<book_appointment> {
  DateTime? selectedDate;
  String? selectedSlot;

  List<String> morningSlots = [
    '8:00 - 8:30 ',
    '8:30 - 9:00 ',
    '9:00 - 9:30 ',
    '9:30 - 10:00 ',
    '10:00 - 10:30 ',
    '10:30 - 11:00 '
  ];
  List<String> afternoonSlots = [
    '11:00 - 11:30 ',
    '11:30 - 12:00 ',
    '12:00 - 12:30 ',
    '12:30 - 13:00 ',
    '16:00 - 16:30 ',
    '16:30 - 17:00 '
  ];
  List<String> eveningSlots = [
    '17:00 - 17:30 ',
    '17:30 - 18:00 ',
    '18:00 - 18:30 ',
    '18:30 - 19:00 ',
    '19:00 - 19:30 ',
    '19:30 - 20:00 '
  ];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime secondDay = now.add(const Duration(days: 1));
    DateTime thirdDay = now.add(const Duration(days: 2));

    String formatNow = DateFormat('EEE, MMM d').format(now);
    String formatSec = DateFormat('EEE, MMM d').format(secondDay);
    String formatThird = DateFormat('EEE, MMM d').format(thirdDay);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Book Appointment'),
          backgroundColor: const Color.fromARGB(255, 108, 199, 242),
          bottom: TabBar(indicatorColor: Colors.black, tabs: [
            Tab(
              text: formatNow,
            ),
            Tab(
              text: formatSec,
            ),
            Tab(
              text: formatThird,
            ),
          ]),
        ),
        body: TabBarView(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                booking(
                    now, morningSlots, 'Morning', widget.doctorUID, context),
                booking(now, afternoonSlots, 'Afternoon', widget.doctorUID,
                    context),
                booking(now, eveningSlots, 'Evening', widget.doctorUID, context)
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                booking(secondDay, morningSlots, 'Morning', widget.doctorUID,
                    context),
                booking(secondDay, afternoonSlots, 'Afternoon',
                    widget.doctorUID, context),
                booking(secondDay, eveningSlots, 'Evening', widget.doctorUID,
                    context)
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                booking(thirdDay, morningSlots, 'Morning', widget.doctorUID,
                    context),
                booking(thirdDay, afternoonSlots, 'Afternoon', widget.doctorUID,
                    context),
                booking(thirdDay, eveningSlots, 'Evening', widget.doctorUID,
                    context)
              ],
            ),
          )
        ]),
      ),
    );
  }
}

Future<dynamic> showAlert(BuildContext context, DateTime? selectedDate,
    String? selectedSlot, String doctorUID) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                    'Selected Date: ${selectedDate != null ? DateFormat('EEE, MMM d').format(selectedDate) : 'No date selected'}'),
                Text('Selected Slot: ${selectedSlot ?? 'No slot selected'}'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => patientDetails(
                          selectedDate: selectedDate,
                          selectedSlot: selectedSlot,
                          doctUid: doctorUID,
                        ),
                      ));
                },
                child: const Text('Fill Patient Details')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            )
          ],
        );
      });
}

Widget booking(DateTime selectedDate, List<String> slot, String time,
    String doctorUID, BuildContext context) {
  String selectedSlot;
  bool isAppointmentPassed(DateTime appointmentDate, String appointmentTime) {
    try {
      final now = DateTime.now();
      final timeParts = appointmentTime.split('-');

      if (timeParts.length != 2) {
        return false;
      }

      final endTime = timeParts[1].trim();

      final end = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        int.parse(endTime.split(':')[0]),
        int.parse(endTime.split(':')[1]),
      );

      return now.isAfter(end);
    } catch (e) {
      // Handle parsing errors
      debugPrint('Error: $e');
      return false;
    }
  }

  return Card(
    margin: const EdgeInsets.all(15),
    color: Colors.blue[50],
    child: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          time,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(21, 101, 192, 1),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (int i = 0; i < slot.length; i++)
              ElevatedButton(
                  onPressed: isAppointmentPassed(selectedDate, slot[i])
                      ? null
                      : () {
                          selectedDate = selectedDate;
                          selectedSlot = slot[i];
                          showAlert(
                              context, selectedDate, selectedSlot, doctorUID);
                        },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(223, 138, 176, 251),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[400],
                      disabledForegroundColor: Colors.black),
                  child: Text(slot[i])),
            Container(
              height: 10,
              color: Colors.blue[50],
            )
          ],
        ),
      ],
    ),
  );
}
