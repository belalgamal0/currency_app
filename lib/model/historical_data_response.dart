
class HistoricalDataCurrneyModel {
    HistoricalDataCurrneyModel({
        this.query,
        this.data,
    });

    Query query;
    Map<String, Map<String, double>> data;

    factory HistoricalDataCurrneyModel.fromJson(Map<String, dynamic> json) => HistoricalDataCurrneyModel(
        query: Query.fromJson(json["query"]),
        data: Map.from(json["data"]).map((k, v) => MapEntry<String, Map<String, double>>(k, Map.from(v).map((k, v) => MapEntry<String, double>(k, v.toDouble())))),
    );

    Map<String, dynamic> toJson() => {
        "query": query.toJson(),
        "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    };
}

class Query {
    Query({
        this.apikey,
        this.baseCurrency,
        this.dateFrom,
        this.dateTo,
        this.timestamp,
    });

    String apikey;
    String baseCurrency;
    DateTime dateFrom;
    DateTime dateTo;
    int timestamp;

    factory Query.fromJson(Map<String, dynamic> json) => Query(
        apikey: json["apikey"],
        baseCurrency: json["base_currency"],
        dateFrom: DateTime.parse(json["date_from"]),
        dateTo: DateTime.parse(json["date_to"]),
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "apikey": apikey,
        "base_currency": baseCurrency,
        "date_from": "${dateFrom.year.toString().padLeft(4, '0')}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}",
        "date_to": "${dateTo.year.toString().padLeft(4, '0')}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}",
        "timestamp": timestamp,
    };
}
