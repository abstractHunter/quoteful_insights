class QuoteEntity {
  final String quote;
  final String author;

  const QuoteEntity({
    required this.quote,
    required this.author,
  });

  @override
  String toString() {
    return 'QuoteEntity{quote: $quote, author: $author}';
  }
}
