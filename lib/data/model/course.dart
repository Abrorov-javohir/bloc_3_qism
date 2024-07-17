class Course {
  final String title;
  final String code;
  final double cbPrice;

  Course({required this.title, required this.code, required this.cbPrice});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'],
      code: json['code'],
      cbPrice: double.parse(json['cb_price']),
    );
  }
}
