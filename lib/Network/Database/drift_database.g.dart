part of 'drift_database.dart';

// ignore_for_file: type=lint
abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final Movies movies = Movies(this);
  @override
  Iterable<TableInfo<Table, DataClass>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, DataClass>>();
  @override
  List<TableInfo<Table, Object?>> get allSchemaEntities => [movies];
}

@DataClassName('Movie')
class Movies extends Table with TableInfo<Movies, Movie> {
  final GeneratedDatabase _db;
  final String? _alias;

  Movies(this._db, [this._alias]);

  @override
  String get aliasedName => _alias ?? 'movies';

  @override
  String get actualTableName => 'movies';

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _imageMeta = const VerificationMeta('image');
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
      'image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);

  final VerificationMeta _detailMeta = const VerificationMeta('detail');
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
      'detail', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _directorIDMeta = const VerificationMeta('directorID');
  late final GeneratedColumn<int> directorID = GeneratedColumn<int>(
      'director_i_d', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _isMovieWatchedMeta =
      const VerificationMeta('isMovieWatched');
  late final GeneratedColumn<bool> isMovieWatched =
      GeneratedColumn<bool>('is_movie_watched', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          // defaultConstraints: 'CHECK (is_movie_watched IN (0, 1))',
          defaultValue: const Constant(false));

  @override
  VerificationContext validateIntegrity(Insertable<Movie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }

    if (data.containsKey('detail')) {
      context.handle(_detailMeta,
          detail.isAcceptableOrUnknown(data['detail']!, _detailMeta));
    } else if (isInserting) {
      context.missing(_detailMeta);
    }
    if (data.containsKey('director_i_d')) {
      context.handle(
          _directorIDMeta,
          directorID.isAcceptableOrUnknown(
              data['director_i_d']!, _directorIDMeta));
    } else if (isInserting) {
      context.missing(_directorIDMeta);
    }
    if (data.containsKey('is_movie_watched')) {
      context.handle(
          _isMovieWatchedMeta,
          isMovieWatched.isAcceptableOrUnknown(
              data['is_movie_watched']!, _isMovieWatchedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Movie map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Movie.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Movies createAlias(String alias) {
    return Movies(_db, alias);
  }

  @override
  DatabaseConnectionUser get attachedDatabase => _db;

  @override
  List<GeneratedColumn> get $columns =>
      [id, image, name, detail, directorID, isMovieWatched];
}

@DataClassName('Movie')
class Movie extends DataClass implements Insertable<Movie> {
  final int id;
  final String image;
  final String name;
  final String detail;
  final int directorID;
  final bool isMovieWatched;

  Movie(
      {required this.id,
      required this.image,
      required this.name,
      required this.detail,
      required this.directorID,
      required this.isMovieWatched});

  factory Movie.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Movie(
      id: db.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      image: db.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image'])!,
      name: db.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}name']) ??
          "",
      detail: db.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}detail'])!,
      directorID: db.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}director_i_d'])!,
      isMovieWatched: db.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_movie_watched'])!,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['image'] = Variable<String>(image);
    map['name'] = Variable<String>(name);
    map['detail'] = Variable<String>(detail);
    map['director_i_d'] = Variable<int>(directorID);
    map['is_movie_watched'] = Variable<bool>(isMovieWatched);
    return map;
  }

  MoviesCompanion toCompanion(bool nullToAbsent) {
    return MoviesCompanion(
      id: Value(id),
      image: Value(image),
      name: Value(name),
      detail: Value(detail),
      directorID: Value(directorID),
      isMovieWatched: Value(isMovieWatched),
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Movie(
      id: serializer.fromJson<int>(json['id']),
      image: serializer.fromJson<String>(json['image']),
      name: serializer.fromJson<String>(json['name']),
      detail: serializer.fromJson<String>(json['detail']),
      directorID: serializer.fromJson<int>(json['directorID']),
      isMovieWatched: serializer.fromJson<bool>(json['isMovieWatched']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'image': serializer.toJson<String>(image),
      'name': serializer.toJson<String>(name),
      'detail': serializer.toJson<String>(detail),
      'directorID': serializer.toJson<int>(directorID),
      'isMovieWatched': serializer.toJson<bool>(isMovieWatched),
    };
  }

  Movie copyWith(
      {int? id,
      String? image,
      String? name,
      String? detail,
      int? directorID,
      bool? isMovieWatched}) {
    return Movie(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        detail: detail ?? this.detail,
        directorID: directorID ?? this.directorID,
        isMovieWatched: isMovieWatched ?? this.isMovieWatched);
  }

  @override
  String toString() {
    return (StringBuffer('Movie(')
          ..write('id: $id, ')
          ..write('image: $image, ')
          ..write('name: $name, ')
          ..write('detail: $detail, ')
          ..write('directorID: $directorID, ')
          ..write('isMovieWatched: $isMovieWatched')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, image, name, detail, directorID, isMovieWatched);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Movie &&
          other.id == this.id &&
          other.image == this.image &&
          other.name == this.name &&
          other.detail == this.detail &&
          other.directorID == this.directorID &&
          other.isMovieWatched == this.isMovieWatched);
}

class MoviesCompanion extends UpdateCompanion<Movie> {
  final Value<int> id;
  final Value<String> image;
  final Value<String> name;
  final Value<String> detail;
  final Value<int> directorID;
  final Value<bool> isMovieWatched;

  const MoviesCompanion(
      {this.id = const Value.absent(),
      this.image = const Value.absent(),
      this.name = const Value.absent(),
      this.detail = const Value.absent(),
      this.isMovieWatched = const Value.absent(),
      this.directorID = const Value.absent()});

  MoviesCompanion.insert({
    this.id = const Value.absent(),
    required String image,
    required String name,
    required String detail,
    required int directorID,
    this.isMovieWatched = const Value.absent(),
  })  : image = Value(image),
        name = Value(name),
        detail = Value(detail),
        directorID = Value(directorID);

  static Insertable<Movie> custom({
    Expression<int>? id,
    Expression<String>? image,
    Expression<String>? name,
    Expression<String>? detail,
    Expression<int>? directorID,
    Expression<bool>? isMovieWatched,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (image != null) 'image': image,
      if (name != null) 'name': name,
      if (detail != null) 'detail': detail,
      if (directorID != null) 'director_i_d': directorID,
      if (isMovieWatched != null) 'is_movie_watched': isMovieWatched,
    });
  }

  MoviesCompanion copyWith({
    Value<int>? id,
    Value<String>? image,
    Value<String>? name,
    Value<String>? detail,
    Value<int>? directorID,
    Value<bool>? isMovieWatched,
  }) {
    return MoviesCompanion(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      directorID: directorID ?? this.directorID,
      isMovieWatched: isMovieWatched ?? this.isMovieWatched,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (directorID.present) {
      map['director_i_d'] = Variable<int>(directorID.value);
    }
    if (isMovieWatched.present) {
      map['is_movie_watched'] = Variable<bool>(isMovieWatched.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoviesCompanion(')
          ..write('id: $id, ')
          ..write('image: $image, ')
          ..write('name: $name, ')
          ..write('detail: $detail, ')
          ..write('directorID: $directorID, ')
          ..write('isMovieWatched: $isMovieWatched')
          ..write(')'))
        .toString();
  }
}
