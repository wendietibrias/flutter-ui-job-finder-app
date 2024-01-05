class DetailJobModel {
  final String jobTitle;
  final String jobDescription;
  final String jobCity;
  final String jobCountry;
  final String jobGoogleLink;
  final List<dynamic> jobResponsibilities;
  final List<dynamic> jobQualifications;
  final List<dynamic> jobBenefits;
  final String jobApplyLink;
  final String employerLogo;
  final String employerName;

  DetailJobModel(
      {required this.jobTitle,
      required this.jobDescription,
      required this.jobCity,
      required this.jobCountry,
      required this.jobGoogleLink,
      required this.jobApplyLink,
      required this.jobResponsibilities,
      required this.jobQualifications,
      required this.jobBenefits,
      required this.employerLogo,
      required this.employerName});

  factory DetailJobModel.fromJson(Map<String, dynamic> json) {
    return DetailJobModel(
        jobTitle: json['job_title'] ?? "",
        jobDescription: json['job_description'] ?? "",
        jobCity: json['job_city'] ?? "",
        jobCountry: json['job_country'] ?? "",
        jobGoogleLink: json['job_google_link'] ?? "",
        jobApplyLink: json['job_apply_link'] ?? "",
        jobResponsibilities: json['job_highlights']['Responsibilities'] ?? [],
        jobBenefits: json['job_highlights']['Benefits'] ?? [],
        jobQualifications: json['job_highlights']['Qualifications'] ?? [],
        employerLogo: json['employer_logo'] ?? "",
        employerName: json['employer_name'] ?? "");
  }
}
