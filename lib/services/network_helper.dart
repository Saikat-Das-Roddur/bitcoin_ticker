import 'dart:convert';

import 'package:http/http.dart'as http;

class NetworkHelper{
  String url;
  NetworkHelper(this.url);

  Future getCurrencyData() async{
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var currencyData = jsonDecode(response.body);
      return currencyData;
    }else{
      print(response.statusCode);
    }
  }
}