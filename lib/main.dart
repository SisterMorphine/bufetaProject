import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/cat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Cat Viewer 🐱',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const CatScreen(),
    );
  }
}

class CatScreen extends StatefulWidget {
  const CatScreen({super.key});

  @override
  State<CatScreen> createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  late Future<Cat> futureCat;

  @override
  void initState() {
    super.initState();
    futureCat = fetchNewCat();
  }

  Future<Cat> fetchNewCat() async {
    try {
      final response = await http
          .get(Uri.parse('https://api.thecatapi.com/v1/images/search'));

      if (response.statusCode == 200) {
        Cat cat = Cat.fromJson(json.decode(response.body)[0]);

        return cat;
      } else {
        throw Exception('Failed to load cat');
      }
    } catch (e) {
      print('Error fetching cat 😿: $e');
      return Cat(catId: 'error', imageUrl: null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Cat Viewer 🐱'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
                child: FutureBuilder<Cat>(
              future: futureCat,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error loading cat 😿');
                } else if (snapshot.hasData) {
                  final cat = snapshot.data!;
                  if (cat.imageUrl != null) {
                    return Image.network(
                      cat.imageUrl!,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const CircularProgressIndicator();
                      },
                    );
                  } else {
                    return const Text('No cat loaded yet 🐾');
                  }
                } else {
                  return const Text('No cat loaded yet 🐾');
                }
              },
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    futureCat = fetchNewCat();
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'Load New Cat 😺',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
