import 'dart:async';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_tts/flutter_tts.dart';

import 'i_text_to_speech.dart';

/// An implementation of `ITextToSpeech` using `flutter_tts` package.
class TextToSpeech implements ITextToSpeech {
  final _tts = FlutterTts();
  bool _isPlaying = false;
  void Function()? _onCompleted;

  /// Whether text is currently being spoken.
  @override
  bool get isPlaying => _isPlaying;

  /// Constructs an implementation of `ITextToSpeech` using `flutter_tts` package.
  TextToSpeech() {
    _tts.setStartHandler(() => _isPlaying = true);
    _tts.setCompletionHandler(() {
      _isPlaying = false;
      _onCompleted?.call();
    });
    _tts.setErrorHandler((_) => _isPlaying = false);
  }

  /// Speaks a given text.
  ///
  /// Returns `true` if the tts engine successfully began speaking the given text, `false` otherwise.
  /// `onCompleted` is an optional callback invoked once speaking is completed.
  Future<bool> speak(String text, {void Function()? onCompleted}) async {
    if (text.isNotEmpty) {
      final result = await _tts.speak(text);
      if (result == 1) {
        _isPlaying = true;
        _onCompleted = onCompleted;
        return true;
      }
    }
    return false;
  }

  /// Stops the current text being spoken.
  ///
  /// Returns `true` if the tts engine was successfully stopped, `false` otherwise.
  Future<bool> stop() async {
    final result = await _tts.stop();
    final success = result == 1;
    if (success) {
      _isPlaying = false;
    }
    return success;
  }

  /// Sets the playback language
  Future<bool> setLanguage(String language) async {
    if (await (_tts.isLanguageAvailable(language) as FutureOr<bool>)) {
      final result = await _tts.setLanguage(language);
      return result == 1;
    } else {
      debugPrint('Language $language is not supported.');
    }
    return false;
  }
}
