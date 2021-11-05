import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/views/otpScreen.dart';

class OtpBloc {
  late String error;
  final _stateStreamController = StreamController<String>();
  StreamSink<String> get otpSink => _stateStreamController.sink;
  Stream<String> get otpStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<String>();
  StreamSink<String> get eventSink => _eventStreamController.sink;
  Stream<String> get eventStream => _eventStreamController.stream;
  OtpBloc() {
    error = "";
    eventStream.listen((event) {
      if (event == "11111") {
        error = "";
        // Navigator.of(context).pushReplacement(context, MaterialPageRoute(builder: (context) {
        //   return otpScreen(
        //     mob: event,
        //   );
        // }));
      } else {
        error = "Invalid otp. Plz Check";
      }
      otpSink.add(error);
    });
  }
}
