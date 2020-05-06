import 'dart:convert';

import 'package:flutter/services.dart' show AssetBundle;
import 'package:meta/meta.dart';

// ignore: prefer_relative_imports
import 'package:flutter_core_logic/utils/date_time_utils.dart';

import '../models/import_model.dart';
import 'i_item_of_the_day_service.dart';

/// A service which determines what item should be showcased on given days
abstract class BaseItemOfTheDayService implements IItemOfTheDayService {
  /// A path to the json asset
  @protected
  String get jsonAssetPath;

  /// Whether the user's local time or utc should be considered
  @protected
  bool get syncWithLocalTime => true;

  /// Whether the items should be looped when all have already been shown
  @protected
  bool get shouldLoop => false;

  List<String> _order;
  DateTime _startDate;

  bool get _hasValidData => _order != null && _order.isNotEmpty && _startDate != null;
  int get _cycleLength => _order?.length;

  /// Initializes the service
  ///
  /// `assetBundle` is an AssetBundle (i.e. rootBundle) from which the json asset can be loaded
  Future<void> init({@required AssetBundle assetBundle}) async {
    if (assetBundle != null) {
      final data = await assetBundle.loadString(jsonAssetPath);
      final importModel = ImportModel.fromJson(json.decode(data));
      _order = importModel?.order;
      _startDate = importModel?.startDate;
    }
  }

  /// Returns the id of the item of the day for today
  ///
  /// `null` implies that there is no valid item for today
  String get today {
    if (_hasValidData) {
      final todayMidnight = syncWithLocalTime ? DateTimeUtils.todayLocalMidnight : DateTimeUtils.todayUtcMidnight;
      final numberDaysSinceCycleBegan = todayMidnight.difference(_startDate).inDays;
      if (numberDaysSinceCycleBegan >= 0 && (numberDaysSinceCycleBegan < _cycleLength || shouldLoop)) {
        final index = numberDaysSinceCycleBegan % _cycleLength;
        return _order[index];
      }
    }

    return null;
  }
}
