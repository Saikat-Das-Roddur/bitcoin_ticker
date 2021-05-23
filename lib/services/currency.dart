import 'package:bitcoin_picker/services/network_helper.dart';

const apiKey = "C3CB6BD6-7082-42FA-968E-5BBE7F436E89";
const baseUrl = "https://rest.coinapi.io/v1/exchangerate";
class CurrencyDataModel{

  Future<dynamic> getCurrencyPrice(String base, String quote) async{
    NetworkHelper  networkHelper = NetworkHelper("$baseUrl/$base/$quote?apikey=$apiKey");
    var currencyData = await networkHelper.getCurrencyData();
    return currencyData;
  }
}