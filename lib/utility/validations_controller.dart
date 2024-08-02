import 'package:flutter/material.dart';

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your full name';
  }
  return null;
}

String? validateEmail(String? value) {
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  } else if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

String? validatePAN(String? value) {
  final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
  if (value == null || value.isEmpty) {
    return 'Please enter PAN number';
  } else if (!panRegex.hasMatch(value)) {
    return 'Please enter a valid PAN number';
  }
  return null;
}

String? validateMobile(String? value) {
  final mobileRegex = RegExp(r'^[6-9]\d{9}$');
  if (value == null || value.isEmpty) {
    return 'Please enter your mobile number';
  } else if (!mobileRegex.hasMatch(value)) {
    return 'Please enter a valid mobile number';
  }
  return null;
}

String? validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your address';
  }
  return null;
}

String? validatePostcode(String? value) {
  final postcodeRegex = RegExp(r'^\d{6}$');
  if (value == null || value.isEmpty) {
    return 'Please enter your postcode';
  } else if (!postcodeRegex.hasMatch(value)) {
    return 'Please enter a valid postcode';
  }
  return null;
}

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController mobileNoController = TextEditingController();
final TextEditingController address1Controller = TextEditingController();
final TextEditingController address2Controller = TextEditingController();
final TextEditingController panController = TextEditingController();
final TextEditingController postCodeController = TextEditingController();
final TextEditingController stateController = TextEditingController();
final TextEditingController cityController = TextEditingController();