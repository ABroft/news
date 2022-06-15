import 'package:dio/dio.dart';


import 'models/news.dart';


class NewsApi {
  final Dio _dio = Dio();

  Future fetchNews({required String schoolType , required int cityId, required int count }) async {
    Iterable<News> result;
    
  try {
      
    Response response = await _dio.get('https://education-erp.com/api/ClientApplication/News', 
     queryParameters: {'schoolType' : schoolType, 'cityId' : cityId.toString(), 'count' : count.toString()},
     options: Options(responseType: ResponseType.json, ),);
        
     var data = response.data as List<dynamic>;
        result = data
            .cast<Map<String, dynamic>>()
            .map((json) => News.fromJson(json));       
  } on DioError catch (e) {
    
     if (e.response != null) {
       
       return e.response?.statusCode;
     } else {
       return e.message ;
     }
  }
  return result;
}
  
}
