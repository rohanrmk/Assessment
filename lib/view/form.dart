import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../database.dart';
import '../utility/common_widgets.dart';
import '../utility/validations_controller.dart';
import '../view_model.dart';
import 'display_page.dart';

class FormView extends StatefulWidget {
  final int? id;
  final String? name;
  final String? email;
  final String? mobileNo;
  final String? pan;
  final String? address1;
  final String? address2;
  final String? postcode;
  final String? state;
  final String? city;

  const FormView({
    Key? key,
    this.id,
    this.name,
    this.email,
    this.mobileNo,
    this.pan,
    this.address1,
    this.address2,
    this.postcode,
    this.state,
    this.city,
  }) : super(key: key);

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final PostCode postCode = Get.put(PostCode());
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController mobileNoController;
  late TextEditingController panController;
  late TextEditingController address1Controller;
  late TextEditingController address2Controller;
  late TextEditingController postCodeController;
  late TextEditingController stateController;
  late TextEditingController cityController;



  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name??"");
    emailController = TextEditingController(text: widget.email);
    mobileNoController = TextEditingController(text: widget.mobileNo);
    panController = TextEditingController(text: widget.pan);
    address1Controller = TextEditingController(text: widget.address1);
    address2Controller = TextEditingController(text: widget.address2);
    postCodeController = TextEditingController(text: widget.postcode);
    stateController = TextEditingController(text: widget.state);
    cityController = TextEditingController(text: widget.city);


  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileNoController.dispose();
    panController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    postCodeController.dispose();
    stateController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      final row = {
        'name': nameController.text,
        'email': emailController.text,
        'mobileNo': mobileNoController.text,
        'pan': panController.text,
        'address1': address1Controller.text,
        'address2': address2Controller.text,
        'postcode': postCodeController.text,
        'state': stateController.text,
        'city': cityController.text,
      };

      if (widget.id != null) {
        // Update data
        await dbHelper.updateData(widget.id!, row);
        Get.to(DisplayPage());
        nameController.clear();
        emailController.clear();
        mobileNoController.clear();
        panController.clear();
        address1Controller.clear();
        address2Controller.clear();
        postCodeController.clear();
        stateController.clear();
        cityController.clear();
      } else {
        // Insert data
        await dbHelper.insertData(row);
        Get.to(DisplayPage());
        nameController.clear();
        emailController.clear();
        mobileNoController.clear();
        panController.clear();
        address1Controller.clear();
        address2Controller.clear();
        postCodeController.clear();
        stateController.clear();
        cityController.clear();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.id != null ? 'Data updated successfully!' : 'Data stored successfully!')),
      );


    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to store data.')),
      );
    }
  }

  void _checkPostcodeLength(String value) async {
    if (value.length == 6) {
      postCode.isLoading.value = true;
      final postcode = int.parse(value);
      // Fetch postcode details
      await postCode.postCodeGenerate(postcode);
      // Check if city and state names are updated before stopping the loader
      if (postCode.stateName != null && postCode.cityName != null) {
        stateController.text = postCode.stateName!;
        cityController.text = postCode.cityName!;
        postCode.isLoading.value = false; // Stop the loader when data is available
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration form",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/22,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () {
              Get.to(DisplayPage());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full Name
                richTextWidget("Full Name"),
                TextFormField(
                  controller: nameController,
                  validator: validateName,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [LengthLimitingTextInputFormatter(140)],
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Enter Full Name",
                    hintStyle: TextStyle(
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                      fontSize: MediaQuery.of(context).size.height / 65,
                    ),
                    fillColor: const Color(0xffF2F2F2),
                    filled: true,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Email
                richTextWidget("Email"),
                TextFormField(
                  controller: emailController,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  inputFormatters: [LengthLimitingTextInputFormatter(255)],
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter Email",
                      hintStyle: TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                        fontSize: MediaQuery.of(context).size.height / 65,
                      ),
                      fillColor: const Color(0xffF2F2F2),
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
                const SizedBox(height: 10),

                // Mobile No.
                richTextWidget("Mobile No."),
                TextFormField(
                  controller: mobileNoController,
                  validator: validateMobile,
                  keyboardType: TextInputType.number,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 48,
                          left: MediaQuery.of(context).size.width / 25,
                        ),
                        child: Text(
                          "+91",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                            fontSize: MediaQuery.of(context).size.height / 65,
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(5),
                      hintText: "Enter Mobile No.",
                      hintStyle: TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                        fontSize: MediaQuery.of(context).size.height / 65,
                      ),
                      fillColor: const Color(0xffF2F2F2),
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
                const SizedBox(height: 10),

                // PAN Card
                richTextWidget("PAN Card"),
                TextFormField(
                  controller: panController,
                  validator: validatePAN,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter PAN Card No.",
                      hintStyle: TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                        fontSize: MediaQuery.of(context).size.height / 65,
                      ),
                      fillColor: const Color(0xffF2F2F2),
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
                const SizedBox(height: 10),

                // Address
                const Text('Address', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                TextFormField(
                  controller: address1Controller,
                  validator: validateAddress,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Address Line 1 *",
                      hintStyle: TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                        fontSize: MediaQuery.of(context).size.height / 65,
                      ),
                      fillColor: const Color(0xffF2F2F2),
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: address2Controller,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Address Line 2",
                      hintStyle: TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                        fontSize: MediaQuery.of(context).size.height / 65,
                      ),
                      fillColor: const Color(0xffF2F2F2),
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
                const SizedBox(height: 10),

                // Post Code
                richTextWidget("Post Code"),
               Obx(()=> TextFormField(
                  controller: postCodeController,
                  keyboardType: TextInputType.number,
                  onChanged: _checkPostcodeLength,
                  validator: validatePostcode,
                  inputFormatters: [LengthLimitingTextInputFormatter(6)],
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter Postcode",
                      hintStyle: TextStyle(
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                        fontSize: MediaQuery.of(context).size.height / 65,
                      ),
                      fillColor: const Color(0xffF2F2F2),
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    suffix: postCode.isLoading.value?SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator()):SizedBox()
                  ),
                )),
                const SizedBox(height: 10),

                // State
                richTextWidget("State"),
                Obx(() {
                  return TextFormField(
                    controller: stateController,
                    readOnly: true,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: postCode.isLoading.value ? "State" : postCode.stateName!,
                        hintStyle: TextStyle(
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontSize: MediaQuery.of(context).size.height / 65,
                        ),
                        fillColor: const Color(0xffF2F2F2),
                        filled: true,
                        isDense: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  );
                }),
                const SizedBox(height: 10),

                // City
                richTextWidget("City"),
                Obx(() {
                  return TextFormField(
                    controller: cityController,
                    readOnly: true,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: postCode.isLoading.value ? "City" : postCode.cityName!,
                        hintStyle: TextStyle(
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontSize: MediaQuery.of(context).size.height / 65,
                        ),
                        fillColor: const Color(0xffF2F2F2),
                        filled: true,
                        isDense: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  );
                }),
                const SizedBox(height: 10),

                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _submitData();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}