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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String mob = "";
  String error = "";
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
      lowerBound: 0,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
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
    mobileBloc.dispose();
    super.dispose();
  }

  final mobileBloc = MobileBloc();
  TextEditingController mobileController = TextEditingController();
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
                  Heading(size: 40, text: "Login Page")
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).size.height / 5) +
                      100 -
                      (animation.value * 100),
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
                          "assets/mob.jpg",
                          height: 150,
                          width: 150,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Enter Your Phone Number", //

                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w900),
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
                                controller: mobileController,
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 2),
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
                        colour: Colors.indigo,
                        title: "Send Otp",
                        onPressed: () {
                          mobileBloc.eventSink.add(mob);
                          if (mob.length == 10) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return otpScreen(
                                mob: mob,
                              );
                            }));
                          } else {
                            mobileController.clear();
                          }
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
