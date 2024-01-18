import 'package:dartz/dartz.dart';
import 'package:quoteful_insights/core/connection/network_info.dart';
import 'package:quoteful_insights/core/errors/exceptions.dart';
import 'package:quoteful_insights/core/errors/failure.dart';
import 'package:quoteful_insights/core/params/params.dart';
import 'package:quoteful_insights/features/quote/business/repositories/quote_repository.dart';
import 'package:quoteful_insights/features/quote/data/datasources/quote_local_data_source.dart';
import 'package:quoteful_insights/features/quote/data/datasources/quote_remote_data_source.dart';
import 'package:quoteful_insights/features/quote/data/models/quote_model.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;
  final QuoteLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  QuoteRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, QuoteModel>> getRandomQuote(
      {required QuoteParams params}) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteQuote = await remoteDataSource.getRandomQuote();
        localDataSource.cacheQuote(remoteQuote);
        return Right(remoteQuote);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'Server Failure'));
      }
    } else {
      try {
        final localQuote = await localDataSource.getLastQuote();
        return Right(localQuote!);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'Cache Failure'));
      }
    }
  }
}
