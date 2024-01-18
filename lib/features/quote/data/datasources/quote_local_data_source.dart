import 'dart:convert';

import 'package:quoteful_insights/core/errors/exceptions.dart';
import 'package:quoteful_insights/features/quote/data/models/quote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class QuoteLocalDataSource {
  Future<void>? cacheQuote(QuoteModel? quoteModel);
  Future<QuoteModel?>? getLastQuote();
}

const cachedQuote = 'CACHED_QUOTE';

class QuoteLocalDataSourceImpl implements QuoteLocalDataSource {
  final SharedPreferences sharedPreferences;

  QuoteLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<QuoteModel>? getLastQuote() {
    final jsonString = sharedPreferences.getString(cachedQuote);

    if (jsonString != null) {
      return Future.value(QuoteModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheQuote(QuoteModel? quoteToCache) async {
    if (quoteToCache != null) {
      sharedPreferences.setString(
        cachedQuote,
        json.encode(quoteToCache.toJson()),
      );
    } else {
      throw CacheException();
    }
  }
}
