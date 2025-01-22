import 'dart:convert';
import 'dart:core';

import 'package:flareline_crm/services/config.dart';
import 'package:http/http.dart' as http;

import '../models/patient.dart';
import '../models/therapist.dart';
import 'data_transformer.dart';

class DataFetcher {
  Future<Map<String, dynamic>> fetchTherapistList() async {
    try {
      final response = await http.get(Uri.parse(Config.therapistListApiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> content = responseData['content'];
        List<Therapist> therapists = content.map((data) {
          return Therapist.fromJson(data);
        }).toList();
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

  Future<Patient> fetchPatientFromApi(int patientId) async {
    //final response = await http.get(Uri.parse(Uri.parse('${Config.patientApiEndpoint}/$patientId') as String));
    //final response = await http.get(Uri.parse("https://cbb131c0f6c44d279f0707cc00198a95.api.mockbin.io/"));
    final response = await http.get(
        Uri.parse("https://a8575ae381874765b3fcb8e10d7a6eb0.api.mockbin.io/"));
    if (response.statusCode == 200) {
      List<dynamic> dataList = json.decode(response.body); // Decode as List
      return Patient.fromJson(dataList[
          0]); // Assuming the first patient in the list is the one you need
    } else {
      throw Exception('Failed to load patient with ID: $patientId');
      print("error loading data Abrahem");
    }
  }

  Future<List<Map<String, dynamic>>> fetchSuggestions(String query) async {
    const url =
        'https://52f2e35c597d4470bfabca9e3adbb526.api.mockbin.io/'; // Replace with your API URL
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (decodedData['searchResult'] is List) {
          final results =
              List<Map<String, dynamic>>.from(decodedData['searchResult']);
          // Filter suggestions based on the user's query
          return results
              .where((result) =>
                  result['name'].toLowerCase().contains(query.toLowerCase()))
              .toList();
        } else {
          throw Exception("Invalid data format");
        }
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  Future<List<Patient>> fetchPatientsListFromApi(String URL) async {
    final response = await http.get(Uri.parse(URL));

    if (response.statusCode == 200) {
      // Decode the JSON response
      final Map<String, dynamic> data = json.decode(response.body);

      // Extract the list of patients from "content"
      final List<dynamic> patientsJson = data['content'];

      // Map JSON to a list of Patient objects
      return patientsJson.map((json) => Patient.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load patients: ${response.statusCode}');
    }
  }
}
