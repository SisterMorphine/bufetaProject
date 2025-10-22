import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String? _catImageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchNewCat();
  }

  Future<void> _fetchNewCat() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http
          .get(Uri.parse('https://api.thecatapi.com/v1/images/search'));

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final imageUrl = data[0]['url'];
        setState(() {
          _catImageUrl = imageUrl;
        });
      } else {
        throw Exception('Failed to load cat');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching cat 😿: $e')),
        );
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
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
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : _catImageUrl != null
                      ? Image.network(
                          _catImageUrl!,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const CircularProgressIndicator();
                          },
                        )
                      : const Text('No cat loaded yet 🐾'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _fetchNewCat,
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
