
import 'dart:convert';

CondoModel condoModelFromJson(String str) => CondoModel.fromJson(json.decode(str));

String condoModelToJson(CondoModel data) => json.encode(data.toJson());

class CondoModel {
  CondoModel({
    this.condo,
  });

  List<Condo> condo;

  factory CondoModel.fromJson(Map<String, dynamic> json) => CondoModel(
    condo: List<Condo>.from(json["condo"].map((x) => Condo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "condo": List<dynamic>.from(condo.map((x) => x.toJson())),
  };
}

class Condo {
  Condo({
    this.id,
    this.condoId,
    this.condoName,
    this.condoPrice,
    this.condoDetail,
    this.condoImg,
    this.condoComment,
    this.condoRate,
  });

  String id;
  String condoId;
  String condoName;
  String condoPrice;
  String condoDetail;
  String condoImg;
  String condoComment;
  String condoRate;

  factory Condo.fromJson(Map<String, dynamic> json) => Condo(
    id: json["id"],
    condoId: json["condo_id"],
    condoName: json["condo_name"],
    condoPrice: json["condo_price"],
    condoDetail: json["condo_detail"],
    condoImg: json["condo_img"],
    condoComment: json["condo_comment"],
    condoRate: json["condo_rate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "condo_id": condoId,
    "condo_name": condoName,
    "condo_price": condoPrice,
    "condo_detail": condoDetail,
    "condo_img": condoImg,
    "condo_comment": condoComment,
    "condo_rate": condoRate,
  };
}
