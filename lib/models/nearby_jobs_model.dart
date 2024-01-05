class NearbyJobs {
  final String employerLogo;
  final String jobTitle;
  final String jobType;
  final String jobId;

  NearbyJobs(
      {required this.employerLogo,
      required this.jobType,
      required this.jobTitle,
      required this.jobId});

  factory NearbyJobs.fromJson(Map<String, dynamic> json) {
    return NearbyJobs(
        jobTitle: json['job_title'] ?? "",
        jobType: json['job_employment_type'] ?? "",
        employerLogo: json['employer_logo'] ??
            "https://t4.ftcdn.net/jpg/05/05/61/73/360_F_505617309_NN1CW7diNmGXJfMicpY9eXHKV4sqzO5H.jpg",
        jobId: json['job_id'] ?? "");
  }
}
