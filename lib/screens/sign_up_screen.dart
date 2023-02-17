import 'dart:developer';

import 'package:amazonclone/models/user_detail_model.dart';
import 'package:amazonclone/resources/authentication_meathod.dart';
import 'package:amazonclone/resources/cloude_firestore_meathod.dart';
import 'package:amazonclone/screens/sign_in_screen.dart';
import 'package:amazonclone/utlis/color_theme.dart';
import 'package:amazonclone/utlis/constant.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/text_filed.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  AuthenticationMeathods authenticationMeathods = AuthenticationMeathods();
  CloudFirestoreMeathod cloudFirestoreMeathod = CloudFirestoreMeathod();
  bool isloading = false;

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    addresscontroller.dispose();
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
                  SizedBox(
                    height: screensize.height * 0.7,
                    child: FittedBox(
                      child: Container(
                          padding: const EdgeInsets.all(25),
                          height: screensize.height * 0.87,
                          width: screensize.width * 0.9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sign-Up',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                              TextFiledWidget(
                                title: 'Name',
                                obsecuretext: false,
                                controller: namecontroller,
                                hintText: 'Enter Your Name...',
                              ),
                              TextFiledWidget(
                                title: 'Address',
                                obsecuretext: false,
                                controller: addresscontroller,
                                hintText: 'Enter Your Address...',
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
                                          await authenticationMeathods
                                              .signUpUser(
                                                  name: namecontroller.text,
                                                  address:
                                                      addresscontroller.text,
                                                  email: emailcontroller.text,
                                                  password:
                                                      passwordcontroller.text);
                                      UserDetailModels user = UserDetailModels(
                                          name: namecontroller.text,
                                          address: addresscontroller.text);
                                      await cloudFirestoreMeathod
                                          .uploadNameAndAddressToDatabase(
                                              user: user);
                                      setState(() {
                                        isloading = false;
                                      });
                                      if (output == "success") {
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignInScreen(),
                                            ));
                                        log('doing next step');
                                        // function
                                      } else {
                                        // error feedback
                                        Utlis().showSnackBar(
                                            context: context, content: output);
                                      }
                                    },
                                    child: const Text('SignUp')),
                              )
                            ],
                          )),
                    ),
                  ),
                  CustomMainButton(
                      color: Colors.grey,
                      isLoading: false,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ));
                      },
                      child: const Text(
                        'Back',
                        style:
                            TextStyle(color: Colors.black, letterSpacing: 0.3),
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
