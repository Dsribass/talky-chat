import 'package:auth/src/data/local/impl/secure_user_local_data_source.dart';
import 'package:auth/src/data/local/user_local_data_source.dart';
import 'package:auth/src/data/remote/auth_remote_data_source.dart';
import 'package:auth/src/data/remote/impl/default_auth_remote_data_source.dart';
import 'package:auth/src/data/remote/infra/token_manager.dart';
import 'package:auth/src/data/repositories/default_auth_repository.dart';
import 'package:auth/src/domain/repositories/auth_repository.dart';
import 'package:auth/src/domain/use_cases/use_cases.dart';
import 'package:core/core.dart';

final class AuthContainer implements ContainerModule {
  @override
  void registerDependencies(GetIt injector) {
    _registerCoreDependencies(injector);
    _registerDataDependencies(injector);
    _registerDomainDependencies(injector);
  }

  void _registerCoreDependencies(GetIt injector) {
    injector
      ..registerSingleton(
        const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
            preferencesKeyPrefix: 'talky_',
          ),
          iOptions: IOSOptions(
            accountName: 'talky',
          ),
        ),
      )
      ..registerSingleton(TokenManager(injector.get()))
      ..registerFactory<BaseApiHttpClient>(
        () => BaseApiHttpClient(
          options: HttpOptions(baseUrl: env.chatApiBaseUrl),
        ),
      );
  }

  void _registerDataDependencies(GetIt injector) {
    injector
      ..registerCachedFactory<UserLocalDataSource>(
        () => SecureUserLocalDataSource(injector.get()),
      )
      ..registerCachedFactory<AuthRemoteDataSource>(
        () => DefaultAuthRemoteDataSource(
          client: injector.get<BaseApiHttpClient>(),
          tokenManager: injector.get(),
        ),
      )
      ..registerCachedFactory<AuthRepository>(
        () => DefaultAuthRepository(
          authRemoteDataSource: injector.get(),
          userLocalDataSource: injector.get(),
        ),
      );
  }

  void _registerDomainDependencies(GetIt injector) {
    injector
      ..registerCachedFactory(
        () => ValidateEmail(logger: injector.get()),
      )
      ..registerCachedFactory(
        () => ValidatePassword(logger: injector.get()),
      )
      ..registerCachedFactory(
        () => SignIn(logger: injector.get(), authRepository: injector.get()),
      )
      ..registerCachedFactory(
        () => SignUp(logger: injector.get(), repository: injector.get()),
      );
  }
}
