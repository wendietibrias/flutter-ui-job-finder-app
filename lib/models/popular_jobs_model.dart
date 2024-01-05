class PopularJobs {
  final String employerLogo;
  final String employerName;
  final String jobPublisher;
  final String jobTitle;
  final String jobApplyLink;
  final String jobCountry;
  final String jobId;

  PopularJobs(
      {required this.employerLogo,
      required this.employerName,
      required this.jobPublisher,
      required this.jobTitle,
      required this.jobId,
      required this.jobApplyLink,
      required this.jobCountry});

  factory PopularJobs.fromJson(Map<String, dynamic> json) {
    return PopularJobs(
        jobTitle: json['job_title'] ?? "",
        jobPublisher: json['job_publisher'] ?? "",
        jobApplyLink: json['job_apply_link'] ?? "",
        jobCountry: json['job_country'] ?? "",
        employerLogo: json['employer_logo'] ??
            "https://t4.ftcdn.net/jpg/05/05/61/73/360_F_505617309_NN1CW7diNmGXJfMicpY9eXHKV4sqzO5H.jpg",
        employerName: json['employer_name'] ?? "",
        jobId: json['job_id'] ?? "");
  }
}
