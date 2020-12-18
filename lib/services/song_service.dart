import 'package:dio/dio.dart';
import 'package:shazam/services/models/deezer_song_model.dart';

class SongService {
  Dio _dio;

  SongService() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 100000,
        connectTimeout: 100000,
        baseUrl: 'https://api.deezer.com/track/');
    _dio = Dio(options);
  }
  Future<DeezerSongModel> getTrack(id) async {
    try {
      final response = await _dio.get('$id',
          options: Options(headers: {
            'Content-type': 'application/json;charset=UTF-8',
            'Accept': 'application/json;charset=UTF-8',
          }));
      DeezerSongModel result = DeezerSongModel.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.request != null) {
        throw 'An error has occured';
      } else {
        print(e.error);
        throw e.error;
      }
    }
  }
}
