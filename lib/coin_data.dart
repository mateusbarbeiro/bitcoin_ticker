import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
    'AUD',
    'BRL',
    'CAD',
    'CNY',
    'EUR',
    'GBP',
    'HKD',
    'IDR',
    'ILS',
    'INR',
    'JPY',
    'MXN',
    'NOK',
    'NZD',
    'PLN',
    'RON',
    'RUB',
    'SEK',
    'SGD',
    'USD',
    'ZAR'
];

const List<String> cryptoList = [
    'BTC',
    'ETH',
    'LTC',
];

class CoinData {
    Future<String> getCoinData(String cryptocurrency, String currency) async {
        Uri url = Uri.https(
            'rest.coinapi.io',
            '/v1/exchangerate/$cryptocurrency/$currency',
            {
                'apiKey': '8D8DB0FC-8BE1-40F4-B12D-3511792B4A40',
            },
        );

        http.Response response = await http.get(url);

        if (response.statusCode == 200) {
            var decodedData = convert.jsonDecode(response.body);

            return decodedData['rate'].toStringAsFixed(2);
        } else {
            print(response.statusCode);
            throw 'Problem with the get request';
        }
    }
}
