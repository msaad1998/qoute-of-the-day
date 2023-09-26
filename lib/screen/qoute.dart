import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share/share.dart';

class QuoteOfTheDayApp extends StatefulWidget {
  @override
  _QuoteOfTheDayAppState createState() => _QuoteOfTheDayAppState();
}

class _QuoteOfTheDayAppState extends State<QuoteOfTheDayApp> {
  String _quote = "Loading...";
  String _author = "Unknown";

  @override
  void initState() {
    super.initState();
    _fetchQuoteOfTheDay();
  }

  Future<void> _fetchQuoteOfTheDay() async {
    final response = await http.get(Uri.parse('https://favqs.com/api/qotd'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _quote = data['quote']['body'];
        final author = data['quote']['author'];
        _author = author != null ? author : "Unknown";
      });
    } else {
      throw Exception('Failed to load quote');
    }
  }

  void _shareQuote() {
    final quoteToShare = '$_quote - $_author';

    Share.share(quoteToShare); // Use Share.share to share the quote
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF5DE0E6),
                  Color(0xFF004AAD),
                ],
              ),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Quote of the Day',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Consolas',
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF5DE0E6),
                Color(0xFF004AAD),
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: 300,
                height: 350,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF004AAd), Color(0xFFcb6ce6)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 30,
                      blurRadius: 50,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 500),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            child: Text(
                              _quote,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "- $_author",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // _quote.length>40? SizedBox(height: 40):SizedBox(height: 80),

                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _quote = "Loading...";
                              });
                              _fetchQuoteOfTheDay();
                            },
                            child: const Text(
                              'Get Another Quote',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              _shareQuote(); // Call _shareQuote when the button is pressed
                            },
                            child: const Text('Share Quote',
                                style: TextStyle(
                                    color: Colors.black)), // Add a share button
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
