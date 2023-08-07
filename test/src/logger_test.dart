import 'package:mocktail/mocktail.dart';
import 'package:surf_logger/surf_logger.dart';
import 'package:test/test.dart';

class LogStrategyMock extends Mock implements LogStrategy {}

void main() {
  group('Logger', () {
    group('single strategy', () {
      test('logs a message', () {
      });

      test('logs an exception', () {
      });

      test('logs a warning', () {
      });
    });

    group('different strategies', () {
      test('logs a message for every strategy', () {
      });
    });

    group('strategies', () {
      test('add strategy correctly', () {
      });

      test('remove strategy correctly', () {
      });

      test('clear strategies correctly', () {
      });

      test('can add some strategies with same type', () {
      });
    });
  });
}
