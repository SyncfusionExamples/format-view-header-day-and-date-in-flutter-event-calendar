import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  return runApp(ViewHeaderTextFormat());
}

class ViewHeaderTextFormat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalendarExample();
}

class CalendarExample extends State<ViewHeaderTextFormat> {
  CalendarController _controller;
  String _dayFormat, _dateFormat;
  List<CalendarView> _allowedViews;
  CalendarDataSource _dataSource;

  @override
  initState() {
    _controller = CalendarController();
    _dayFormat = 'EEE';
    _dateFormat = 'dd';
    _allowedViews = [
      CalendarView.day,
      CalendarView.week,
      CalendarView.workWeek
    ];
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
          allowedViews: _allowedViews,
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
      endTime: DateTime.now().add(Duration(hours: 2)),
      subject: 'Meeting',
      color: Colors.greenAccent,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(hours: 2)),
      endTime: DateTime.now().add(Duration(hours: 3)),
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
