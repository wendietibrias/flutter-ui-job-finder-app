class Categories {
  String title;
  String value;
  Categories({required this.title, required this.value});
}

List<Categories> categories = [
  Categories(title: 'Contractor', value: "CONTRACTOR"),
  Categories(title: 'Full-Time', value: "FULLTIME"),
  Categories(title: 'Part-Time', value: "PARTTIME"),
  Categories(title: 'Internship', value: "INTERN")
];
