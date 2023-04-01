import 'package:equatable/equatable.dart';

import '../../domain/entities/counter.dart';

abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

class CounterInitialState extends CounterState {
  final Counter counter;

  CounterInitialState({required this.counter});

  @override
  List<Object> get props => [counter];
}

class CounterLoadingState extends CounterState {
  CounterLoadingState();

  @override
  List<Object> get props => [];
}

class CounterLoadedState extends CounterState {
  final Counter counter;

  const CounterLoadedState({required this.counter});

  @override
  List<Object> get props => [counter];
}

class CounterErrorState extends CounterState {
  final String message;

  const CounterErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
