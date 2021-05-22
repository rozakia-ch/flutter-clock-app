import 'package:clock_app/constants/data.dart';
import 'package:clock_app/constants/theme.dart';
import 'package:clock_app/main.dart';
import 'package:clock_app/models/alarm_info.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Alarm extends StatefulWidget {
  const Alarm({Key? key}) : super(key: key);

  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  @override
  void initState() {
    tz.initializeTimeZones();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Alarm",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            child: ListView(
              children: alarms
                  .map<Widget>((e) => _buildAlarmItem(context, alarmInfo: e))
                  .followedBy([(alarms.length <= 5) ? _buildAddAlarm() : Container()]).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAddAlarm() {
    return DottedBorder(
      strokeWidth: 2,
      color: CustomColors.clockOutline,
      borderType: BorderType.RRect,
      radius: Radius.circular(24),
      dashPattern: [5, 4],
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: CustomColors.clockBG,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: TextButton(
          onPressed: () {
            var schedul = DateTime.now().add(Duration(seconds: 10));
            scheduleAlarm(scheduledNotificationDateTime: schedul, alarmInfo: alarms.first);
          },
          child: Column(
            children: [
              Image.asset(
                "assets/add_alarm.png",
                scale: 1.5,
              ),
              SizedBox(height: 5),
              Text("Add Alarm", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlarmItem(context, {required AlarmInfo alarmInfo}) {
    GradientColors gradientColor = GradientTemplate.gradientTemplate[alarmInfo.gradientColorIndex];
    return Container(
      margin: EdgeInsets.only(bottom: 32.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          gradient: LinearGradient(
            colors: gradientColor.colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColor.colors.last.withOpacity(0.4),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(4, 4),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.label,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  SizedBox(height: 8.0),
                  Text(alarmInfo.title, style: TextStyle(color: Colors.white)),
                ],
              ),
              Switch(
                onChanged: (bool value) {},
                value: true,
                activeColor: Colors.white,
              ),
            ],
          ),
          Text("Mon-Fri", style: TextStyle(color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "07:00 AM",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 24.0,
                ),
              ),
              Icon(Icons.keyboard_arrow_down, size: 36.0, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  void scheduleAlarm({
    required DateTime scheduledNotificationDateTime,
    required AlarmInfo alarmInfo,
  }) async {
    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'app_icon',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );

    IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Office',
      alarmInfo.title,
      tz.TZDateTime.now(tz.local).add(const Duration(minutes: 10)),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
