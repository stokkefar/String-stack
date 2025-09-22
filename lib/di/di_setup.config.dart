// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../domain/models/tuning.dart' as _i402;
import '../presentation/chord_creator/chord_creator_view_model.dart' as _i953;
import '../presentation/start/start_view_model.dart' as _i850;
import '../presentation/tabs_creator/tabs_creator_view_model.dart' as _i406;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i850.StartViewModel>(() => _i850.StartViewModel());
    gh.factoryParam<_i953.ChordCreatorViewModel, _i402.Tuning, dynamic>(
      (_tuning, _) => _i953.ChordCreatorViewModel(_tuning)..init(),
    );
    gh.factoryParam<_i406.TabsCreatorViewModel, _i402.Tuning, dynamic>(
      (_tuning, _) => _i406.TabsCreatorViewModel(_tuning),
    );
    return this;
  }
}
