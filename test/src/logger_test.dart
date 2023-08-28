import 'package:mocktail/mocktail.dart';
import 'package:surf_logger/surf_logger.dart';
import 'package:test/test.dart';

class LogStrategyMock extends Mock implements LogStrategy {}

void main() {
  group('Logger', () {
    late Logger logger;

    setUp(() {
      logger = Logger.empty();
    });

    group('single strategy', () {
      late LogStrategyMock strategyMock;

      setUp(() {
        strategyMock = LogStrategyMock();
        logger.addStrategy(strategyMock);
      });

      test('logs a message', () {
        final message = 'Test log message';
        logger.log(message);

        verify(() => strategyMock.log(message)).called(1);
      });

      test('logs an exception', () {
        final exception = Exception('Test exception');
        final stackTrace = StackTrace.current;

        logger.e(exception, stackTrace);

        verify(() => strategyMock.e(exception, stackTrace)).called(1);
      });

      test('logs a warning', () {
        final message = 'Test warning message';
        final exception = Exception('Test exception');

        logger.w(message, exception);

        verify(() => strategyMock.w(message, exception)).called(1);
      });
    });

    group('different strategies', () {
      late Logger logger;
      late LogStrategyMock strategyMock1;
      late LogStrategyMock strategyMock2;

      setUp(() {
        strategyMock1 = LogStrategyMock();
        strategyMock2 = LogStrategyMock();
        logger = Logger.withStrategies({strategyMock1, strategyMock2});
      });

      test('logs a message for every strategy', () {
        final message = 'Test log message';
        logger.log(message);

        verify(() => strategyMock1.log(message)).called(1);
        verify(() => strategyMock2.log(message)).called(1);
      });
    });

    group('strategies', () {
      late LogStrategyMock strategyMock1;
      late LogStrategyMock strategyMock2;

      setUp(() {
        strategyMock1 = LogStrategyMock();
        strategyMock2 = LogStrategyMock();
      });

      test('add strategy correctly', () {
        logger.addStrategy(strategyMock1);

        expect(logger.contains(strategyMock1), isTrue);
      });

      test('remove strategy correctly', () {
        logger.addStrategy(strategyMock1);
        logger.removeStrategy(strategyMock1);

        expect(logger.contains(strategyMock1), isFalse);
      });

      test('clear strategies correctly', () {
        logger.addStrategy(strategyMock1);
        logger.addStrategy(strategyMock2);
        logger.clearStrategies();

        expect(logger.contains(strategyMock1), isFalse);
        expect(logger.contains(strategyMock2), isFalse);
      });

      test('can add some strategies with same type', () {
        logger.addStrategy(strategyMock1);
        logger.addStrategy(strategyMock2);

        expect(logger.contains(strategyMock1), isTrue);
        expect(logger.contains(strategyMock2), isTrue);
      });
    });
  });
}
