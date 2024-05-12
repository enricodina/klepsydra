import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://morning-star.p.rapidapi.com';
  static const String apiKey =
      '08db7f30bemsh19fff341e7942c8p1e08a6jsn2804db08d3fa';

  static Future<dynamic> fetchData(String query) async {
    final Uri uri = Uri.parse('$baseUrl/market/v2/auto-complete?q=$query');

    final response = await http.get(
      uri,
      headers: {
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': 'morning-star.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
