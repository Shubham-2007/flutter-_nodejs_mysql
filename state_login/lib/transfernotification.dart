import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class Messaging {
  static final Client client = Client();
  // from 'https://console.firebase.google.com'
  // --> project settings --> cloud messaging --> "Server key"
   static const String serverKey =
      'AAAAYpVTJfw:APA91bEHpMnXCvvVYxfZRhzTma-x1lTGBvpoGLfdf-Qf3fh58XTVelZOM3MPo-HU9IZVwlHefFBQh_JUDFnBmUMiMGD4w8hASl2z_XlAKijco97ka2D_PZbU4fQck_zuQQ6CfaNcUvQo';
      
  static Future<Response> sendToTopic(
          {@required String title,
          @required String body,
          @required String usertoken}) =>
      sendTo(title: title, body: body, fcmToken: '/$usertoken');

  static Future<Response> sendTo({
    @required String title,
    @required String body,
    @required String fcmToken,
  }) =>
      client.post(
        'https://fcm.googleapis.com/fcm/send',
        body: json.encode({
          'notification': {'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
          },
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );
}
