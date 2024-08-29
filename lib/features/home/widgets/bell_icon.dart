import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:nfc3_overload_oblivion/common/global/app_pallete.dart';

class NotificationToggleButton extends StatefulWidget {
  @override
  _NotificationToggleButtonState createState() =>
      _NotificationToggleButtonState();
}

class _NotificationToggleButtonState extends State<NotificationToggleButton> {
  // Track the state of the notification (on/off)
  bool _isNotificationActive = true;

  @override
  Widget build(BuildContext context) {
    return FlutterFlowIconButton(
      borderRadius: 20,
      borderWidth: 1,
      buttonSize: 40,
      icon: Icon(
        _isNotificationActive
            ? Icons.notifications_active
            : Icons.notifications_off,
        color: AppPallete.primaryText,
        size: 24,
      ),
      onPressed: () {
        setState(() {
          // Toggle the state of the notification
          _isNotificationActive = !_isNotificationActive;
        });
      },
    );
  }
}
