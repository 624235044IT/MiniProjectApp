
import 'dart:convert';
ApartmentModel apartmentModelFromJson(String str) => ApartmentModel.fromJson(json.decode(str));

String apartmentModelToJson(ApartmentModel data) => json.encode(data.toJson());

class ApartmentModel {
  ApartmentModel({
    this.apartment,
  });

  List<Apartment> apartment;

  factory ApartmentModel.fromJson(Map<String, dynamic> json) => ApartmentModel(
    apartment: List<Apartment>.from(json["apartment"].map((x) => Apartment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "apartment": List<dynamic>.from(apartment.map((x) => x.toJson())),
  };
}

class Apartment {
  Apartment({
    this.id,
    this.apartmentId,
    this.apartmentName,
    this.apartmentPrice,
    this.apartmentDetail,
    this.apartmentImg,
    this.apartmentComment,
  });

  String id;
  String apartmentId;
  String apartmentName;
  String apartmentPrice;
  String apartmentDetail;
  String apartmentImg;
  String apartmentComment;

  factory Apartment.fromJson(Map<String, dynamic> json) => Apartment(
    id: json["id"],
    apartmentId: json["apartment_id"],
    apartmentName: json["apartment_name"],
    apartmentPrice: json["apartment_price"],
    apartmentDetail: json["apartment_detail"],
    apartmentImg: json["apartment_img"],
    apartmentComment: json["apartment_comment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "apartment_name": apartmentName,
    "apartment_price": apartmentPrice,
    "apartment_detail": apartmentDetail,
    "apartment_img": apartmentImg,
    "apartment_comment": apartmentComment,
  };
}
