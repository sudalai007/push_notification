import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notification/main.dart';

class FirebaseApi {
  //Create an instance of Firebase initialisation,
  final _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialised notification
  Future<void> initNotification() async {
    //request permission from the user(will prompt user)
    await _firebaseMessaging.requestPermission();
    //fetch the FCM token for this device
    final fCMToken = await _firebaseMessaging.getToken();

    //print the token(normally you would send this to your server)
    print('Token : $fCMToken');

    //initialise further settings for push noti
    initPushNotification();
    

  }

  //Function to handle received message
  void handleMessage(RemoteMessage? message) {
    // if the message is null
    if (message == null) return;

    //navigate to new screen when message is received and user tabs notification
    navigatorKey.currentState
        ?.pushNamed('/notification_message', arguments: message);
  }

  //function to initialise background and foreground settings
  Future initPushNotification() async {
    //handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //attach event listenor for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload : ${message.data}');
}