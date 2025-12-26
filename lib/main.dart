import 'package:catproject/repository/cats_repository.dart';
import 'package:catproject/repository/service/cats_service.dart';
import 'package:flutter/material.dart';
import 'repository/models/cat.dart';

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
  late final CatsRepository catsRepository;

  @override
  void initState() {
    super.initState();
    catsRepository = CatsRepository(CatsService());
    futureCat = catsRepository.fetchNewCat();
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
                    futureCat = catsRepository.fetchNewCat();
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
