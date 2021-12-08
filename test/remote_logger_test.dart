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
import 'package:surf_logger/surf_logger.dart';
import 'package:test/test.dart';

class RemoteUserLogStrategyMock extends Mock implements RemoteUserLogStrategy {}

void main() {
  group(
    'RemoteLogger:',
    () {
      const userId = '0';
      const username = 'test';
      const email = 'test@example.com';

      late RemoteUserLogStrategyMock strategyMock;

      setUp(() {
        strategyMock = RemoteUserLogStrategyMock();

        RemoteLogger.addStrategy(strategyMock);
      });

      test(
        "Method setUser calls strategy's setUser method with correctly "
        'parameters and do not call if the strategy is removed',
        () {
          RemoteLogger.setUser(userId, username, email);
          verify(() => strategyMock.setUser(userId, username, email)).called(1);

          RemoteLogger.removeStrategy(strategyMock);
          RemoteLogger.setUser(userId, username, email);
          verifyNever(() => strategyMock.setUser(userId, username, email));
        },
      );

      test(
        "Method clearUser calls strategy's clearUser method with correctly "
        'parameters and do not call if the strategy is removed',
        () {
          RemoteLogger.clearUser();
          verify(() => strategyMock.clearUser()).called(1);

          RemoteLogger.removeStrategy(strategyMock);
          RemoteLogger.clearUser();
          verifyNever(() => strategyMock.clearUser());
        },
      );

      test(
        'Methods log, logError, logInfo calls the correct methods of the strategy '
        'and do not calls if the strategy is removed',
        () {
          const message = 'Howdy';
          final exception = Exception('exception');
          const key = 'key';
          const info = {'wow': 'wow'};

          RemoteLogger.log(message);
          verify(() => strategyMock.log(message)).called(1);

          RemoteLogger.logError(exception);
          verify(() => strategyMock.logError(exception)).called(1);

          RemoteLogger.logInfo(key, info);
          verify(() => strategyMock.logInfo('key', info)).called(1);

          RemoteLogger.removeStrategy(strategyMock);

          RemoteLogger.log(message);
          verifyNever(() => strategyMock.log(message));
          RemoteLogger.logError(exception);
          verifyNever(() => strategyMock.logError(exception));
          RemoteLogger.logInfo(key, info);
          verifyNever(() => strategyMock.logInfo(key, 'info'));
        },
      );

      test(
        'add method should set old value to new value',
        () {
          final secondStrategyMock = RemoteUserLogStrategyMock();
          const message = 'message';
          RemoteLogger.addStrategy(secondStrategyMock);

          RemoteLogger.log(message);
          verify(() => secondStrategyMock.log(message));

          // This method should remove both strategies.
          RemoteLogger.removeStrategy(strategyMock);

          RemoteLogger.log(message);
          verifyNever(() => secondStrategyMock.log(message));
        },
      );
    },
  );
}
