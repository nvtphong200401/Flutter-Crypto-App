import 'dart:async';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wallet_notifier.freezed.dart';

@freezed
class WalletModel with _$WalletModel {
  const WalletModel._();
  const factory WalletModel({
    @Default('') String address,
    @Default(0) double balance,
  }) = _WalletModel;
}

@riverpod
class WalletNotifier extends AsyncNotifier<WalletModel> {
  final _dio = Dio();

  @override
  FutureOr<WalletModel> build() async {
    final balance = await getBalance();
    final address = await getAddress();
    return WalletModel(address: address, balance: balance);
  }

  Future getBalance() async {
    final response = await _dio.get('api/balance');
    return response.data['balance'];
  }

  Future getAddress() async {
    final response = await _dio.get('api/balance');
    return response.data['address'];
  }
}
