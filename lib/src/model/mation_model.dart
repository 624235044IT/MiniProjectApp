
import 'dart:convert';

MantionModel mantionModelFromJson(String str) => MantionModel.fromJson(json.decode(str));

String condoModelToJson(MantionModel data) => json.encode(data.toJson());

class MantionModel {
  MantionModel({
    this.mantion,
  });

  List<Mantion> mantion;

  factory MantionModel.fromJson(Map<String, dynamic> json) => MantionModel(
    mantion: List<Mantion>.from(json["mantion"].map((x) => Mantion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mantion": List<dynamic>.from(mantion.map((x) => x.toJson())),
  };
}

class Mantion {
  Mantion({
    this.id,
    this.mantionId,
    this.mantionName,
    this.mantionPrice,
    this.mantionDetail,
    this.mantionImg,
    this.mantionComment,
  });

  String id;
  String mantionId;
  String mantionName;
  String mantionPrice;
  String mantionDetail;
  String mantionImg;
  String mantionComment;

  factory Mantion.fromJson(Map<String, dynamic> json) => Mantion(
    id: json["id"],
    mantionId: json["mantion_id"],
    mantionName: json["mantion_name"],
    mantionPrice: json["mantion_price"],
    mantionDetail: json["mantion_detail"],
    mantionImg: json["mantion_img"],
    mantionComment: json["mantion_comment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mantion_id": mantionId,
    "mantion_name": mantionName,
    "mantion_price": mantionPrice,
    "mantion_detail": mantionDetail,
    "mantion_img": mantionImg,
    "mantion_comment": mantionComment,
  };
}
