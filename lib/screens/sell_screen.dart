import 'package:amazonclone/provider/user_detail_provider.dart';
import 'package:amazonclone/resources/cloude_firestore_meathod.dart';
import 'package:amazonclone/utlis/color_theme.dart';
import 'package:amazonclone/utlis/utlis.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/text_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLodaing = false;
  int selected = 1;
  Uint8List? image;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController costcontroller = TextEditingController();
  List<int> keysForDiscount = [0, 70, 60, 50];
  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    costcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size secreensize = Utlis().getScreenSize();
    return SafeArea(
        child: Scaffold(
            body: !isLodaing
                ? SingleChildScrollView(
                    child: SizedBox(
                      height: secreensize.height,
                      width: secreensize.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  image == null
                                      ? Image.network(
                                          'https://media.istockphoto.com/id/522855255/vector/male-profile-flat-blue-simple-icon-with-long-shadow.jpg?s=612x612&w=0&k=20&c=EQa9pV1fZEGfGCW_aEK5X_Gyob8YuRcOYCYZeuBzztM=',
                                          height: secreensize.height / 10,
                                        )
                                      : Image.memory(
                                          image!,
                                          height: secreensize.height / 10,
                                        ),
                                  IconButton(
                                      onPressed: () async {
                                        Uint8List? temp =
                                            await Utlis().pickImage();
                                        if (temp != null) {
                                          setState(() {
                                            image = temp;
                                          });
                                        }
                                      },
                                      icon: const Icon(Icons.file_upload))
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 13),
                                height: secreensize.height * .7,
                                width: secreensize.width * .7,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextFiledWidget(
                                        title: "Enter The Name of Item",
                                        controller: namecontroller,
                                        obsecuretext: false,
                                        hintText: "Item Name"),
                                    TextFiledWidget(
                                        title: "Enter The Cost of Item",
                                        controller: costcontroller,
                                        obsecuretext: false,
                                        hintText: "Item Cost"),
                                    const Text(
                                      "Discount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    ListTile(
                                      title: const Text('None'),
                                      leading: Radio(
                                        value: 1,
                                        groupValue: selected,
                                        onChanged: (int? i) {
                                          setState(() {
                                            selected = i!;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('70%'),
                                      leading: Radio(
                                        value: 2,
                                        groupValue: selected,
                                        onChanged: (int? i) {
                                          setState(() {
                                            selected = i!;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('60%'),
                                      leading: Radio(
                                        value: 3,
                                        groupValue: selected,
                                        onChanged: (int? i) {
                                          setState(() {
                                            selected = i!;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('50%'),
                                      leading: Radio(
                                        value: 4,
                                        groupValue: selected,
                                        onChanged: (int? i) {
                                          setState(() {
                                            selected = i!;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              CustomMainButton(
                                  color: yellowColor,
                                  isLoading: isLodaing,
                                  onPressed: () async {
                                    String output =
                                        await CloudFirestoreMeathod()
                                            .uploadProductToDatabase(
                                      image: image,
                                      productName: namecontroller.text,
                                      rawCost: costcontroller.text,
                                      discount: keysForDiscount[selected - 1],
                                      sellerName:
                                          Provider.of<UserDetailProvider>(
                                                  context,
                                                  listen: false)
                                              .userDetail
                                              .name,
                                      sellerUid: FirebaseAuth
                                          .instance.currentUser!.uid,
                                    );
                                    if (output == "success") {
                                      Utlis().showSnackBar(
                                          context: context,
                                          content: 'Product Posted');
                                    } else {
                                      Utlis().showSnackBar(
                                          context: context, content: output);
                                    }
                                  },
                                  child: const Text(
                                    'Sell',
                                    style: TextStyle(color: Colors.black),
                                  )),
                              CustomMainButton(
                                  color: Colors.grey,
                                  isLoading: isLodaing,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Back',
                                    style: TextStyle(color: Colors.black),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const CircularProgressIndicator()));
  }
}
