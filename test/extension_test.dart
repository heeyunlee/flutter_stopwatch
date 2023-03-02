import 'package:flutter_stopwatch/extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Duration Extension:', () {
    group('`formattedMilliseconds` method for', () {
      test('1 milliseconds', () {
        final actual = const Duration(milliseconds: 1).formattedMilliseconds;
        expect(actual, '00');
      });

      test('10 milliseconds', () {
        final actual = const Duration(milliseconds: 10).formattedMilliseconds;
        expect(actual, '01');
      });

      test('100 milliseconds', () {
        final actual = const Duration(milliseconds: 100).formattedMilliseconds;
        expect(actual, '10');
      });

      test('1000 milliseconds', () {
        final actual = const Duration(milliseconds: 1000).formattedMilliseconds;
        expect(actual, '00');
      });

      test('10000 milliseconds', () {
        final actual =
            const Duration(milliseconds: 10000).formattedMilliseconds;
        expect(actual, '00');
      });
    });

    group('`formattedSeconds` method for', () {
      test('100 milliseconds', () {
        final actual = const Duration(milliseconds: 100).formattedSeconds;
        expect(actual, '00');
      });
      test('1 seconds', () {
        final actual = const Duration(seconds: 1).formattedSeconds;
        expect(actual, '01');
      });

      test('10 seconds', () {
        final actual = const Duration(seconds: 10).formattedSeconds;
        expect(actual, '10');
      });

      test('100 seconds', () {
        final actual = const Duration(seconds: 100).formattedSeconds;
        expect(actual, '40');
      });

      test('1000 seconds', () {
        final actual = const Duration(seconds: 1000).formattedSeconds;
        expect(actual, '40');
      });
    });

    group('`formattedMinutes` method for', () {
      test('10 seconds', () {
        final actual = const Duration(seconds: 10).formattedMinutes;
        expect(actual, '00');
      });

      test('1 minute', () {
        final actual = const Duration(minutes: 1).formattedMinutes;
        expect(actual, '01');
      });

      test('10 minutes', () {
        final actual = const Duration(minutes: 10).formattedMinutes;
        expect(actual, '10');
      });

      test('100 minutes', () {
        final actual = const Duration(minutes: 100).formattedMinutes;
        expect(actual, '40');
      });

      test('1000 minutes', () {
        final actual = const Duration(minutes: 1000).formattedMinutes;
        expect(actual, '40');
      });
    });
  });
}
