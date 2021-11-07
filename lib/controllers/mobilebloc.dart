import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/views/otpScreen.dart';

class MobileBloc {
  late String error;
  final _stateStreamController = StreamController<String>();
  StreamSink<String> get mobileSink => _stateStreamController.sink;
  Stream<String> get mobileStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<String>();
  StreamSink<String> get eventSink => _eventStreamController.sink;
  Stream<String> get eventStream => _eventStreamController.stream;
  MobileBloc() {
    error = "";
    eventStream.listen((event) {
      if (event.length == 10) {
        error = "";
        // Navigator.of(context).pushReplacement(context, MaterialPageRoute(builder: (context) {
        //   return otpScreen(
        //     mob: event,
        //   );
        // }));
      } else {
        error = "Invalid Number. Plz Check";
      }
      mobileSink.add(error);
    });
  }
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
