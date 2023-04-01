import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture_template/core/error/failure.dart';

import '../domain/entities/counter.dart';

abstract class CounterRemoteDataSource {
  Future<Either<Failure, Counter>> getCounter();
}

class CounterRemoteDataSourceImpl implements CounterRemoteDataSource {
  @override
  Future<Either<Failure, Counter>> getCounter() {
    // TODO: Implement getCounter with remote
    return Future.value(Right(Counter(value: 0)));
  }
}
