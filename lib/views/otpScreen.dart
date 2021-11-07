import 'package:bloc/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'homePage.dart';
import 'package:bloc/controllers/otpController.dart';
import 'package:show_up_animation/show_up_animation.dart';

class otpScreen extends StatefulWidget {
  String mob;
  otpScreen({required this.mob});
  @override
  _otpScreenState createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen>
    with SingleTickerProviderStateMixin {
  final otpBloc = OtpBloc();
  String pin = "";
  late AnimationController controller;
  late Animation animation;
  late Animation animation2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutBack);
    animation2 = ColorTween(begin: Colors.black, end: Colors.blue[900])
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    otpBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: animation2.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          )),
                      Heading(size: 30, text: "OTP Verification"),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).size.height / 5) +
                      100 -
                      animation.value * 100,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  height: (4 * MediaQuery.of(context).size.height / 5) -
                      100 +
                      animation.value * 100,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          "assets/OTP.jpg",
                          height: 50.0 + animation.value * 200,
                          width: 50.0 + animation.value * 200,
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
                          otpFieldStyle: OtpFieldStyle(
                              backgroundColor: Colors.blue.shade50,
                              enabledBorderColor: Colors.deepPurple,
                              errorBorderColor: Colors.red),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.box,
                          outlineBorderRadius: 25,
                          onChanged: (value) {
                            pin = value.toString();
                          },
                          onCompleted: (value) {
                            otpBloc.eventSink.add(pin);
                          },
                        ),
                      ),
                      RoundedButton(
                        colour: Colors.deepPurpleAccent,
                        title: "Verify Otp",
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
