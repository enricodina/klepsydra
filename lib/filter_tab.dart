import 'package:flutter/material.dart';

class FilterTab extends StatefulWidget {
  @override
  _FilterTabState createState() => _FilterTabState();
}

class _FilterTabState extends State<FilterTab> {
  List<List<String>> _apiData = []; // Store the data retrieved from the API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Tab'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  // Check if API data is loaded
                  if (_apiData.isEmpty) {
                    // Show "No data loaded" dialog
                    _showNoDataDialog(context);
                  } else {
                    // Sort the data in decreasing order
                    setState(() {
                      _apiData.sort((a, b) => a[0].compareTo(b[0]));
                    });
                  }
                },
                child: Text('Decreasing'),
              ),
              TextButton(
                onPressed: () {
                  // Check if API data is loaded
                  if (_apiData.isEmpty) {
                    // Show "No data loaded" dialog
                    _showNoDataDialog(context);
                  } else {
                    // Sort the data in increasing order
                    setState(() {
                      _apiData.sort((a, b) => b[0].compareTo(a[0]));
                    });
                  }
                },
                child: Text('Increasing'),
              ),
              TextButton(
                onPressed: () {
                  // Check if API data is loaded
                  if (_apiData.isEmpty) {
                    // Show "No data loaded" dialog
                    _showNoDataDialog(context);
                  } else {
                    // Apply filtering logic here
                    // You can update _apiData according to your filter requirements
                  }
                },
                child: Text('Filter'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _apiData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_apiData[index]
                      [0]), // Displaying the first value of each row
                  // You can display other values as per your API response structure
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showNoDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Data Loaded'),
          content: Text('Please load data from the API first.'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
