import 'package:catproject/repository/cats_repository.dart';
import 'package:catproject/ui/home/pages/bloc/random_cat_event.dart';
import 'package:catproject/ui/home/pages/bloc/random_cat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomCatBloc extends Bloc<RandomCatEvent, RandomCatState> {
  RandomCatBloc({required this.catRepository}) : super(RandomCatState()) {
    on<RandomCatEvent>((event, emit) => _mapSearchEventToState(event, emit));
  }

  final CatsRepository catRepository;
  void _mapSearchEventToState(
      RandomCatEvent event, Emitter<RandomCatState> emit) async {
    try {
      emit(state.copyWith(status: RandomCatStatus.loading));
      final cat = await catRepository.fetchNewCat();
      emit(state.copyWith(cat: cat, status: RandomCatStatus.success));
    } catch (_) {
      emit(state.copyWith(status: RandomCatStatus.failure));
    }
  }
}
