class PrintUtils {
  static const bool _isDebug = true;

  static void printLog(String message) {
    _print(message, _isDebug);
  }

  static void _print(String message, bool isDebug) {
    if (isDebug) {
      print('debug -> $message');
    }
  }
}
