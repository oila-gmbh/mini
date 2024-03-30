import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mini_method_channel.dart';

abstract class MiniPlatform extends PlatformInterface {
  /// Constructs a MiniPlatform.
  MiniPlatform() : super(token: _token);

  static final Object _token = Object();

  static MiniPlatform _instance = MethodChannelMini();

  /// The default instance of [MiniPlatform] to use.
  ///
  /// Defaults to [MethodChannelMini].
  static MiniPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MiniPlatform] when
  /// they register themselves.
  static set instance(MiniPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  toPreviousApp() {
    throw UnimplementedError('toPreviousApp() has not been implemented.');
  }
}
