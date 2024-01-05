import 'dart:convert';

import 'package:job_finder_ui/constants/api_headers.dart';
import 'package:job_finder_ui/models/nearby_jobs_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SearchJobController {
  Future<List<NearbyJobs>> fetchSearchJob(
      {required String searchTerm, required String jobType}) async {
    http.Response response = await http.get(
        Uri.parse(
            "${dotenv.env["JSEARCH_BASE_API_URL"]}/search?query=${searchTerm}&num_pages=1&page=1"),
        headers: ApiHeaders.headers);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> data = body['data'];
      final List<NearbyJobs> jobs =
          data.map((dynamic item) => NearbyJobs.fromJson(item)).toList();

      return jobs;
    } else {
      throw "cannot get jobs";
    }
  }
}
