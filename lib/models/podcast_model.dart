class PodcastModel {
  String? name;
  String? releaseDate;
  String? synopsis;
  String? details;
  String? duration;
  String? pdfLink;
  String? audioLink;
  String? imageLink;

  PodcastModel(
      {required this.name,
      required this.releaseDate,
      required this.synopsis,
      required this.details,
      required this.duration,
      required this.pdfLink,
      required this.audioLink,
      required this.imageLink});

  PodcastModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        releaseDate = json['releaseDate'],
        synopsis = json['synopsis'],
        details = json['details'],
        duration = json['duration'],
        pdfLink = json['pdfLink'],
        audioLink = json['audioLink'],
        imageLink = json['imageLink'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'releaseDate': releaseDate,
        'synopsis': synopsis,
        'details': details,
        'duration': duration,
        'pdfLink': pdfLink,
        'audioLink': audioLink,
        'imageLink': imageLink,
      };
}
