import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../services/data_fetcher.dart';

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
              hintText: 'Search for a suggestion',
              border: OutlineInputBorder(),
            ),
          );
        },
        suggestionsCallback: (query) async {
          if (query.isEmpty) return [];
          return await DataFetcher().fetchSuggestions(query);
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
}
