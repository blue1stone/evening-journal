import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/db_helper.dart';
import 'helpers/notification_helper.dart';
import 'screens/detail_screen.dart';
import 'screens/edit_screen.dart';
import 'screens/licenses_screen.dart';
import 'screens/overview_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  await initNotifications(flutterLocalNotificationsPlugin);

  final sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool(
      'alarmOn', sharedPreferences.getBool('alarmOn') ?? false);
  sharedPreferences.setString(
      'alarmTime',
      sharedPreferences.getString('alarmTime') ??
          DateTime(2020, 1, 1, 12, 0).toIso8601String());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));

    return MultiProvider(
      providers: [
        Provider<AppDatabase>(create: (_) => AppDatabase()),
        Provider<FlutterLocalNotificationsPlugin>(
          create: (_) => flutterLocalNotificationsPlugin,
        )
      ],
      child: MaterialApp(
        title: 'Evening Journal',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF223A40),
          scaffoldBackgroundColor: const Color(0xFF223A40),
          backgroundColor: const Color(0xFF223A40),
          accentColor: const Color(0xFFF2AB91),
          textTheme: ThemeData.dark().textTheme.copyWith(
                headline3: ThemeData.dark()
                    .textTheme
                    .headline3
                    .copyWith(color: const Color(0xFFF2D1B3)),
                headline4: ThemeData.dark()
                    .textTheme
                    .headline4
                    .copyWith(color: const Color(0xFFF2D1B3)),
                headline5: ThemeData.dark()
                    .textTheme
                    .headline5
                    .copyWith(color: const Color(0xDDFFFFFF)),
                headline6: ThemeData.dark()
                    .textTheme
                    .headline6
                    .copyWith(color: const Color(0xDDFFFFFF)),
              ),
        ),
        routes: {
          '/': (_) => OverviewScreen(),
          EditScreen.routeName: (_) => EditScreen(),
          DetailScreen.routeName: (_) => DetailScreen(),
          LicensesScreen.routeName: (_) => LicensesScreen(),
        },
      ),
    );
  }
}
