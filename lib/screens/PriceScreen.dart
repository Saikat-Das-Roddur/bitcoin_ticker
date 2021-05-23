import 'dart:io';

import 'package:bitcoin_picker/const_data.dart';
import 'package:bitcoin_picker/services/currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  var currencyDataBTC, currencyDataLTC,currencyDataETH;
  String  rateBTC = '?', rateETH = "?", rateLTC = "?";
  CurrencyDataModel currencyDataModel;

  @override
  void initState() {
    super.initState();
    currencyDataModel = CurrencyDataModel();
    getCurrencyData();
  }

  getCurrencyData() async{
    currencyDataBTC =  await currencyDataModel.getCurrencyPrice("BTC",selectedCurrency);
    currencyDataETH = await currencyDataModel.getCurrencyPrice("ETH",selectedCurrency);
    currencyDataLTC = await currencyDataModel.getCurrencyPrice("LTC",selectedCurrency);
    setState(() {
      if(currencyDataBTC==null&& currencyDataLTC==null&& currencyDataETH == null){
        rateBTC = "?";
        rateLTC = "?";
        rateETH = "?";
        return;
      }
      double tempBTC  = currencyDataBTC['rate'];
      rateBTC = tempBTC.toInt().toString();
      print(rateBTC);
      double tempLTC  = currencyDataLTC['rate'];
      rateLTC = tempLTC.toInt().toString();
      double tempETH = currencyDataETH['rate'];
      rateETH = tempETH.toInt().toString();
    });
  }

  DropdownButton getAndroidPicker(){
    List<DropdownMenuItem> menuItemList = currenciesList.map((e) => DropdownMenuItem(value: e,child: Text(e))).toList();
    return DropdownButton(
      value: selectedCurrency,
        items: menuItemList,
    onChanged: (value) async{
        setState(() {
          selectedCurrency = value;
          getCurrencyData();
        });
    },);
  }

  CupertinoPicker getIOSPicker(){
    List<Text> menuItemList = currenciesList.map((e) => Text(e)).toList();
    return CupertinoPicker(itemExtent: 32, onSelectedItemChanged: (value){
      setState(() {
        selectedCurrency = currenciesList[value];
        getCurrencyData();
      });
    }, children: menuItemList,);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Coin Ticker"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: Card(
                  elevation: 5,
                  color: Colors.lightBlue,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                    child: Text(
                      "1 BTC = $rateBTC $selectedCurrency",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: Card(
                  elevation: 5,
                  color: Colors.lightBlue,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                    child: Text(
                      "1 ETH = $rateETH $selectedCurrency",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: Card(
                  elevation: 5,
                  color: Colors.lightBlue,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
                    child: Text(
                      "1 LTC = $rateLTC $selectedCurrency",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150,
            color: Colors.lightBlue,
            alignment: Alignment.center,
            padding: EdgeInsets.only( bottom: 30),
            child: Platform.isIOS?getIOSPicker():getAndroidPicker()
          )
        ],
      ),
    );
  }
}
