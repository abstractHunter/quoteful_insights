import 'package:dio/dio.dart';
import 'package:quoteful_insights/core/errors/exceptions.dart';
import 'package:quoteful_insights/features/quote/data/models/quote_model.dart';

abstract class QuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final Dio dio;

  QuoteRemoteDataSourceImpl({required this.dio});

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await dio.get('https://zenquotes.io/api/random');
    if (response.statusCode == 200) {
      return QuoteModel.fromJson(json: response.data[0]);
    } else {
      throw ServerException();
    }
  }
}
