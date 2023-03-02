extension DurationExtension on Duration {
  /// Returns a stringified and formatted millisecond portion of the duration
  /// that is padded on the left by the length of 2. For example, `Duration(milliseconds: 50)`
  /// should return `05`, and `Duration(seconds: 2, milliseconds: 600)` should
  /// return `60`.
  String get formattedMilliseconds {
    return (inMilliseconds % 1000 / 10).round().toString().padLeft(2, '0');
  }

  /// Returns a stringified and formatted second portion of the duration that is
  /// padded on the left by the length of 2. For example, `Duration(seconds: 4)`
  /// should return `04`, and `Duration(seconds: 44)` should return `44`.
  String get formattedSeconds {
    return (inMilliseconds ~/
            Duration.millisecondsPerSecond %
            Duration.secondsPerMinute)
        .toString()
        .padLeft(2, '0');
  }

  /// Returns a stringified and formatted minute portion of the duration that is
  /// padded on the left by the length of 2. For example, `Duration(minutes: 1)`
  /// should return `01`, and `Duration(seconds: 55)` should return `55`.
  String get formattedMinutes {
    return (inMilliseconds ~/
            Duration.millisecondsPerMinute %
            Duration.minutesPerHour)
        .toString()
        .padLeft(2, '0');
  }
}
