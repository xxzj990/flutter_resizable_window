
import 'dart:async';

import 'package:flutter/services.dart';

class ResizableWindow {
  static const MethodChannel _channel =
      const MethodChannel('resizable_window');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
