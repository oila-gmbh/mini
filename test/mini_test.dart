import 'package:flutter_test/flutter_test.dart';
import 'package:mini/mini.dart';
import 'package:mini/mini_platform_interface.dart';
import 'package:mini/mini_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMiniPlatform
    with MockPlatformInterfaceMixin
    implements MiniPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MiniPlatform initialPlatform = MiniPlatform.instance;

  test('$MethodChannelMini is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMini>());
  });

  test('getPlatformVersion', () async {
    Mini miniPlugin = Mini();
    MockMiniPlatform fakePlatform = MockMiniPlatform();
    MiniPlatform.instance = fakePlatform;

    expect(await miniPlugin.getPlatformVersion(), '42');
  });
}
