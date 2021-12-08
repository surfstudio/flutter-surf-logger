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
  group(
    'Logger:',
    () {
      const debug = 'debug';
      const warning = 'warning';
      const error = 'error';

      late DebugLogStrategyMock debugStrategy;
      late RemoteLogStrategyMock remoteStrategy;

      setUp(
        () {
          debugStrategy = DebugLogStrategyMock();
          remoteStrategy = RemoteLogStrategyMock();
        },
      );

      test(
        'Works correctly with DebugLogStrategy',
        () {
          Logger.addStrategy(debugStrategy);

          Logger.d(debug);
          verify(() => debugStrategy.log(debug, priorityLogDebug)).called(1);

          Logger.w(warning);
          verify(() => debugStrategy.log(warning, priorityLogWarn)).called(1);

          Logger.e(error);
          verify(() => debugStrategy.log(error, priorityLogError)).called(1);

          Logger.removeStrategy(debugStrategy);

          Logger.d(debug);
          verifyNever(() => debugStrategy.log(debug, priorityLogDebug));

          Logger.w(warning);
          verifyNever(() => debugStrategy.log(warning, priorityLogWarn));

          Logger.e(error);
          verifyNever(() => debugStrategy.log(error, priorityLogError));
        },
      );

      test(
        'Works correctly with RemoteLogStrategy',
        () {
          Logger.addStrategy(remoteStrategy);

          Logger.d(debug);
          verify(() => remoteStrategy.log(debug, priorityLogDebug)).called(1);

          Logger.w(warning);
          verify(() => remoteStrategy.log(warning, priorityLogWarn)).called(1);

          Logger.e(error);
          verify(() => remoteStrategy.log(error, priorityLogError)).called(1);

          Logger.removeStrategy(remoteStrategy);

          Logger.d(debug);
          verifyNever(() => remoteStrategy.log(debug, priorityLogDebug));

          Logger.w(warning);
          verifyNever(() => remoteStrategy.log(warning, priorityLogWarn));

          Logger.e(error);
          verifyNever(() => remoteStrategy.log(error, priorityLogError));
        },
      );

      test(
        'Works correctly with both strategies',
        () {
          Logger.addStrategy(debugStrategy);
          Logger.addStrategy(remoteStrategy);

          Logger.d(debug);
          verify(() => remoteStrategy.log(debug, priorityLogDebug)).called(1);
          verify(() => debugStrategy.log(debug, priorityLogDebug)).called(1);

          Logger.removeStrategy(debugStrategy);

          Logger.d(debug);
          verify(() => remoteStrategy.log(debug, priorityLogDebug)).called(1);
          verifyNever(() => debugStrategy.log(debug, priorityLogDebug));

          Logger.removeStrategy(remoteStrategy);

          Logger.d(debug);
          verifyNever(() => remoteStrategy.log(debug, priorityLogDebug));
          verifyNever(() => debugStrategy.log(debug, priorityLogDebug));
        },
      );

      test(
        'Works correctly with both strategies when passing exceptions',
        () {
          Logger.addStrategy(debugStrategy);
          Logger.addStrategy(remoteStrategy);

          final exception = Exception('exception');

          Logger.d(debug, exception);
          verify(() => debugStrategy.log(debug, priorityLogDebug, exception))
              .called(1);
          verify(() => remoteStrategy.log(debug, priorityLogDebug, exception))
              .called(1);
        },
      );
    },
  );
}

class DebugLogStrategyMock extends Mock implements DebugLogStrategy {}

class RemoteLogStrategyMock extends Mock implements RemoteLogStrategy {}
