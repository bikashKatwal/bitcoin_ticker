import 'dart:io' show Platform;
import 'package:flag/flag.dart';
import 'package:bitcoin_ticket/screens/CoinData.dart';
import 'package:bitcoin_ticket/screens/CryptoCard.dart';
import 'package:bitcoin_ticket/services/CurrencyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CurrencyModel _currencyModel = CurrencyModel();
  String selectedCurrency = 'AUD';
  String countryCode = 'AU';
  Map<String, String> _coinValues = {};
  bool isWaiting = false;

  @override
  initState() {
    super.initState();
    updateCurrencyUI(selectedCurrency);
  }

  void updateCurrencyUI(String selectedValue) async {
    isWaiting = true;
    try {
      var currencyData =
          await _currencyModel.getSelectedCurrency(selectedValue);
      setState(() {
        selectedCurrency = selectedValue;
        _coinValues = currencyData;
        countryCode = selectedCurrency.substring(0, 2);
        isWaiting = false;
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton androidDropDownButton() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: getDropDownItems(),
      onChanged: (String newValue) {
        updateCurrencyUI(newValue);
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  List<DropdownMenuItem> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (var currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          value: isWaiting ? '?' : _coinValues[crypto],
          cryptoCurrency: crypto,
          selectedCurrency: selectedCurrency,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Expanded(
            child: Flags.getFullFlag(
                countryCode, double.infinity, double.infinity),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDownButton(),
          ),
        ],
      ),
    );
  }
}
