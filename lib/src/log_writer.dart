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

/// An interface for log writers.
///
/// This interface defines a set of methods for logging messages, exceptions, and warnings.
/// Classes that implement this interface provide the actual logging functionality.
abstract class LogWriter {
  /// Logs a simple message.
  ///
  /// This method is used to log a simple message.
  void log(Object message);

  /// Logs an exception.
  ///
  /// This method is used to log an exception. The optional [stackTrace] parameter
  /// can be used to provide additional information about the exception.
  void e(Object exception, [StackTrace? stackTrace]);

  /// Logs a warning message.
  ///
  /// This method is used to log a warning message. The optional [exception] and [stackTrace]
  /// parameters can be used to provide additional information about the warning.
  void w(String message, [Exception? exception, StackTrace? stackTrace]);
}
