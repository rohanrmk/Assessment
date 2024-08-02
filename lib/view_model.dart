import 'dart:async';
import 'package:assessment_demo/repository.dart';
import 'package:get/get.dart';
import 'model.dart';





class PostCode extends GetxController {
  var isLoading = true.obs;
  var cities = <City>[].obs;
  var states = <State>[].obs;
  String? cityName;
  String? stateName;

  Future<void> postCodeGenerate(int postNumber) async {

    isLoading.value = true; // Set loading to true when starting the request

    print('Fetching postcode details for: $postNumber');

    await PostcodeRepository.fetchPostcodeDetails(postNumber);

    if (PostcodeRepository.postcodeDetails != null) {
      print('Data fetched successfully');

      // Update the observable lists with the fetched data
      cities.value = PostcodeRepository.postcodeDetails!.city;
      states.value = PostcodeRepository.postcodeDetails!.state;

      // Debug: Print the fetched cities and states
      print('Cities: ${cities.map((city) => city.name).toList()}');
      print('States: ${states.map((state) => state.name).toList()}');

      // Update cityName with the name of the first city, if available
      if (cities.isNotEmpty) {
        cityName = cities.first.name;
        // Print the cityName to the console
        print("City Name: $cityName");
      } else {
        Timer(Duration(seconds: 1), () {
          isLoading.value = false;
        });
        cityName = null; // or some default value
        print('No cities found');
      }

      // Update stateName with the name of the first state, if available
      if (states.isNotEmpty) {
        stateName = states.first.name;
        // Print the stateName to the console
        print("State Name: $stateName");
      } else {
      Timer(Duration(seconds: 1), () {
        isLoading.value = false;
      });
        stateName = null; // or some default value
        print('No states found');
      }
    } else {
      cityName = null;
      stateName = null;
      print('No data returned from repository');

    }

    isLoading.value = false;
  }
}


