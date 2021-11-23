import 'dart:convert';
import 'dart:io';
import 'package:FlutterApp/src/configs/api.dart';
import 'package:FlutterApp/src/model/apartment_model.dart';
import 'package:FlutterApp/src/model/condo_model.dart';
import 'package:FlutterApp/src/model/dormitory_model.dart';
import 'package:FlutterApp/src/model/mation_model.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class NetworkService{
  NetworkService._internal();

  static final NetworkService _instace = NetworkService._internal();

  factory NetworkService() => _instace;

  static final Dio _dio = Dio();


  Future<String> validateUserLoginDio(String username, String password) async {
    FormData data = FormData.fromMap({
      'username': username,
      'password': password,
    });
    try {
      //var url = API.BASE_URL + '/flutterapp/f_user_login.php';
      //var url = API.BASE_URL + '/api/user';
      var url = API.BASE_URL + '/flutterapi/api/user';
      final response = await _dio.post(url, data: data);
      if (response.statusCode == 200) {
        var jsonString = response.data;
        // var jsonMap = json.encode(jsonString);
        String username = jsonString["username"];
        print('username = ' + username);
        String password = jsonString["password"];
        print('password = ' + password);
        if (username != 'failed') {
          return 'pass';
        } else {
          return 'failed';
        }
      } else {
        return 'failed';
      }
    } catch (Exception) {
      throw Exception('Network failed');
    }
  }

  Future<CondoModel> getAllCondoDio() async {
    //var url = API.BASE_URL + '/flutterapp/getAllGames_7.php';
    var url = API.BASE_URL + API.CONDO;
    print('url getAllCondoDio() = ' + url);
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      print(response.data);
      return condoModelFromJson(json.encode(response.data));
    }
    throw Exception('Network failed');
  }
  Future<String> addCondoDio(File imageFile, Condo condo) async {
    FormData data = FormData.fromMap({
      'condo_id': condo.condoId,
      'condo_name': condo.condoName,
      'condo_price': int.parse(condo.condoPrice),
      'condo_detail': condo.condoDetail,
      //'game_img': game.gameImg,
      'condo_comment': int.parse(condo.condoComment),
      if (imageFile != null)
        'condo_img': 'has_image'
      else
        'condo_img': 'no_image',
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });
    try {
      final response = await _dio.post(API.BASE_URL + API.CONDO, data: data);
      print(response);
      if (response != null) {
        if (response.statusCode == 200) {
          print(response.data);
          if (response.data > 0) {
            return 'Add Successfully';
          } else {
            return 'Add Failed';
          }
        }
      } else {
        print('response is nulllllll');
      }
    } catch (DioError) {
      print('Exception --> response is nulllllll');
      print(DioError.toString());
      throw DioError();
    }
  }
  Future<String> editCondoDio(File imageFile, Condo condo) async {
    FormData data = FormData.fromMap({
      'condo_name': condo.condoName,
      'condo_price': int.parse(condo.condoPrice),
      'condo_detail': condo.condoDetail,
      'condo_comment': int.parse(condo.condoComment),
      // if (imageFile != null)
      //   'photo': await MultipartFile.fromFile(
      //     imageFile.path,
      //     contentType: MediaType('image', 'jpg'),
      //   ),
      if (imageFile != null)
        'condo_img': condo.condoImg
      else
        'condo_img': 'no_image',
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });

    final response =
    await _dio.post(API.BASE_URL + API.CONDO + '/' + condo.id, data: data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data > 0) {
        return 'Edit Successfully';
      } else {
        return 'Edit Failed';
      }
    }
    throw Exception('Network failed');
  }
  Future<String> deleteCondoDio(String id) async {
    final response = await _dio.delete(API.BASE_URL + API.CONDO + '/' + id);

    if (response.statusCode == 200) {
      if (response.data > 0) {
        return 'Delete Successfully';
      } else {
        return 'Delete Failed';
      }
    }
    throw Exception('Network failed');
  }//condo

  Future<ApartmentModel> getAllApartmentDio() async {
    //var url = API.BASE_URL + '/flutterapp/getAllGames_7.php';
    var url = API.BASE_URL + API.APARTMENT;
    print('url getAllApartmentDio() = ' + url);
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      print(response.data);
      return apartmentModelFromJson(json.encode(response.data));
    }
    throw Exception('Network failed');
  }
  Future<String> addApartmentDio(File imageFile, Apartment apartment) async {
    FormData data = FormData.fromMap({
      'apartment_id': apartment.apartmentId,
      'apartment_name': apartment.apartmentName,
      'apartment_price': int.parse(apartment.apartmentPrice),
      'apartment_detail': apartment.apartmentDetail,
      //'game_img': game.gameImg,
      'apartment_comment': int.parse(apartment.apartmentComment),
      if (imageFile != null)
        'apartment_img': 'has_image'
      else
        'apartment_img': 'no_image',
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });
    try {
      final response = await _dio.post(API.BASE_URL + API.APARTMENT, data: data);
      print(response);
      if (response != null) {
        if (response.statusCode == 200) {
          print(response.data);
          if (response.data > 0) {
            return 'Add Successfully';
          } else {
            return 'Add Failed';
          }
        }
      } else {
        print('response is nulllllll');
      }
    } catch (DioError) {
      print('Exception --> response is nulllllll');
      print(DioError.toString());
      throw DioError();
    }
  }
  Future<String> editApartmentDio(File imageFile, Apartment apartment) async {
    FormData data = FormData.fromMap({
      'apartment_name': apartment.apartmentName,
      'apartment_price': int.parse(apartment.apartmentPrice),
      'apartment_detail': apartment.apartmentDetail,
      'apartment_comment': int.parse(apartment.apartmentComment),
      // if (imageFile != null)
      //   'photo': await MultipartFile.fromFile(
      //     imageFile.path,
      //     contentType: MediaType('image', 'jpg'),
      //   ),
      if (imageFile != null)
        'apartment_img': apartment.apartmentImg
      else
        'apartment_img': 'no_image',
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });

    final response =
    await _dio.post(API.BASE_URL + API.APARTMENT + '/' + apartment.id, data: data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data > 0) {
        return 'Edit Successfully';
      } else {
        return 'Edit Failed';
      }
    }
    throw Exception('Network failed');
  }
  Future<String> deleteApartmentDio(String id) async {
    final response = await _dio.delete(API.BASE_URL + API.APARTMENT + '/' + id);

    if (response.statusCode == 200) {
      if (response.data > 0) {
        return 'Delete Successfully';
      } else {
        return 'Delete Failed';
      }
    }
    throw Exception('Network failed');
  }//apartment

  Future<MantionModel> getAllMantionDio() async {
    //var url = API.BASE_URL + '/flutterapp/getAllGames_7.php';
    var url = API.BASE_URL + API.MANTION;
    print('url getAllMantionDio() = ' + url);
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      print(response.data);
      return mantionModelFromJson(json.encode(response.data));
    }
    throw Exception('Network failed');
  }
  Future<String> addMantionDio(File imageFile, Mantion mantion) async {
    FormData data = FormData.fromMap({
      'mantion_id': mantion.mantionId,
      'mantion_name': mantion.mantionName,
      'mantion_price': int.parse(mantion.mantionPrice),
      'mantion_detail': mantion.mantionDetail,
      //'game_img': game.gameImg,
      'mantion_comment': int.parse(mantion.mantionComment),
      if (imageFile != null)
        'mantion_img': 'has_image'
      else
        'mantion_img': 'no_image',
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });
    try {
      final response = await _dio.post(API.BASE_URL + API.MANTION, data: data);
      print(response);
      if (response != null) {
        if (response.statusCode == 200) {
          print(response.data);
          if (response.data > 0) {
            return 'Add Successfully';
          } else {
            return 'Add Failed';
          }
        }
      } else {
        print('response is nulllllll');
      }
    } catch (DioError) {
      print('Exception --> response is nulllllll');
      print(DioError.toString());
      throw DioError();
    }
  }
  Future<String> editMantionDio(File imageFile, Mantion mantion) async {
    FormData data = FormData.fromMap({
      'mantion_name': mantion.mantionName,
      'mantion_price': int.parse(mantion.mantionPrice),
      'mantion_detail': mantion.mantionDetail,
      'mantion_comment': int.parse(mantion.mantionComment),
      // if (imageFile != null)
      //   'photo': await MultipartFile.fromFile(
      //     imageFile.path,
      //     contentType: MediaType('image', 'jpg'),
      //   ),
      if (imageFile != null)
        'mantion_img': mantion.mantionImg
      else
        'mantion_img': 'no_image',
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });

    final response =
    await _dio.post(API.BASE_URL + API.MANTION + '/' + mantion.id, data: data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data > 0) {
        return 'Edit Successfully';
      } else {
        return 'Edit Failed';
      }
    }
    throw Exception('Network failed');
  }
  Future<String> deleteMantionDio(String id) async {
    final response = await _dio.delete(API.BASE_URL + API.MANTION + '/' + id);

    if (response.statusCode == 200) {
      if (response.data > 0) {
        return 'Delete Successfully';
      } else {
        return 'Delete Failed';
      }
    }
    throw Exception('Network failed');
  }//mantion

  Future<DormitoryModel> getAllDormitoryDio() async {
    //var url = API.BASE_URL + '/flutterapp/getAllGames_7.php';
    var url = API.BASE_URL + API.DORMITORY;
    print('url getAllDormitoryDio() = ' + url);
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      print(response.data);
      return dormitoryModelFromJson(json.encode(response.data));
    }
    throw Exception('Network failed');
  }
  Future<String> addDormitoryDio(File imageFile, Dormitory dormitory) async {
    FormData data = FormData.fromMap({
      'dormitory_id': dormitory.dormitoryId,
      'dormitory_name': dormitory.dormitoryName,
      'dormitory_price': int.parse(dormitory.dormitoryPrice),
      'dormitory_detail': dormitory.dormitoryDetail,
      //'game_img': game.gameImg,
      'dormitory_comment': int.parse(dormitory.dormitoryComment),
      if (imageFile != null)
        'dormitory_img': 'has_image'
      else
        'dormitory_img': 'no_image',
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });
    try {
      final response = await _dio.post(API.BASE_URL + API.DORMITORY, data: data);
      print(response);
      if (response != null) {
        if (response.statusCode == 200) {
          print(response.data);
          if (response.data > 0) {
            return 'Add Successfully';
          } else {
            return 'Add Failed';
          }
        }
      } else {
        print('response is nulllllll');
      }
    } catch (DioError) {
      print('Exception --> response is nulllllll');
      print(DioError.toString());
      throw DioError();
    }
  }
  Future<String> editDormitoryDio(File imageFile, Dormitory dormitory) async {
    FormData data = FormData.fromMap({
      'dormitory_name': dormitory.dormitoryName,
      'dormitory_price': int.parse(dormitory.dormitoryPrice),
      'dormitory_detail': dormitory.dormitoryDetail,
      'dormitory_comment': int.parse(dormitory.dormitoryComment),
      // if (imageFile != null)
      //   'photo': await MultipartFile.fromFile(
      //     imageFile.path,
      //     contentType: MediaType('image', 'jpg'),
      //   ),
      if (imageFile != null)
        'dormitory_img': dormitory.dormitoryImg
      else
        'dormitory_img': 'no_image',
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });

    final response =
    await _dio.post(API.BASE_URL + API.DORMITORY + '/' + dormitory.id, data: data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data > 0) {
        return 'Edit Successfully';
      } else {
        return 'Edit Failed';
      }
    }
    throw Exception('Network failed');
  }
  Future<String> deleteDormitoryDio(String id) async {
    final response = await _dio.delete(API.BASE_URL + API.DORMITORY + '/' + id);

    if (response.statusCode == 200) {
      if (response.data > 0) {
        return 'Delete Successfully';
      } else {
        return 'Delete Failed';
      }
    }
    throw Exception('Network failed');
  }//dormitory


}//end class