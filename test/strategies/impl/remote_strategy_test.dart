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

import 'package:mocktail/mocktail.dart';
import 'package:surf_logger/src/const.dart';
import 'package:surf_logger/surf_logger.dart';
import 'package:test/test.dart';

void main() {
  group('RemoteLogStrategy:', () {
    const message = 'test message';

    late RemoteLogStrategy strategy;
    late RemoteUserLogStrategyMock userStrategyMock;

    setUp(() {
      strategy = RemoteLogStrategy();
      userStrategyMock = RemoteUserLogStrategyMock();

      RemoteLogger.addStrategy(userStrategyMock);
    });

    test(
      'Cal method log with 3rd (highest) priority must call or not call correct '
      'method of the strategy',
      () {
        strategy.log(message, priorityLogError);
        verify(() => userStrategyMock.log(message)).called(1);

        // Method should not be called because the strategy was removed from RemoteLogger.
        RemoteLogger.removeStrategy(userStrategyMock);
        strategy.log(message, priorityLogError);
        verifyNever(() => userStrategyMock.log(message));
      },
    );

    test(
      'Cal method log with 2nd (medium) priority must call or not call correct '
      'method of the strategy',
      () {
        strategy.log(message, priorityLogWarn);
        verify(() => userStrategyMock.log(message)).called(1);

        // Method should not be called because the strategy was removed from RemoteLogger.
        RemoteLogger.removeStrategy(userStrategyMock);
        strategy.log(message, priorityLogWarn);
        verifyNever(() => userStrategyMock.log(message));
      },
    );

    test(
      'When calling the method log with 1nd (lowest) priority, '
      'message should not be logged',
      () {
        strategy.log(message, priorityLogDebug);
        verifyNever(() => userStrategyMock.log(message));

        RemoteLogger.removeStrategy(userStrategyMock);
        strategy.log(message, priorityLogDebug);
        verifyNever(() => userStrategyMock.log(message));
      },
    );

    test('Call method with error must call correct methods', () {
      final error = Exception('some exception');

      strategy.log(message, priorityLogError, error);
      verify(() => userStrategyMock.log(message)).called(1);
      verify(() => userStrategyMock.logError(error)).called(1);

      strategy.log(message, priorityLogWarn, error);
      verify(() => userStrategyMock.log(message)).called(1);
      verify(() => userStrategyMock.logError(error)).called(1);

      // This message shouldn't be logged due to lowest priority.
      strategy.log(message, priorityLogDebug, error);
      verifyNever(() => userStrategyMock.log(message));
      verifyNever(() => userStrategyMock.logError(error));
    });
  });
}

class RemoteUserLogStrategyMock extends Mock implements RemoteUserLogStrategy {}
