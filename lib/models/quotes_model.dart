class QuotesModel {
  int id;
  String author;
  String quote;

  QuotesModel({
    required this.id,
    required this.author,
    required this.quote,
  });

  factory QuotesModel.fromJson(Map<String, dynamic> json) {
    return QuotesModel(
      id: json["id"],
      author: json["author"],
      quote: json["quote"],
    );
  }
}

class DataModel {
  int limit;
  int skip;
  int total;
  List<QuotesModel> quotes;

  DataModel({
    required this.limit,
    required this.skip,
    required this.total,
    required this.quotes,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    List<QuotesModel> listQuotes = [];
    for (Map<String, dynamic> eachMap in json["quotes"]) {
      var eachQuote = QuotesModel.fromJson(eachMap);
      listQuotes.add(eachQuote);
    }

    return DataModel(
      limit: json["limit"],
      skip: json["skip"],
      total: json["total"],
      quotes: listQuotes,
    );
  }
}
