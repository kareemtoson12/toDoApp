import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:getxtodo/ui/widgets/theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TitleStyleheadingStyle,
        ),
        Container(
          width: double.infinity,
          height: 42,
          padding: const EdgeInsets.only(left: 15),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey)),
          child: Row(
            children: [
              Flexible(
                  child: TextFormField(
                readOnly: widget != null ? true : false,
                style: SubtitleStyle.copyWith(color: Colors.black),
                cursorColor:
                    Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                controller: controller,
                autofocus: false,
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor, width: 0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: context.theme.backgroundColor))),
              )),
              widget ?? Container(),
            ],
          ),
        ),
      ],
    );
  }
}
