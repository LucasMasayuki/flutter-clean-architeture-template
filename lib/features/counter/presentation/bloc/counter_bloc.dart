import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architeture_template/core/error/cache_failure.dart';
import 'package:flutter_clean_architeture_template/core/error/server_failure.dart';
import 'package:flutter_clean_architeture_template/core/usecase.dart';
import 'package:flutter_clean_architeture_template/features/counter/repositories/counter_repository.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/counter.dart';
import '../../domain/usecases/get_counter.dart';
import '../../domain/usecases/increment_counter.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final GetCounterUseCase getCounterUseCase;
  final IncrementCounterUseCase incrementCounterUseCase;
  final CounterRepository counterRepository;

  CounterBloc({
    required this.getCounterUseCase,
    required this.incrementCounterUseCase,
    required this.counterRepository,
  }) : super(CounterInitialState(counter: Counter(value: 0))) {
    on<GetCounterEvent>(_onGetCounter);
    on<IncrementCounterEvent>(_onCounterDecremented);
  }

  Stream<CounterState> _onGetCounter(
    GetCounterEvent event,
    Emitter<CounterState> emit,
  ) async* {
    yield CounterLoadingState();
    final failureOrCounter = await getCounterUseCase(NoParams());

    yield failureOrCounter.fold(
      (failure) => CounterErrorState(message: mapFailureToMessage(failure)),
      (counter) => CounterLoadedState(counter: counter),
    );
  }

  Stream<CounterState> _onCounterDecremented(
      IncrementCounterEvent event, Emitter<CounterState> emit) async* {
    yield CounterLoadingState();
    final failureOrCounter = await incrementCounterUseCase(NoParams());

    yield failureOrCounter.fold(
      (failure) => CounterErrorState(message: mapFailureToMessage(failure)),
      (counter) => CounterLoadedState(counter: counter),
    );
  }

  String mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'An error occurred on the server';
    } else if (failure is CacheFailure) {
      return 'An error occurred while accessing the local cache';
    }

    return 'Unknown error';
  }
}
