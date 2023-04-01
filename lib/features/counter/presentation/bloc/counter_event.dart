import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class GetCounterEvent extends CounterEvent {}

class IncrementCounterEvent extends CounterEvent {}
