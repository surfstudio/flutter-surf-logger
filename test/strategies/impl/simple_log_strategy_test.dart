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

import 'package:surf_logger/src/simple_log_strategy.dart';
import 'package:test/test.dart';

void main() {
  group('SimpleLogStrategy tests', () {
    late SimpleLogStrategy strategy;

    setUpAll(() {
      strategy = SimpleLogStrategy();
    });

    test('Exception method should print exception and stack trace', () {
      final exception = Exception('Test exception');
      final stackTrace = StackTrace.current;

      expect(
        () => strategy.e(exception, stackTrace),
        prints(
          'Exception: $exception \n StackTrace: $stackTrace\n',
        ),
      );
    });

    test('Log method should print the message', () {
      final message = 'Test log message';

      expect(
        () => strategy.log(message),
        prints('Message: $message\n'),
      );
    });

    test('Warning method should print warning and exception', () {
      final message = 'Test warning message';
      final exception = Exception('Test exception');

      expect(
        () => strategy.w(message, exception),
        prints(
          'Warning: $message \n Exception: $exception\n',
        ),
      );
    });
  });
}
