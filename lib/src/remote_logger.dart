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

import 'package:surf_logger/src/remote/strategies/remote_log_user_strategy.dart';

/// Wrapper for logging to a remote server using various strategies.
class RemoteLogger {
  static final _strategies = <Type, RemoteUserLogStrategy>{};

  /// Add user info.
  static void setUser(String id, String username, String email) {
    _forAllStrategies((strategy) => strategy.setUser(id, username, email));
  }

  /// Delete user info.
  static void clearUser() {
    _forAllStrategies((strategy) => strategy.clearUser());
  }

  /// Log message.
  static void log(String message) {
    _forAllStrategies((strategy) => strategy.log(message));
  }

  /// Log error.
  static void logError(Exception error) {
    _forAllStrategies((strategy) => strategy.logError(error));
  }

  /// Log info.
  static void logInfo(String key, Object info) {
    _forAllStrategies((strategy) => strategy.logInfo(key, info));
  }

  /// Add new strategy.
  static void addStrategy(RemoteUserLogStrategy strategy) {
    _strategies[strategy.runtimeType] = strategy;
  }

  /// Remove all strategies.
  static void removeStrategy(RemoteUserLogStrategy strategy) {
    _strategies.remove(strategy.runtimeType);
  }

  static void _forAllStrategies(Function(RemoteUserLogStrategy) action) {
    _strategies.values.forEach(action);
  }
}
