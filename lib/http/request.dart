import 'package:sislam_car/http/url.dart';
import 'package:http/http.dart' as http;

class Request {
  final String url;
  final dynamic body;

  Request({required this.url, this.body});

  Future<http.Response> post() {
    return http
        .post(Uri.parse(urlBase + url), body: body)
        .timeout(const Duration(minutes: 2));
  }

  Future<http.Response> get() {
    return http
        .get(Uri.parse(urlBase + url))
        .timeout(const Duration(minutes: 2));
  }
}
