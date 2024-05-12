import 'package:flutter/material.dart';
import 'api_service.dart'; // Import ApiService
import 'dart:convert';

class ChartTab extends StatefulWidget {
  @override
  _ChartTabState createState() => _ChartTabState();
}

class _ChartTabState extends State<ChartTab> {
  List<List<String>> _apiData = []; // Store the data retrieved from the API

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is initialized
    _fetchMorningstarData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chart Tab'),
        ),
        body: Column(children: <Widget>[
          ElevatedButton(
            onPressed: () {
              // Call method to fetch data
              _fetchMorningstarData();
            },
            child: Text('Retrieve Morningstar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Show the dialog to verify the address
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Verify Address'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: 'API Address'),
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Process the verification logic here
                          // You can access the text entered in the text fields using TextEditingController
                        },
                        child: Text('Verify'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Verify Address'),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: _apiData.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            for (final label in [
                              'ID',
                              'Name',
                              'Descript',
                              'Exchange',
                              'Perf Id',
                              'Secrty Type',
                              'Ticker',
                              'Type',
                              'URL'
                            ])
                              Expanded(
                                child: Text(
                                  label,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: List.generate(
                            _apiData[index - 1].length,
                            (columnIndex) => Expanded(
                              child: Text(
                                _apiData[index - 1][columnIndex],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }))
        ]));
  }

  // Method to fetch data from Morningstar API
  void _fetchMorningstarData() async {
    List<String> symbols = ['tesla', 'amazon', 'nvidia', 'microsoft', 'apple'];
    try {
      for (String symbol in symbols) {
        // Call the fetchData method from ApiService for each symbol
        dynamic data = await ApiService.fetchData(symbol);

        // Parse the JSON string into a map
        Map<String, dynamic> jsonData = jsonDecode(data);

        // Parse the data and update the state
        setState(() {
          _apiData.addAll(_parseData(jsonData));
        });
      }
    } catch (error) {
      // Handle error if fetching data fails
      print('Error fetching data: $error');
    }
  }

// Method to parse the fetched data
  List<List<String>> _parseData(dynamic data) {
    List<List<String>> parsedData = [];

    if (data is List<dynamic>) {
      // Iterate over each item in the data list
      data.forEach((item) {
        List<String> rowData = [];

        // Extract the values of the fields for each vector
        rowData.add(item['id'] ?? '');
        rowData.add(item['name'] ?? '');
        rowData.add(item['description'] ?? '');
        rowData.add(item['exchange'] ?? '');
        rowData.add(item['performanceId'] ?? '');
        rowData.add(item['securityType'] ?? '');
        rowData.add(item['ticker'] ?? '');
        rowData.add(item['type'] ?? '');
        rowData.add(item['url'] ?? '');

        // Add the row data to the parsed data list
        parsedData.add(rowData);
      });
    } else if (data is Map<String, dynamic>) {
      // Extract the results from the single map object
      dynamic results = data['results'];

      if (results is List<dynamic>) {
        // Call the parsing logic recursively for the list of results
        parsedData = _parseData(results);
      } else {
        print('Error: Results is not in the expected format');
      }
    } else {
      print('Error: Data is not in the expected format');
    }

    return parsedData;
  }
}
/*
[{"id":"us_security-0P0000OQN8","name":"Tesla Inc","description":null,"exchange":"XNAS","performanceId":"0P0000OQN8","securityType":"ST","ticker":"TSLA","type":"us_security","url":null},
{"id":"us_security-0P0000CDE8","name":"Tesla Exploration Ltd","description":null,"exchange":"PINX","performanceId":"0P0000CDE8","securityType":"ST","ticker":"TXLZF","type":"us_security","url":null},
{"id":"us_security-0P0001QXRX","name":"T-REX 2X Long Tesla Daily Target ETF","description":null,"exchange":"XNAS","performanceId":"0P0001QXRX","securityType":"FE","ticker":"TSLT","type":"us_security","url":null},
{"id":"us_security-0P0001QXRV","name":"T-REX 2X Inverse Tesla Daily Target ETF","description":null,"exchange":"XNAS","performanceId":"0P0001QXRV","securityType":"FE","ticker":"TSLZ","type":"us_security","url":null}]}
*/