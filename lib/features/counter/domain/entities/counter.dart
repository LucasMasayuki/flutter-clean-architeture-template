import 'package:equatable/equatable.dart';

class Counter extends Equatable {
  final int value;

  const Counter({required this.value});

  Counter copyWith({
    int? value,
  }) {
    return Counter(
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [value];

  factory Counter.fromJson(Map<String, dynamic> json) {
    return Counter(value: json['value'] as int);
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}
