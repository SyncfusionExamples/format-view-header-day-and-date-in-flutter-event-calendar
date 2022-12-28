import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  return runApp(const ViewHeaderTextFormat());
}

class ViewHeaderTextFormat extends StatefulWidget {
  const ViewHeaderTextFormat({super.key});

  @override
  State<StatefulWidget> createState() => CalendarExample();
}

class CalendarExample extends State<ViewHeaderTextFormat> {
  final CalendarController _controller = CalendarController();
  String _dayFormat = 'EEE', _dateFormat = 'dd';
  CalendarDataSource? _dataSource;

  @override
  initState() {
    _dataSource = _getCalendarDataSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
            child: SfCalendar(
              view: CalendarView.week,
              allowedViews: const [
                CalendarView.day,
                CalendarView.week,
                CalendarView.workWeek
              ],
              controller: _controller,
              dataSource: _dataSource,
              timeSlotViewSettings: TimeSlotViewSettings(
                  dateFormat: _dateFormat, dayFormat: _dayFormat),
              onViewChanged: viewChanged,
            ),
          )),
    );
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 2)),
      subject: 'Meeting',
      color: Colors.greenAccent,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 2)),
      endTime: DateTime.now().add(const Duration(hours: 3)),
      subject: 'Planning',
      color: Colors.green,
    ));

    return _AppointmentDataSource(appointments);
  }

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    if (_controller.view == CalendarView.day) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        if (_dayFormat != 'EEEEE' || _dateFormat != 'dd') {
          setState(() {
            _dayFormat = 'EEEEE';
            _dateFormat = 'dd';
          });
        } else {
          return;
        }
      });
    } else {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        if (_dayFormat != 'EEE' || _dateFormat != 'dd') {
          setState(() {
            _dayFormat = 'EEE';
            _dateFormat = 'dd';
          });
        } else {
          return;
        }
      });
    }
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}