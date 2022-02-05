import 'dart:convert';

StopForecastModel stopForecastModelFromJson(String str) =>
    StopForecastModel.fromJson(json.decode(str));

String? stopForecastModelToJson(StopForecastModel data) =>
    json.encode(data.toJson());

class StopForecastModel {
  StopForecastModel({
    this.clear,
    this.created,
    this.message,
    this.status,
    this.trams,
  });

  final bool? clear;
  final DateTime? created;
  final String? message;
  final Status? status;
  final List<Tram>? trams;

  factory StopForecastModel.fromJson(Map<String, dynamic> json) =>
      StopForecastModel(
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        message: json["message"],
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        trams: json["trams"] == null
            ? null
            : List<Tram>.from(json["trams"].map((x) => Tram.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "created": created?.toIso8601String(),
        "message": message,
        "status": status?.toJson(),
        "trams": trams == null
            ? null
            : List<dynamic>.from(trams!.map((x) => x.toJson())),
      };
}

class Status {
  Status({
    this.inbound,
    this.outbound,
  });

  final StatusDirection? inbound;
  final StatusDirection? outbound;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        inbound: json["inbound"] == null
            ? null
            : StatusDirection.fromJson(json["inbound"]),
        outbound: json["outbound"] == null
            ? null
            : StatusDirection.fromJson(json["outbound"]),
      );

  Map<String, dynamic> toJson() => {
        "inbound": inbound?.toJson(),
        "outbound": outbound?.toJson(),
      };
}

class StatusDirection {
  StatusDirection({
    this.message,
    this.forecastsEnabled,
    this.operatingNormally,
  });

  final String? message;
  final String? forecastsEnabled;
  final String? operatingNormally;

  factory StatusDirection.fromJson(Map<String, dynamic> json) =>
      StatusDirection(
        message: json["message"],
        forecastsEnabled: json["forecastsEnabled"],
        operatingNormally: json["operatingNormally"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "forecastsEnabled": forecastsEnabled,
        "operatingNormally": operatingNormally,
      };
}

class Tram {
  Tram({
    this.direction,
    this.dueMinutes,
    this.destination,
  });

  final String? direction;
  final String? dueMinutes;
  final String? destination;

  factory Tram.fromJson(Map<String, dynamic> json) => Tram(
        direction: json["direction"],
        dueMinutes: json["dueMinutes"],
        destination: json["destination"],
      );

  Map<String, dynamic> toJson() => {
        "direction": direction,
        "dueMinutes": dueMinutes,
        "destination": destination,
      };
}
