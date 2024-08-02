// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'model.dart';
//
// class PostcodeRepository {
//   static ModelClass? postcodeDetails;
//   static String? statusMessage;
//   static String? statusCode;
//
//   static fetchPostcodeDetails(int postcode) async {
//     Uri uri = Uri.https('lab.pixel6.co','/api/get-postcode-details.php');
//
//     var data = jsonEncode({
//       'postcode': postcode,
//     });
//
//     try {
//       print(uri);
//       print("--$data");
//
//       var response = await http.post(
//         uri,
//         body: data,
//         headers: {
//           HttpHeaders.contentTypeHeader: 'application/json',
//         },
//       );
//
//       print(response.statusCode);
//       Map<String, dynamic> temp = jsonDecode(utf8.decode(response.bodyBytes));
//       print("--$temp");
//
//       if (response.statusCode == 200) {
//         statusMessage = temp['statusMessage'];
//         statusCode = temp['statusCode'];
//         postcodeDetails = ModelClass.fromJson(temp['responseData']);
//       } else {
//         statusMessage = 'Error: ${response.statusCode}';
//       }
//     } catch (e) {
//       print(e);
//       statusMessage = 'Error occurred while fetching postcode details.';
//     }
//   }
// }






import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'model.dart';

class PostcodeRepository {
  static ModelClass? postcodeDetails;
  static String? statusMessage;
  static String? statusCode;

  static Future<void> fetchPostcodeDetails(int postcode) async {
    Uri uri = Uri.https('lab.pixel6.co', '/api/get-postcode-details.php');

    var data = jsonEncode({
      'postcode': postcode,
    });

    try {
      print('Sending request to: $uri');
      print('Request body: $data');

      var response = await http.post(
        uri,
        body: data,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> temp = jsonDecode(utf8.decode(response.bodyBytes));
        print('Decoded JSON: $temp');

        // Directly map JSON to ModelClass
        postcodeDetails = ModelClass.fromJson(temp);

        print('Postcode details updated');
      } else {
        statusMessage = 'Error: ${response.statusCode}';
        print(statusMessage);
      }
    } catch (e) {
      print('Exception: $e');
      statusMessage = 'Error occurred while fetching postcode details.';
    }
  }
}


