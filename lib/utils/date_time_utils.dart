import 'package:meta/meta.dart';

/// A collection of helper methods for `DateTime`
abstract class DateTimeUtils {
  /// Returns a `DateTime` for today at midnight in UTC
  static DateTime get todayUtcMidnight {
    final nowUtc = DateTime.now().toUtc();
    return DateTime.utc(nowUtc.year, nowUtc.month, nowUtc.day);
  }

  /// Returns a `DateTime` for a day with `dayDifference` from today at midnight in UTC
  static DateTime computeUtcMidnight({@required int dayDifference}) {
    final utc = DateTime.now().toUtc().add(Duration(days: dayDifference));
    return DateTime.utc(utc.year, utc.month, utc.day);
  }
}
