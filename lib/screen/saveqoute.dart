import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedQuotesScreen extends StatefulWidget {
  @override
  _SavedQuotesScreenState createState() => _SavedQuotesScreenState();
}

class _SavedQuotesScreenState extends State<SavedQuotesScreen> {
  List<String> _savedQuotes = [];

  @override
  void initState() {
    super.initState();
    _loadSavedQuotes();
  }

  void _loadSavedQuotes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedQuotes = prefs.getStringList('savedQuotes') ?? [];
    setState(() {
      _savedQuotes = savedQuotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Quotes'),
      ),
      body: _savedQuotes.isNotEmpty
          ? ListView.builder(
              itemCount: _savedQuotes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_savedQuotes[index]),
                );
              },
            )
          : const Center(
              child: Text('No saved quotes yet.'),
            ),
    );
  }
}
