import 'dart:developer';


import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import 'local_notifications_service.dart';

class FirebaseMessagingService {
  FirebaseMessagingService._internal();

  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();

  factory FirebaseMessagingService.instance() => _instance;

  LocalNotificationsService? _localNotificationsService;

  Future<void> init(
      {required LocalNotificationsService localNotificationsService}) async {
    _localNotificationsService = localNotificationsService;

    // Request user permission for notifications
    await _requestPermission();

    // Set foreground notification presentation options
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle FCM token
    await _handlePushNotificationsToken();

    // Register handler for background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Listen for messages when the app is in foreground
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    // Listen for notification taps when the app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // Check for initial message that opened the app
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _onMessageOpenedApp(initialMessage);
    }
  }

  /// ----------- functions to handle Push Notifications token -----------
  String? taken;

  Future<void> _handlePushNotificationsToken() async {
    try {
      // For iOS, check if we have APNS token first
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        taken = apnsToken ?? '-';
        if (apnsToken == null) {
          log('APNS token not yet available, will retry later');
          // Set up a listener for when the token becomes available
          FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
            taken = fcmToken ?? "-";
            log('FCM token received after APNS token available: $fcmToken');
            // TODO: Send token to your server
          });
          return;
        }
      }

      // If we get here, either we're not on iOS or APNS token is available
      final token = await FirebaseMessaging.instance.getToken();
      taken = token ?? "-";
      log('Push notifications token: $token');

      ///make all users subscribe to this topic allDevices
      subscribeToTopic('allDevices');
      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        log('FCM token refreshed: $fcmToken');
        // TODO: Send token to your server if necessary
      }).onError((error) {
        log('Error refreshing FCM token: $error');
      });
    } catch (e) {
      log('Error getting FCM token: $e');
      // Retry after a delay if needed
      await Future.delayed(const Duration(seconds: 5));
      _handlePushNotificationsToken();
    }
  }

  /// ---------- functions to subscribe to topics and unsubscribe from topics -----------
  Future<void> subscribeToTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
      log('Successfully subscribed to topic: $topic');
    } catch (e) {
      log('Failed to subscribe to topic $topic: $e');
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      log('Unsubscribed from topic: $topic');
    } catch (e) {
      log('Failed to unsubscribe from topic $topic: $e');
    }
  }

  ///  ----------- functions to handle foreground and background messages -----------
  Future<void> _requestPermission() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      if (await DeviceInfoPlugin()
              .androidInfo
              .then((info) => info.version.sdkInt) >=
          33) {
        final status = await Permission.notification.request();
        log('Android notification permission status: $status');
      }
      return;
    }

    // iOS permission handling
    final result = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    log('User granted permission: ${result.authorizationStatus}');
  }

  void _onForegroundMessage(RemoteMessage message) {
    log('Foreground message received: ${message.data}');
    final notificationData = message.notification;
    if (notificationData != null) {
      _localNotificationsService?.showNotification(
        notificationData.title,
        notificationData.body,
        message.data.toString(),
      );
    }
  }

  void _onMessageOpenedApp(RemoteMessage message) {
    log('Notification caused the app to open: ${message.data}');
    // TODO: Handle navigation based on message data
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Background message received: ${message.data}');
}
