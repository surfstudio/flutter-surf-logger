// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:surf_logger/src/log_strategy.dart';
import 'package:surf_logger/src/log_writer.dart';

/// Class for instantiating logger.
///
/// WARNING! Do not use this class directly for logging.
///
/// This class provides a way to log messages, exceptions, and warnings using a set of
/// log strategies. To use this class, you should create an instance of it with a set of
/// log strategies, and then call the `log`, `e`, and `w` methods to log messages, exceptions,
/// and warnings, respectively.
class Logger implements LogWriter {
  final Set<LogStrategy> _strategies;

  /// Initialize logger with strategies.
  Logger.withStrategies(this._strategies);

  /// Initialize logger without strategies.
  Logger.empty() : _strategies = <LogStrategy>{};

  @override
  void e(Object exception, [StackTrace? stackTrace]) {
    forEach((strategy) => strategy.e(exception, stackTrace));
  }

  @override
  void log(Object message) {
    forEach((strategy) => strategy.log(message));
  }

  @override
  void w(String message, [Exception? exception]) {
    forEach((strategy) => strategy.w(message, exception));
  }

  /// Add strategy to logger.
  void addStrategy(LogStrategy strategy) {
    _strategies.add(strategy);
  }

  /// Remove strategy from logger.
  void removeStrategy(LogStrategy strategy) {
    _strategies.remove(strategy);
  }

  /// Remove all strategies from logger.
  void clearStrategies() {
    _strategies.clear();
  }

  /// Iterate over all strategies.
  void forEach(void Function(LogStrategy strategy) action) {
    _strategies.forEach(action);
  }

  /// Check if a strategy is contained in the logger.
  bool contains(LogStrategy strategy) {
    return _strategies.contains(strategy);
  }
}
