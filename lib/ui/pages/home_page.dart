import 'package:clock_app/constants/data.dart';
import 'package:clock_app/constants/enums.dart';
import 'package:clock_app/constants/theme.dart';
import 'package:clock_app/models/menu_info.dart';
import 'package:clock_app/ui/components/alarm.dart';
import 'package:clock_app/ui/components/clock.dart';
import 'package:clock_app/ui/components/stopwatch_component.dart';
import 'package:clock_app/ui/components/timer_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems.map((e) => buildMenuButton(context, currentMenuInfo: e)).toList(),
          ),
          VerticalDivider(
            color: CustomColors.dividerColor,
            width: 1,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (BuildContext context, MenuInfo value, Widget? child) {
                if (value.menuType == MenuType.clock)
                  return Clock();
                else if (value.menuType == MenuType.alarm)
                  return Alarm();
                else if (value.menuType == MenuType.timer)
                  return TimerComponent();
                else if (value.menuType == MenuType.stopwatch)
                  return StopwatchComponent();
                else
                  return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(context, {required MenuInfo currentMenuInfo}) {
    return Consumer(
      builder: (BuildContext context, MenuInfo value, Widget? child) => TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ),
          ),
          backgroundColor: currentMenuInfo.menuType == value.menuType
              ? CustomColors.menuBackgroundColor
              : Colors.transparent,
        ),
        onPressed: () {
          MenuInfo menuInfo = Provider.of<MenuInfo>(context, listen: false);
          menuInfo.updateMenu(currentMenuInfo);
        },
        child: Column(
          children: [
            Image.asset(
              currentMenuInfo.imageSource!,
              scale: 1.5,
            ),
            SizedBox(height: 16.0),
            Text(
              currentMenuInfo.title ?? '',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
