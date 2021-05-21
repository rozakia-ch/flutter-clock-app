import 'package:clock_app/constants/data.dart';
import 'package:clock_app/constants/theme.dart';
import 'package:clock_app/models/alarm_info.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class Alarm extends StatelessWidget {
  const Alarm({Key? key}) : super(key: key);

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
                  .followedBy([_buildAddAlarm()]).toList(),
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
          onPressed: () {},
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
}
