import 'package:dartz/dartz.dart';

import '../../../core/error/cache_failure.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecase.dart';
import '../data/counter_local_data_source.dart';
import '../data/counter_remote_data_source.dart';
import '../domain/entities/counter.dart';
import '../domain/usecases/increment_counter.dart';

abstract class CounterRepository {
  Future<Either<Failure, Counter>> getCounter();
  Future<Either<Failure, void>> incrementCounter();
}

class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDataSource localDataSource;
  final CounterRemoteDataSource remoteDataSource;

  CounterRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Counter>> getCounter() async {
    try {
      final localCounter = localDataSource.getLastCounter();
      if (localCounter.isRight()) {
        return localCounter;
      }

      final remoteCounter = await remoteDataSource.getCounter();
      if (remoteCounter.isRight()) {
        localDataSource.saveCounter(
          remoteCounter.getOrElse(
            () => throw CacheFailure(message: "Could not get counter"),
          ),
        );
      }

      return remoteCounter;
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Counter>> incrementCounter() async {
    try {
      final result = await IncrementCounterUseCase(repository: this).call(
        NoParams(),
      );

      if (result.isRight()) {
        localDataSource.saveCounter(result.getOrElse(
            () => throw CacheFailure(message: "Could not get counter")));
      }

      return result;
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
