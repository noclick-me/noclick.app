import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:noclick_me/screenutil_builder.dart';
import 'package:noclick_me/url_form.dart';

void main() {
  // FIXME: Normally we should configure this in flutter_test_config.dart (see
  // https://pub.dev/packages/golden_toolkit#loading-fonts) but there seems to
  // be a bug in Flutter (beta) that is preventing us from use that approach:
  // https://github.com/flutter/flutter/issues/72801
  setUpAll(() async => await loadAppFonts());

  Widget form() => screenutilBuilder(child: Center(child: UrlForm()));

  group('UrlForm', () {
    testGoldens('should adapt to different screens', (tester) async {
      await tester.pumpWidgetBuilder(form());
      await multiScreenGolden(tester, 'url_form-screen', devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletPortrait,
        Device.tabletLandscape,
        const Device(
          name: 'square-400x400',
          size: Size(400, 400),
        ),
      ]);
    });

    testGoldens('should adapt to different text scales', (tester) async {
      await tester.pumpWidgetBuilder(form());
      await multiScreenGolden(tester, 'url_formtext-text_scale', devices: [
        Device.phone,
        Device.phone.copyWith(
          name: 'phone-textscale_0.75x',
          textScale: 0.75,
        ),
        Device.phone.copyWith(
          name: 'phone-textscale_2x',
          textScale: 2.0,
        ),
        Device.phone.copyWith(
          name: 'phone-textscale_3x',
          textScale: 3.0,
        ),
      ]);
    });
  });
}
