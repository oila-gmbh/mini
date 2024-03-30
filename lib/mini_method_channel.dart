import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mini_platform_interface.dart';

/// An implementation of [MiniPlatform] that uses method channels.
class MethodChannelMini extends MiniPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mini');

  @override
  void toPreviousApp() async {
    await methodChannel.invokeMethod<String>('toPreviousApp');
  }
}
