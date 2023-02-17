import 'package:flutter/material.dart';

class TextFiledWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool obsecuretext;
  final String hintText;
  const TextFiledWidget(
      {super.key,
      required this.title,
      required this.controller,
      required this.obsecuretext,
      required this.hintText});

  @override
  State<TextFiledWidget> createState() => _TextFiledWidgetState();
}

class _TextFiledWidgetState extends State<TextFiledWidget> {
  late FocusNode focusnode;
  bool isinFocus = false;
  @override
  void initState() {
    super.initState();
    focusnode = FocusNode();
    focusnode.addListener(() {
      if (focusnode.hasFocus) {
        setState(() {
          isinFocus = true;
        });
      } else {
        setState(() {
          isinFocus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            isinFocus
                ? BoxShadow(
                    blurRadius: 8,
                    color: Colors.orange.withOpacity(0.4),
                    spreadRadius: 2)
                : BoxShadow(
                    blurRadius: 8,
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2)
          ]),
          child: TextField(
            controller: widget.controller,
            focusNode: focusnode,
            obscureText: widget.obsecuretext,
            maxLines: 1,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: widget.hintText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.grey, width: 1)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 1))),
          ),
        ),
      ],
    );
  }
}
