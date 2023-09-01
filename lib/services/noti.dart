import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;


class NotificationService{
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification()async{
    AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings("@mipmap/ic_launcher");

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings
    );
    await notificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationRes)async{});
  }

  Future showNotification({
    int id=0,
    String title= "Student Attendance Tracker",
    String? body,
    String? payload, })async{
    return notificationsPlugin.show(id, title, body, await notificationDetails());
  }

  Future schdeuleNotification({
    required int id,
    String title= "Student Attendance Tracker",
    String? body,
    String? payload,
    required DateTime scheduleDateTime})async{
    return notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduleDateTime, tz.local),
      await notificationDetails(),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          "channelId",
          "channelName",
        importance: Importance.max,
        priority: Priority.high,
        icon: "ic_launcher"
      )
    );
  }
}