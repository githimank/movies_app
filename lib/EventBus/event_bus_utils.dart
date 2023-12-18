import 'package:event_bus/event_bus.dart';
import 'EventModels/event_login.dart';

EventBus eventBus = EventBus();

class EventBusUtils {
  static void eventLogin() {
    var event = EventLogin(isLogin: true);
    eventBus.fire(event);
  }
}
