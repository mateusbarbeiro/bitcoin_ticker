import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class PriceScreen extends StatefulWidget {
    @override
    _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
    static CoinData coinData = CoinData();
    String selectedCurrency = 'USD';

    DropdownButton<String> androidDropdown() {
        List<DropdownMenuItem<String>> result = [];
        for (String item in currenciesList) {
            result.add(
                DropdownMenuItem(
                    child: Text(
                        item,
                    ),
                    value: item,
                ),
            );
        }

        return DropdownButton<String>(
            value: selectedCurrency,
            items: result,
            onChanged: (value) {
                setState(() {
                    selectedCurrency = value!;
                    // updateCurrencyRate(value);
                });
            },
        );
    }

    CupertinoPicker iOSPicker() {
        List<Text> result = [];
        for (String item in currenciesList) {
            result.add(Text(item));
        }

        return CupertinoPicker(
            backgroundColor: Colors.lightBlue,
            itemExtent: 32.0,
            onSelectedItemChanged: (selectedIndex) {
                setState(() {
                    selectedCurrency = currenciesList[selectedIndex];
                    // updateCurrencyRate(currenciesList[selectedIndex]);
                });
            },
            children: result,
        );
    }

    Future<CryptocurrencyRates> getCurrencyRate(String currency) async {
        return CryptocurrencyRates(
            btc: await CoinData().getCoinData(cryptoList[0], currency),
            eth: await CoinData().getCoinData(cryptoList[1], currency),
            ltc: await CoinData().getCoinData(cryptoList[2], currency),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text(
                    '🤑 Ticker de Criptomoedas',
                    style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.lightBlue,
            ),
            body: FutureBuilder<CryptocurrencyRates>(
                future: getCurrencyRate(selectedCurrency),
                builder: (context, AsyncSnapshot<CryptocurrencyRates> snapshot) {
                    if (snapshot.hasData) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                                            child: Card(
                                                color: Colors.lightBlueAccent,
                                                elevation: 5.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 15.0,
                                                        horizontal: 28.0,
                                                    ),
                                                    child: Text(
                                                        '1 ${cryptoList[0]} = ${snapshot.data?.btc ?? '?'} $selectedCurrency',
                                                        textAlign: TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 20.0,
                                                            color: Colors.white,
                                                        ),
                                                    ),
                                                ),
                                            ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                                            child: Card(
                                                color: Colors.lightBlueAccent,
                                                elevation: 5.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 15.0,
                                                        horizontal: 28.0,
                                                    ),
                                                    child: Text(
                                                        '1 ${cryptoList[1]} = ${snapshot.data?.eth ?? '?'} $selectedCurrency',
                                                        textAlign: TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 20.0,
                                                            color: Colors.white,
                                                        ),
                                                    ),
                                                ),
                                            ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                                            child: Card(
                                                color: Colors.lightBlueAccent,
                                                elevation: 5.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 15.0,
                                                        horizontal: 28.0,
                                                    ),
                                                    child: Text(
                                                        '1 ${cryptoList[2]} = ${snapshot.data?.ltc ?? '?'} $selectedCurrency',
                                                        textAlign: TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 20.0,
                                                            color: Colors.white,
                                                        ),
                                                    ),
                                                ),
                                            ),
                                        ),
                                    ],
                                ),
                                Container(
                                    height: 150.0,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(bottom: 30.0),
                                    color: Colors.lightBlue,
                                    child: Platform.isIOS ? iOSPicker() : androidDropdown(),
                                ),
                            ],
                        );
                    } else {
                        return const Center(
                            child: CircularProgressIndicator(),
                        );
                    }
                },
            ),
        );
    }
}

class CryptocurrencyRates {
    String btc;
    String eth;
    String ltc;

    CryptocurrencyRates(
            {required this.btc, required this.eth, required this.ltc});
}
