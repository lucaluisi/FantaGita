import 'dart:async';

class CustomStreamController {
  final _controller = StreamController<int>.broadcast();

  Stream<int> get stream => _controller.stream;

  void buttonPressed(int buttonId) {
    _controller.sink.add(buttonId);
  }

  void dispose() {
    _controller.close();
  }
}