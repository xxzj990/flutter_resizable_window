import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resizable_window/resizable_window.dart';

void main() {
  const MethodChannel channel = MethodChannel('resizable_window');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ResizableWindow.platformVersion, '42');
  });
}
