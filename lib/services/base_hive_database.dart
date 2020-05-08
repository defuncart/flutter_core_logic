import 'package:flutter/foundation.dart' as flutter show debugPrint;
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import 'i_database.dart';

/// A base implementation of IDatabase which can be extended from
abstract class BaseHiveDatabase<T> implements IDatabase {
  /// A box to store objects
  @protected
  Box<T> box;

  /// A name for the box
  @protected
  String get boxName;

  /// Initializes the database
  @override
  Future<void> init() async {
    if (box == null) {
      box = await Hive.openBox<T>(boxName);
    }

    await initialize();
  }

  /// A custom initialize method which subclasses can override
  @protected
  Future<void> initialize() async {}

  /// Whether the database has data
  @override
  bool get hasData => box != null && box.isNotEmpty;

  /// The size of the database (i.e. number of entries)
  int get size => hasData ? box.values.length : 0;

  /// Resets the database
  Future<void> reset() async => await box.deleteAll(box.keys);

  /// Prints the database to the console
  @override
  void debugPrint() {
    if (hasData) {
      box.toMap().forEach((key, value) => flutter.debugPrint('$key: $value'));
    }
  }
}
