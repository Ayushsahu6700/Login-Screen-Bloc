import 'package:bloc/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'homePage.dart';
import 'package:bloc/controllers/otpController.dart';

class otpScreen extends StatefulWidget {
  String mob;
  otpScreen({required this.mob});
  @override
  _otpScreenState createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {
  final otpBloc = OtpBloc();
  String pin = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.blue[900],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "OTP Verification",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  height: 4 * MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          "assets/OTP.jpg",
                          height: 250,
                          width: 250,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "OTP Sent on " + (widget.mob),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: OTPTextField(
                          length: 5,
                          width: MediaQuery.of(context).size.width,
                          fieldWidth: 40,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.underline,
                          onChanged: (value) {
                            pin = value.toString();
                          },
                          onCompleted: (value) {
                            print(value);
                          },
                        ),
                      ),
                      RoundedButton(
                        colour: Colors.deepPurpleAccent,
                        title: "Next",
                        onPressed: () {
                          otpBloc.eventSink.add(pin);
                          if (pin == "11111") {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomePage();
                            }));
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: StreamBuilder(
                            stream: otpBloc.otpStream,
                            builder: (context, snapshot) {
                              return Text(
                                  '${snapshot.data == null ? "" : snapshot.data}',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900));
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
