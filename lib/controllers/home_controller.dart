import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:job_finder_ui/constants/api_headers.dart';
import 'package:job_finder_ui/models/nearby_jobs_model.dart';
import 'package:job_finder_ui/models/popular_jobs_model.dart';

class HomeController {
  Future<List<PopularJobs>> fetchNearbyJobs() async {
    http.Response response = await http.get(
        Uri.parse(
            "${dotenv.env["JSEARCH_BASE_API_URL"]}/search?page=1&num_pages=1&query=web developer&employment_types=CONTRACTOR"),
        headers: ApiHeaders.headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> data = body['data'];
      List<PopularJobs> jobs =
          data.map((dynamic item) => PopularJobs.fromJson(item)).toList();
      return jobs;
    } else {
      throw "cannot get jobs";
    }
  }

  Future<List<NearbyJobs>> fetchPopularJobs(String searchTerm) async {
    http.Response response = await http.get(
        Uri.parse(
            "${dotenv.env["JSEARCH_BASE_API_URL"]}/search?page=1&num_pages=1&query=${searchTerm}&employment_types=CONTRACTOR"),
        headers: ApiHeaders.headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> data = body['data'];
      List<NearbyJobs> jobs =
          data.map((dynamic item) => NearbyJobs.fromJson(item)).toList();

      return jobs;
    } else {
      throw "cannot get jobs";
    }
  }
}
