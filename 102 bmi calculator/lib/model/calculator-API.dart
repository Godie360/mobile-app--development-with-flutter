import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;


class BmiRequest {
  final double weight;
  final double height;

  BmiRequest(this.weight, this.height);

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'height': height,
    };
  }
}

class BmiResponse {
  final double bmi;
  final String healthStatus;

  BmiResponse(this.bmi, this.healthStatus);

  factory BmiResponse.fromJson(Map<String, dynamic> json) {
    return BmiResponse(
      json['bmi'] as double,
      json['health_status'] as String,
    );
  }
}

Future<BmiResponse> calculateBmi(double weight, double height) async {
  final apiUrl = ('http://127.0.0.1:8000/calculate_bmi');

  // Append query parameters to the URL
  final urlWithParams = Uri.parse('$apiUrl?weight=$weight&height=$height');

  try {
    final response = await http.get(urlWithParams);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final BmiResponse bmiResponse = BmiResponse.fromJson(jsonResponse);
      return bmiResponse;
    } else {
      throw Exception('Failed to calculate BMI: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

