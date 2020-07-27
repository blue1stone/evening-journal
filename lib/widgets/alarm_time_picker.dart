import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/notification_helper.dart';

class AlarmTimePicker extends StatefulWidget {
  @override
  _AlarmTimePickerState createState() => _AlarmTimePickerState();

  AlarmTimePicker(this.sharedPreferences);
  final SharedPreferences sharedPreferences;
}

class _AlarmTimePickerState extends State<AlarmTimePicker> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text('Set a reminder'),
          Switch(
            value: widget.sharedPreferences.getBool('alarmOn'),
            onChanged: (val) async {
              await widget.sharedPreferences.setBool('alarmOn', val);
              if (val) {
                final time = DateTime.parse(
                    widget.sharedPreferences.getString('alarmTime'));
                await scheduleNotificationEveryDay(
                  Provider.of<FlutterLocalNotificationsPlugin>(context,
                      listen: false),
                  'reminder_channel',
                  'Don\'t forget to create your entry for today.',
                  Time(time.hour, time.minute),
                );
              } else {
                await turnOffNotifications(
                    Provider.of<FlutterLocalNotificationsPlugin>(context,
                        listen: false));
              }
              setState(() {});
            },
            inactiveThumbColor: Theme.of(context).accentColor,
            inactiveTrackColor: Color(0x22FFFFFF),
            activeColor: Theme.of(context).accentColor,
          ),
        ],
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          OutlineButton.icon(
            onPressed: () async {
              final pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime == null) return;
              await widget.sharedPreferences.setString(
                  'alarmTime',
                  DateTime(2020, 1, 1, pickedTime.hour, pickedTime.minute)
                      .toIso8601String());

              if (widget.sharedPreferences.getBool('alarmOn')) {
                final time = DateTime.parse(
                    widget.sharedPreferences.getString('alarmTime'));
                await scheduleNotificationEveryDay(
                  Provider.of<FlutterLocalNotificationsPlugin>(context,
                      listen: false),
                  'reminder_channel',
                  'Don\'t forget to create your entry for today.',
                  Time(time.hour, time.minute),
                );
              } else {
                await turnOffNotifications(
                    Provider.of<FlutterLocalNotificationsPlugin>(context,
                        listen: false));
              }
              setState(() {});
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
            highlightedBorderColor: Theme.of(context).accentColor,
            icon: const Icon(
              Icons.alarm,
              size: 35,
            ),
            label: Text(
              DateFormat.Hm().format(DateTime.parse(
                  widget.sharedPreferences.getString('alarmTime'))),
              style: TextStyle(fontSize: 35),
            ),
            padding: const EdgeInsets.all(15),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OKAY'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
