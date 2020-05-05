/// A service which determines what item should be showcased on given days
abstract class IItemOfTheDayService {
  /// Initializes the service
  Future<void> init();

  /// Returns the id of the item of the day for today
  String get today;
}
