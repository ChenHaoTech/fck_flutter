/// logger 扩展
library;

import 'dart:async';

import 'package:logger/logger.dart';

const _level = Level.verbose;
Logger logger = Logger(
  level: _level,
  printer: PrettyPrinter(
      methodCount: 8,
      // Number of method calls to be displayed
      errorMethodCount: 8,
      // Number of method calls if stacktrace is provided
      lineLength: 120,
      // Width of the output
      colors: true,
      // Colorful log messages
      printEmojis: true,
      // Print an emoji for each log message
      printTime: true // Should each log print contain a timestamp
      ),
);

extension LoggerExt on Object {
  LoggerWrapper get log {
    return LoggerWrapper(logger, this.runtimeType.toString());
  }
}

class LoggerWrapper {
  final Logger _logger;
  final String prefix;

  const LoggerWrapper(this._logger, this.prefix);

  static LoggerWrapper build(String prefix) {
    return LoggerWrapper(logger, prefix);
  }

  LoggerWrapper get(String prefix) {
    return LoggerWrapper(_logger, '${this.prefix}.${prefix}');
  }

  bool _shouldDebugLog() {
    return _level.index <= Level.debug.index;
  }

  void dd(FutureOr<String> Function() supplier, [StackTrace? stackTrace]) async {
    if (_shouldDebugLog())
      print("[${DateTime.now()}]👋👋👋[${prefix}]: ${await supplier()} ${() {
        return stackTrace ?? "";
      }()}");
  }

  void d(FutureOr<String> Function() supplier) async {
    if (_shouldDebugLog()) logger.d("[${DateTime.now()}]👋👋👋[${prefix}]: ${await supplier()}");
  }

  void di(String Function() supplier) {
    if (_shouldDebugLog()) print("[${DateTime.now()}]>>> [${prefix}]: ${supplier()}");
  }

  void td(String Function() supplier) {
    if (_shouldDebugLog()) print("[${DateTime.now()}] 还没实现[todo][${prefix}] : ${supplier()}");
  }

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.e(message, error: error, stackTrace: stackTrace);
  }
}

// shake 未完全 要包一层

extension LoggerEx on Logger {
  LoggerWrapper wrap(Object obj, [String? key]) {
    return LoggerWrapper(logger, obj.runtimeType.toString() + (key ?? ""));
  }
}
