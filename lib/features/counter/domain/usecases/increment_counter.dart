import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase.dart';
import '../../repositories/counter_repository.dart';
import '../entities/counter.dart';

class IncrementCounterUseCase extends UseCase<Counter, NoParams> {
  final CounterRepository repository;

  IncrementCounterUseCase({required this.repository});

  @override
  Future<Either<Failure, Counter>> call(NoParams params) async {
    final counter = await repository.getCounter();
    return counter.fold(
      (failure) => Left(failure),
      (counter) {
        final newCounter = counter.copyWith(value: counter.value + 1);
        return repository.incrementCounter().then((result) => result.fold(
              (failure) => Left(failure),
              (_) => Right(newCounter),
            ));
      },
    );
  }
}
