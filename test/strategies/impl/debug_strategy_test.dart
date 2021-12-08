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

import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:surf_logger/src/const.dart';
import 'package:surf_logger/src/strategies/impl/debug_strategy.dart';
import 'package:test/test.dart';

const message = 'simple message';

void main() {
  group('DebugLogStrategy:', () {
    late LoggerMock logger;
    late DebugLogStrategy strategy;

    setUp(
      () {
        logger = LoggerMock();
        strategy = DebugLogStrategy(logger);
      },
    );

    test(
      'Method log calls appropriate logger method',
      () {
        strategy.log(message, priorityLogDebug);
        verify(() => logger.d(message)).called(1);

        strategy.log(message, priorityLogWarn);
        verify(() => logger.w(message)).called(1);

        strategy.log(message, priorityLogError);
        verify(() => logger.e(message)).called(1);

        strategy.log(message, 100500);
        verify(() => logger.d(message)).called(1);
      },
    );

    test(
      'Method log with Exception always calls error logger method',
      () {
        final exception = Exception('simple exception message');

        strategy.log(message, priorityLogDebug, exception);
        verify(() => logger.e(message, exception)).called(1);

        strategy.log(message, priorityLogWarn, exception);
        verify(() => logger.e(message, exception)).called(1);

        strategy.log(message, priorityLogError, exception);
        verify(() => logger.e(message, exception)).called(1);

        strategy.log(message, 100500, exception);
        verify(() => logger.e(message, exception)).called(1);
      },
    );

    test(
      'If you do not pass Logger to strategy, instance will be created normally',
      () {
        strategy = DebugLogStrategy();

        expect(
          () => strategy = DebugLogStrategy(),
          returnsNormally,
        );

        expect(strategy, isNotNull);
      },
    );
  });
}

class LoggerMock extends Mock implements Logger {}
