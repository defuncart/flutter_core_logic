/// A text to speech service.
abstract class ITextToSpeech {
  /// Whether text is currently being spoken.
  bool get isPlaying;

  /// Speaks a given text.
  ///
  /// Returns `true` if the tts engine successfully began speaking the given text, `false` otherwise.
  /// `onCompleted` is an optional callback invoked once speaking is completed.
  Future<bool> speak(String text, {void Function() onCompleted});

  /// Stops the current text being spoken.
  ///
  /// Returns `true` if the tts engine was successfully stopped, `false` otherwise.
  Future<bool> stop();

  /// Sets the playback language
  Future<bool> setLanguage(String language);
}
