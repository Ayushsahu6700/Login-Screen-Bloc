import 'package:bloc/components/widgets.dart';
import 'package:bloc/controllers/mobilebloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/constants.dart';
import 'otpScreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mob = "";
  String error = "";
  final mobileBloc = MobileBloc();
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
                      "Login Page",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 50),
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
                          "assets/mob.jpg",
                          height: 150,
                          width: 150,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Enter Your Phone Number", //

                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              "+91",
                              style: TextStyle(
                                  fontSize: 30, color: Colors.black38),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            child: Container(
                              width: 2 * MediaQuery.of(context).size.width / 3,
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                autofocus: false,
                                style: TextStyle(fontSize: 20),
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Mobile Number'),
                                onChanged: (value) {
                                  mob = value.toString();
                                  print(value);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      RoundedButton(
                        colour: Colors.blue,
                        title: "Send Otp",
                        onPressed: () {
                          mobileBloc.eventSink.add(mob);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return otpScreen(
                              mob: mob,
                            );
                          }));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: StreamBuilder(
                            stream: mobileBloc.mobileStream,
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
