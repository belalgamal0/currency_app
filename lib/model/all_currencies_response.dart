
class AllCurrenciesResponse {
    AllCurrenciesResponse({
        this.query,
        this.data,
    });

    Query query;
    Map<String, double> data;

    factory AllCurrenciesResponse.fromJson(Map<String, dynamic> json) => AllCurrenciesResponse(
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
        this.timestamp,
        this.baseCurrency,
    });

    String apikey;
    int timestamp;
    String baseCurrency;

    factory Query.fromJson(Map<String, dynamic> json) => Query(
        apikey: json["apikey"],
        timestamp: json["timestamp"],
        baseCurrency: json["base_currency"],
    );

    Map<String, dynamic> toJson() => {
        "apikey": apikey,
        "timestamp": timestamp,
        "base_currency": baseCurrency,
    };
}
