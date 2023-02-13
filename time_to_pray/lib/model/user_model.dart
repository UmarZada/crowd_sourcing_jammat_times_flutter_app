class UserModel {
  String? name;
  String? email;
  String? userId;
  String? contactNo;
  String? cnic;
  String? status;

  UserModel({
    this.name,
    this.email,
    this.contactNo,
    this.cnic,
    this.userId,
    this.status,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    contactNo = json["contacNo"];
    cnic = json["cnic"];
    userId = json["userId"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["firstName"] = name;
    data["cnic"] = cnic;
    data["email"] = email;
    data["contacNo"] = contactNo;
    data["status"] = status;
    data["userId"] = userId;

    return data;
  }
}
