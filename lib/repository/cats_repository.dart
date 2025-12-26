import 'package:catproject/repository/service/cats_service.dart';
import 'package:catproject/repository/models/cat.dart';

class CatsRepository {
  const CatsRepository(this.service);

  final CatsService service;

  Future<Cat> fetchNewCat() async => service.fetchNewCat();
}
