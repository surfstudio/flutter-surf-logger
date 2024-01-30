// ignore_for_file: avoid_print

import 'package:surf_logger/src/log_strategy.dart';

/// Simple log strategy for quick start with Surf Logger.
class SimpleLogStrategy implements LogStrategy {
  @override
  void e(Object exception, [StackTrace? stackTrace]) {
    print('Exception: $exception \n StackTrace: $stackTrace');
  }

  @override
  void log(Object message) {
    print('Message: $message');
  }

  @override
  void w(String message, [Exception? exception, StackTrace? stackTrace]) {
    print('Warning: $message \n Exception: $exception');
  }
}
