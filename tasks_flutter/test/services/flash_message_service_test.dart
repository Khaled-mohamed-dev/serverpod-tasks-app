import 'package:flutter_test/flutter_test.dart';
import 'package:tasks_flutter/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('FlashMessageServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
