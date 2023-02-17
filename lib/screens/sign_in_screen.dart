import 'package:amazonclone/resources/authentication_meathod.dart';

import 'package:amazonclone/screens/sign_up_screen.dart';
import 'package:amazonclone/utlis/color_theme.dart';
import 'package:amazonclone/utlis/constant.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:flutter/material.dart';

import '../widgets/text_filed.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  AuthenticationMeathods authenticationMeathods = AuthenticationMeathods();
  bool isloading = false;
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = Utlis().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screensize.height,
          width: screensize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    amazonLogo,
                    height: screensize.height * 0.10,
                  ),
                  Container(
                      padding: const EdgeInsets.all(25),
                      height: screensize.height * 0.6,
                      width: screensize.width * 0.8,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Sign-In',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                          TextFiledWidget(
                            title: 'Email',
                            obsecuretext: false,
                            controller: emailcontroller,
                            hintText: 'Enter Your Email...',
                          ),
                          TextFiledWidget(
                            title: 'Password',
                            obsecuretext: true,
                            controller: passwordcontroller,
                            hintText: 'Enter Your Password...',
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CustomMainButton(
                                color: yellowColor,
                                isLoading: isloading,
                                onPressed: () async {
                                  setState(() {
                                    isloading = true;
                                  });

                                  String output =
                                      await authenticationMeathods.signInUser(
                                          email: emailcontroller.text,
                                          password: passwordcontroller.text);
                                  setState(() {
                                    isloading = false;
                                  });
                                  if (output == "success") {
                                    // ignore: use_build_context_synchronously
                                    /*  Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen(),
                                        ));
                                        */
                                  } else {
                                    Utlis().showSnackBar(
                                        context: context, content: output);
                                  }
                                },
                                child: const Text('SignIn')),
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'New to Amazon',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomMainButton(
                      color: Colors.grey,
                      isLoading: false,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ));
                      },
                      child: const Text(
                        'Create an Amazon Account',
                        style:
                            TextStyle(color: Colors.black, letterSpacing: 0.1),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
