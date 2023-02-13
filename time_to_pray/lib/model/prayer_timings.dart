class PrayerTimings {
  String? mosqueName;
  String? latlng;
  String? mosqueId;
  String? fajar;
  String? dhuhr;
  String? asr;
  String? maghrib;
  String? isha;
  String? jummaMubark;
  String? address;
  String? timingStatus;
  String? userId;
  String? personEmail;

  PrayerTimings({
    this.mosqueName,
    this.latlng,
    this.mosqueId,
    this.fajar,
    this.dhuhr,
    this.asr,
    this.maghrib,
    this.isha,
    this.jummaMubark,
    this.address,
    this.timingStatus,
    this.userId,
    this.personEmail,
  });

  PrayerTimings.fromJson(Map<String, dynamic> json) {
    mosqueName = json["mosqueName"];
    latlng = json["latlng"];
    mosqueId = json["mosqueId"];
    fajar = json["fajar"];
    dhuhr = json["dhuhr"];
    asr = json["asr"];
    maghrib = json["maghrib"];
    isha = json["isha"];
    jummaMubark = json["jummaMubark"];
    address = json["address"];
    timingStatus = json["timingStatus"];
    userId = json["userId"];
    personEmail = json["personEmail"];
  }

  get canSubmit => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["mosqueName"] = mosqueName;
    data["latlng"] = latlng;
    data["mosqueId"] = mosqueId;
    data["fajar"] = fajar;
    data["dhuhr"] = dhuhr;
    data["asr"] = asr;
    data["maghrib"] = maghrib;
    data["isha"] = isha;
    data["jummaMubark"] = jummaMubark;
    data["address"] = address;
    data["timingStatus"] = timingStatus;
    data["userId"] = userId;
    data["personEmail"] = personEmail;

    return data;
  }
}
