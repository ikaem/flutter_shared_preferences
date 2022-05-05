import 'dart:async';

class TimerBloc {
  int seconds = 60;
  StreamController _secondsStreamController = StreamController();
  // this is interesting
  // so this ius how we define getter
  Stream get secondsStream =>
      _secondsStreamController.stream.asBroadcastStream();
  // this is also getter
  StreamSink get secondsSink => _secondsStreamController.sink;

  Future decreaseSeconds() async {
    await Future.delayed(const Duration(seconds: 1));
    seconds--;
    secondsSink.add(seconds);
  }

  countDown() async {
    for (int i = seconds; i > 0; i--) {
      await decreaseSeconds();
      returnSeconds(seconds);
    }
  }

  int returnSeconds(int seconds) {
    return seconds;
  }

  void dispose() {
    _secondsStreamController.close();
  }
}
