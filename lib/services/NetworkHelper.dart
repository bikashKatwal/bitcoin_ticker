import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;
  Future<String> getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      double lastPrice = decodedData['last'];
      return lastPrice.toStringAsFixed(0);
    } else {
      print(response.statusCode);
      throw "Problem with the get request";
    }
  }
}
