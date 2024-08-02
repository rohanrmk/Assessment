
import 'package:flutter/material.dart';

richTextWidget(String name) => RichText(
  text: TextSpan(
    text: name,
    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    children: const <TextSpan>[
      TextSpan(text: ' *', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
    ],
  ),
);


Widget wordDifference(String prefixName,String suffixName,BuildContext context)=>Row(
  children: [
    Text(prefixName, style: const TextStyle(fontWeight: FontWeight.w500)),
    Text(suffixName, style: const TextStyle(fontWeight: FontWeight.bold)),
  ],
);