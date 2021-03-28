import 'package:flutter/services.dart' show AssetBundle;

/// A service which determines what item should be showcased on given days
abstract class IItemOfTheDayService {
  /// Initializes the service
  ///
  /// `assetBundle` is an AssetBundle (i.e. rootBundle) from which the json asset can be loaded
  Future<void> init({required AssetBundle assetBundle});

  /// Returns the id of the item of the day for today
  String? get today;
}
