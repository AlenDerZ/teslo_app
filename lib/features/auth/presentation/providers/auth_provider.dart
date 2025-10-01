
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_app/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:teslo_app/features/shared/infrastructure/services/key_value_storage_service_impl.dart';

import '../../domain/domain.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {

  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService
  );
});

class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }): super(AuthState()){
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try{
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    }on CustomError catch (ce){
      logout(ce.message);
    }catch(e){
      logout('Error no controlado');
    }
  }

  void registerUser(String fullName, String email, String password) async {
    Future.delayed(const Duration(milliseconds: 500));

    try{
      await authRepository.register(fullName, email, password);
      // _setRegisterUser(user);
    }on CustomError catch (e) {
      logout(e.message);
    }catch(e){
      logout('Error no controlado');
    }
  }

  void checkAuthStatus() async{
    final token = await keyValueStorageService.getValue<String>('token');

    if(token == null) return logout(null);
    
    try{
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    }catch (e){
      logout(null);
    }
  }

  _setLoggedUser(User user) async{
    await keyValueStorageService.setKeyValue('token', user.token);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  // _setRegisterUser(User user){
  // }

  Future<void> logout(String? errorMessage) async {
    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
      user: null,
      authStatus: AuthStatus.notAuthenticated,
      errorMessage: errorMessage
    );
  }
  
}

enum AuthStatus { checking, authenticated, notAuthenticated }
class AuthState{
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.errorMessage = ''
    });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage
  );
  
}