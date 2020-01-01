import 'dart:convert';
import 'package:bitcoin_ticket/screens/CoinData.dart';
import 'package:bitcoin_ticket/util/Constants.dart';
import 'package:http/http.dart' as http;

class CurrencyModel {
  Future<dynamic> getSelectedCurrency(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      var url = '$bitCoinApiUrl$crypto$selectedCurrency';
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['last'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      }
    }
    return cryptoPrices;
  }
}
