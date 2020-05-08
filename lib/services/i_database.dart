/// A base interface which databases can inherited from
abstract class IDatabase {
  /// Initializes the database
  Future<void> init();

  /// Whether the database has data
  bool get hasData;

  /// The size of the database (i.e. number of entries)
  int get size;

  /// Resets the database
  Future<void> reset();

  /// Prints the database to the console
  void debugPrint();
}
