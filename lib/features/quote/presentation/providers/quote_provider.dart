import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quoteful_insights/core/connection/network_info.dart';
import 'package:quoteful_insights/core/errors/failure.dart';
import 'package:quoteful_insights/core/params/params.dart';
import 'package:quoteful_insights/features/quote/business/entities/quote_entity.dart';
import 'package:quoteful_insights/features/quote/business/usecases/get_quote.dart';
import 'package:quoteful_insights/features/quote/data/datasources/quote_local_data_source.dart';
import 'package:quoteful_insights/features/quote/data/datasources/quote_remote_data_source.dart';
import 'package:quoteful_insights/features/quote/data/repositories/quote_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuoteProvider extends ChangeNotifier {
  QuoteEntity? quote;
  Failure? failure;

  QuoteProvider({this.quote, this.failure});

  void eitherFailureOrQuote() async {
    QuoteRepositoryImpl repository = QuoteRepositoryImpl(
        remoteDataSource: QuoteRemoteDataSourceImpl(dio: Dio()),
        localDataSource: QuoteLocalDataSourceImpl(
            sharedPreferences: await SharedPreferences.getInstance()),
        networkInfo: NetworkInfoImpl(DataConnectionChecker()));

    final failureOrQuote = await GetQuote(repository).call(
      params: QuoteParams(),
    );

    failureOrQuote.fold(
      (newFailure) {
        quote = null;
        failure = newFailure;
        notifyListeners();
      },
      (newQuote) {
        quote = newQuote;
        failure = null;
        notifyListeners();
      },
    );
  }
}
