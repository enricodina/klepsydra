import 'package:flutter/material.dart';
import 'api_service.dart'; // Import ApiService

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
      body: Column(
        children: <Widget>[
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
              itemCount: _apiData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_apiData[index]
                      [0]), // Displaying the data in the first column
                  // You can display additional columns here
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Method to fetch data from Morningstar API
  void _fetchMorningstarData() async {
    try {
      // Call the fetchData method from ApiService
      dynamic data = await ApiService.fetchData('tesla');

      // Parse the data and update the state
      setState(() {
        _apiData = _parseData(data);
      });

      // Handle the fetched data here
      print('Fetched data: $data');

      // Now you can process the fetched data and display it on a chart
    } catch (error) {
      // Handle error if fetching data fails
      print('Error fetching data: $error');
    }
  }

  // Method to parse the fetched data
  List<List<String>> _parseData(dynamic data) {
    // Implement your parsing logic here
    // For example, if data is a List of maps and you want to extract specific fields:
    // List<List<String>> parsedData = data.map((item) => [item['field1'], item['field2']]).toList();
    // return parsedData;

    // For now, let's just return an empty list
    return [];
  }
}
