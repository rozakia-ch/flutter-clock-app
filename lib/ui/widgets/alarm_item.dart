import 'package:clock_app/constants/theme.dart';
import 'package:clock_app/models/alarm_info.dart';
import 'package:flutter/material.dart';

class AlarmItem extends StatelessWidget {
  const AlarmItem({Key? key, required this.alarmInfo}) : super(key: key);

  final AlarmInfo alarmInfo;
  @override
  Widget build(BuildContext context) {
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
