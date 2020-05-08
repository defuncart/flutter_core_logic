/// A base interface which services can inherited from
abstract class IService {
  /// Initializes the service
  Future<void> init();

  /// Resets the service
  Future<void> reset();

  /// Prints the service to the console
  void debugPrint();
}
