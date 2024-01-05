import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:job_finder_ui/constants/api_headers.dart';
import 'package:job_finder_ui/models/detail_job_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DetailJobController {
  Future<DetailJobModel> fetchDetailJob(String id) async {
    http.Response response = await http.get(
        Uri.parse(
            "${dotenv.env["JSEARCH_BASE_API_URL"]}/job-details?job_id=${id}"),
        headers: ApiHeaders.headers);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> data = body['data'];

      DetailJobModel jobDetail = DetailJobModel.fromJson(data[0]);

      return jobDetail;
    } else {
      throw 'cannot get job data';
    }
  }
}
