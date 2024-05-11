import 'package:mockito/annotations.dart';
import 'package:tasks_flutter/app/app.locator.dart';
// @stacked-import

@GenerateMocks([], customMocks: [
// @stacked-mock-spec
])
void registerServices() {
// @stacked-mock-register
}

// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
