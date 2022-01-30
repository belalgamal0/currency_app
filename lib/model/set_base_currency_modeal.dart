
class SetBaseCurrencyModel {
    SetBaseCurrencyModel({
        this.query,
        this.data,
    });

    Query query;
    Map<String, double> data;

    factory SetBaseCurrencyModel.fromJson(Map<String, dynamic> json) => SetBaseCurrencyModel(
        query: Query.fromJson(json["query"]),
        data: Map.from(json["data"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "query": query.toJson(),
        "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}

class Query {
    Query({
        this.apikey,
        this.baseCurrency,
        this.timestamp,
    });

    String apikey;
    String baseCurrency;
    int timestamp;

    factory Query.fromJson(Map<String, dynamic> json) => Query(
        apikey: json["apikey"],
        baseCurrency: json["base_currency"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "apikey": apikey,
        "base_currency": baseCurrency,
        "timestamp": timestamp,
    };
}
