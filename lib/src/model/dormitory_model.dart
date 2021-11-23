
import 'dart:convert';

DormitoryModel dormitoryModelFromJson(String str) => DormitoryModel.fromJson(json.decode(str));

String dormitoryModelToJson(DormitoryModel data) => json.encode(data.toJson());

class DormitoryModel {
  DormitoryModel({
    this.dormitory,
  });

  List<Dormitory> dormitory;

  factory DormitoryModel.fromJson(Map<String, dynamic> json) => DormitoryModel(
    dormitory: List<Dormitory>.from(json["dormitory"].map((x) => Dormitory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "dormitory": List<dynamic>.from(dormitory.map((x) => x.toJson())),
  };
}

class Dormitory {
  Dormitory({
    this.id,
    this.dormitoryId,
    this.dormitoryName,
    this.dormitoryPrice,
    this.dormitoryDetail,
    this.dormitoryImg,
    this.dormitoryComment,
  });

  String id;
  String dormitoryId;
  String dormitoryName;
  String dormitoryPrice;
  String dormitoryDetail;
  String dormitoryImg;
  String dormitoryComment;

  factory Dormitory.fromJson(Map<String, dynamic> json) => Dormitory(
    id: json["id"],
    dormitoryId: json["dormitory_id"],
    dormitoryName: json["dormitory_name"],
    dormitoryPrice: json["dormitory_price"],
    dormitoryDetail: json["dormitory_detail"],
    dormitoryImg: json["dormitory_img"],
    dormitoryComment: json["dormitory_comment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dormitory_id": dormitoryId,
    "dormitory_name": dormitoryName,
    "dormitory_price": dormitoryPrice,
    "dormitory_detail": dormitoryDetail,
    "dormitory_img": dormitoryImg,
    "dormitory_comment": dormitoryComment,
  };
}
