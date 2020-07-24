// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_helper.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Day extends DataClass implements Insertable<Day> {
  final String id;
  final String date;
  final String achievementsString;
  final String betterString;
  final int rating;
  final String highlightString;
  Day(
      {@required this.id,
      @required this.date,
      this.achievementsString,
      @required this.betterString,
      @required this.rating,
      @required this.highlightString});
  factory Day.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Day(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      date: stringType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      achievementsString: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}achievements_string']),
      betterString: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}better_string']),
      rating: intType.mapFromDatabaseResponse(data['${effectivePrefix}rating']),
      highlightString: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}highlight_string']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || achievementsString != null) {
      map['achievements_string'] = Variable<String>(achievementsString);
    }
    if (!nullToAbsent || betterString != null) {
      map['better_string'] = Variable<String>(betterString);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<int>(rating);
    }
    if (!nullToAbsent || highlightString != null) {
      map['highlight_string'] = Variable<String>(highlightString);
    }
    return map;
  }

  DaysCompanion toCompanion(bool nullToAbsent) {
    return DaysCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      achievementsString: achievementsString == null && nullToAbsent
          ? const Value.absent()
          : Value(achievementsString),
      betterString: betterString == null && nullToAbsent
          ? const Value.absent()
          : Value(betterString),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      highlightString: highlightString == null && nullToAbsent
          ? const Value.absent()
          : Value(highlightString),
    );
  }

  factory Day.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Day(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      achievementsString:
          serializer.fromJson<String>(json['achievementsString']),
      betterString: serializer.fromJson<String>(json['betterString']),
      rating: serializer.fromJson<int>(json['rating']),
      highlightString: serializer.fromJson<String>(json['highlightString']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'achievementsString': serializer.toJson<String>(achievementsString),
      'betterString': serializer.toJson<String>(betterString),
      'rating': serializer.toJson<int>(rating),
      'highlightString': serializer.toJson<String>(highlightString),
    };
  }

  Day copyWith(
          {String id,
          String date,
          String achievementsString,
          String betterString,
          int rating,
          String highlightString}) =>
      Day(
        id: id ?? this.id,
        date: date ?? this.date,
        achievementsString: achievementsString ?? this.achievementsString,
        betterString: betterString ?? this.betterString,
        rating: rating ?? this.rating,
        highlightString: highlightString ?? this.highlightString,
      );
  @override
  String toString() {
    return (StringBuffer('Day(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('achievementsString: $achievementsString, ')
          ..write('betterString: $betterString, ')
          ..write('rating: $rating, ')
          ..write('highlightString: $highlightString')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          date.hashCode,
          $mrjc(
              achievementsString.hashCode,
              $mrjc(betterString.hashCode,
                  $mrjc(rating.hashCode, highlightString.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Day &&
          other.id == this.id &&
          other.date == this.date &&
          other.achievementsString == this.achievementsString &&
          other.betterString == this.betterString &&
          other.rating == this.rating &&
          other.highlightString == this.highlightString);
}

class DaysCompanion extends UpdateCompanion<Day> {
  final Value<String> id;
  final Value<String> date;
  final Value<String> achievementsString;
  final Value<String> betterString;
  final Value<int> rating;
  final Value<String> highlightString;
  const DaysCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.achievementsString = const Value.absent(),
    this.betterString = const Value.absent(),
    this.rating = const Value.absent(),
    this.highlightString = const Value.absent(),
  });
  DaysCompanion.insert({
    @required String id,
    @required String date,
    this.achievementsString = const Value.absent(),
    @required String betterString,
    @required int rating,
    @required String highlightString,
  })  : id = Value(id),
        date = Value(date),
        betterString = Value(betterString),
        rating = Value(rating),
        highlightString = Value(highlightString);
  static Insertable<Day> custom({
    Expression<String> id,
    Expression<String> date,
    Expression<String> achievementsString,
    Expression<String> betterString,
    Expression<int> rating,
    Expression<String> highlightString,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (achievementsString != null) 'achievements_string': achievementsString,
      if (betterString != null) 'better_string': betterString,
      if (rating != null) 'rating': rating,
      if (highlightString != null) 'highlight_string': highlightString,
    });
  }

  DaysCompanion copyWith(
      {Value<String> id,
      Value<String> date,
      Value<String> achievementsString,
      Value<String> betterString,
      Value<int> rating,
      Value<String> highlightString}) {
    return DaysCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      achievementsString: achievementsString ?? this.achievementsString,
      betterString: betterString ?? this.betterString,
      rating: rating ?? this.rating,
      highlightString: highlightString ?? this.highlightString,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (achievementsString.present) {
      map['achievements_string'] = Variable<String>(achievementsString.value);
    }
    if (betterString.present) {
      map['better_string'] = Variable<String>(betterString.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (highlightString.present) {
      map['highlight_string'] = Variable<String>(highlightString.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DaysCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('achievementsString: $achievementsString, ')
          ..write('betterString: $betterString, ')
          ..write('rating: $rating, ')
          ..write('highlightString: $highlightString')
          ..write(')'))
        .toString();
  }
}

class $DaysTable extends Days with TableInfo<$DaysTable, Day> {
  final GeneratedDatabase _db;
  final String _alias;
  $DaysTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedTextColumn _date;
  @override
  GeneratedTextColumn get date => _date ??= _constructDate();
  GeneratedTextColumn _constructDate() {
    return GeneratedTextColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _achievementsStringMeta =
      const VerificationMeta('achievementsString');
  GeneratedTextColumn _achievementsString;
  @override
  GeneratedTextColumn get achievementsString =>
      _achievementsString ??= _constructAchievementsString();
  GeneratedTextColumn _constructAchievementsString() {
    return GeneratedTextColumn(
      'achievements_string',
      $tableName,
      true,
    );
  }

  final VerificationMeta _betterStringMeta =
      const VerificationMeta('betterString');
  GeneratedTextColumn _betterString;
  @override
  GeneratedTextColumn get betterString =>
      _betterString ??= _constructBetterString();
  GeneratedTextColumn _constructBetterString() {
    return GeneratedTextColumn(
      'better_string',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ratingMeta = const VerificationMeta('rating');
  GeneratedIntColumn _rating;
  @override
  GeneratedIntColumn get rating => _rating ??= _constructRating();
  GeneratedIntColumn _constructRating() {
    return GeneratedIntColumn(
      'rating',
      $tableName,
      false,
    );
  }

  final VerificationMeta _highlightStringMeta =
      const VerificationMeta('highlightString');
  GeneratedTextColumn _highlightString;
  @override
  GeneratedTextColumn get highlightString =>
      _highlightString ??= _constructHighlightString();
  GeneratedTextColumn _constructHighlightString() {
    return GeneratedTextColumn(
      'highlight_string',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, date, achievementsString, betterString, rating, highlightString];
  @override
  $DaysTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'days';
  @override
  final String actualTableName = 'days';
  @override
  VerificationContext validateIntegrity(Insertable<Day> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('achievements_string')) {
      context.handle(
          _achievementsStringMeta,
          achievementsString.isAcceptableOrUnknown(
              data['achievements_string'], _achievementsStringMeta));
    }
    if (data.containsKey('better_string')) {
      context.handle(
          _betterStringMeta,
          betterString.isAcceptableOrUnknown(
              data['better_string'], _betterStringMeta));
    } else if (isInserting) {
      context.missing(_betterStringMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating'], _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('highlight_string')) {
      context.handle(
          _highlightStringMeta,
          highlightString.isAcceptableOrUnknown(
              data['highlight_string'], _highlightStringMeta));
    } else if (isInserting) {
      context.missing(_highlightStringMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Day map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Day.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $DaysTable createAlias(String alias) {
    return $DaysTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $DaysTable _days;
  $DaysTable get days => _days ??= $DaysTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [days];
}
