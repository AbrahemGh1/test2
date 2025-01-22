import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TypeAheadField<Map<String, dynamic>>(
        onSelected: (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You selected: ${value['name']}')),
          );
        },
        builder: (context, controller, focusNode) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(
              hintText: 'ابحث',
              border: OutlineInputBorder(),
            ),
          );
        },
        suggestionsCallback: (query) async {
          if (query.isEmpty) return [];
          return await fetchSuggestions(query);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion['name']),
            subtitle: Text('Result Type: ${suggestion['result-type']}'),
          );
        },
        emptyBuilder: (context) => const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('No suggestions found'),
        ),
        errorBuilder: (context, error) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Error: $error'),
        ),
      ),
    );
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
}
