import 'dart:convert';

import 'package:flareline_crm/config.dart';
import 'package:flareline_crm/helper/therapist.dart';
import 'package:http/http.dart' as http;

import 'data_transformer.dart';

class DataFetcher {
  final String url =
      Config.therapistListApiUrl; // Replace this with the actual URL

  // Fetch data from the API
  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON response into a map
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Extract the 'content' array
        List<dynamic> content = responseData['content'];

        // Convert the raw JSON data into a list of Therapist objects
        List<Therapist> therapists = content.map((data) {
          return Therapist.fromJson(data);
        }).toList();

        // Transform the data into the desired format
        DataTransformer dataTransformer = DataTransformer();
        Map<String, dynamic> transformedData =
            dataTransformer.transformData(therapists);

        return transformedData;
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
}
