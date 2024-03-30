import 'mini_platform_interface.dart';

class Mini {
  static toPreviousApp() async {
    try {
      await MiniPlatform.instance.toPreviousApp();
    } catch (_) {}
  }
}
