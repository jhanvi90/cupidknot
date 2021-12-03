

import 'dart:convert';

userData userDataFromJson(String str) => userData.fromJson(json.decode(str));

String userDataToJson(userData data) => json.encode(data.toJson());

class userData {
  userData({
    this.success,
    this.data,
    this.message,
  });

  bool success;
  Data data;
  String message;

  factory userData.fromJson(Map<String, dynamic> json) => userData(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

List<Datum> distDownlineDirectModelFromJson(String str) =>
    List<Datum>.from(json.decode(str).map((x) => Datum.fromJson(x)));
class Datum {
  Datum({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.religion,
    this.birthDate,
    this.gender,
    this.userImages,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String firstName;
  String lastName;
  String religion;
  DateTime birthDate;
  String gender;
  List<UserImage> userImages;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    firstName: json["first_name"],
    lastName: json["last_name"],
    religion: json["religion"] == null ? null : json["religion"],
    birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
    gender: json["gender"] == null ? null : json["gender"],
    userImages: List<UserImage>.from(json["user_images"].map((x) => UserImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "first_name": firstName,
    "last_name": lastName,
    "religion": religion == null ? null : religion,
    "birth_date": birthDate == null ? null : "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
    "gender": gender == null ? null : gender,
    "user_images": List<dynamic>.from(userImages.map((x) => x.toJson())),
  };
}

class UserImage {
  UserImage({
    this.id,
    this.userId,
    this.name,
    this.path,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String name;
  String path;
  String type;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserImage.fromJson(Map<String, dynamic> json) => UserImage(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    path: json["path"],
    type: json["type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "path": path,
    "type": type,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
