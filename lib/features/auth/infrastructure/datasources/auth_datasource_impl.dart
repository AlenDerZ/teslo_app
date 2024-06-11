import 'package:dio/dio.dart';
import 'package:teslo_app/config/config.dart';
import 'package:teslo_app/features/auth/domain/domain.dart';
import 'package:teslo_app/features/auth/infrastructure/infrastructure.dart';

class AuthDataSourceImpl extends AuthDataSource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl
    )
  );

  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try{
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password
      });

      final user = UserMapper.userJsonToEntity(response.data);
      
      return user;
    }on DioException catch (e){
      if(e.response?.statusCode == 401){
        throw CustomError(e.response?.data['message'] ?? 'Credenciales Incorrectas');
      }
      if(e.type == DioExceptionType.connectionTimeout) throw CustomError('Revisar Conexion a Internet');

      throw Exception();
    }catch(e){
      throw Exception();
    }
  }

  @override
  Future<User> register(String fullName, String email, String password) async {
    try{
      final response = await dio.post('/auth/register', data: {
        'email': email,
        'password': password,
        'fullName': fullName,
      });
      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    }on DioException catch (e){
      if(e.response?.statusCode == 400){
        throw CustomError(e.response?.data['message'] ?? 'Formato Invalido');
      }
      if(e.type == DioExceptionType.connectionTimeout) throw CustomError('Revisar Conexion a Internet');

      throw Exception();
    }catch(e){
      throw Exception();
    }
  }
}