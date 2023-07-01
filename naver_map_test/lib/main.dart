
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  await _initialize();
  runApp(const NaverMapApp());
}

// 지도 초기화하기
Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
    clientId: 'kiy91ru4wb',     // 클라이언트 ID 설정
    onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed")
  );
}

// 현재 위치 가져오기
Future<Position> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return position;
}

class NaverMapApp extends StatelessWidget {
  const NaverMapApp({Key? key});

  @override
  Widget build(BuildContext context) {
    late NaverMapController mapController;

    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    final Completer<NaverMapController> mapControllerCompleter = Completer();


    return MaterialApp(
      home: Scaffold(
        body: NaverMap(
          options: const NaverMapViewOptions(
            indoorEnable: true,             // 실내 맵 사용 가능 여부 설정
            locationButtonEnable: false,    // 위치 버튼 표시 여부 설정
            consumeSymbolTapEvents: false,  // 심볼 탭 이벤트 소비 여부 설정
          ),
          onMapReady: (controller) async {                // 지도 준비 완료 시 호출되는 콜백 함수
            mapController = controller;
            mapControllerCompleter.complete(controller);  // Completer에 지도 컨트롤러 완료 신호 전송
            log("onMapReady", name: "onMapReady");

            //final locationOverlay = await mapController.getLocationOverlay();

            // var currentLocation = await getCurrentLocation();

            // log('${currentLocation.latitude}', name: 'currentLocation');

            final marker = NMarker(
                id: 'test',
                position:
                const NLatLng(37.506932467450326, 127.05578661133796));

            final marker1 = NMarker(
                id: 'test1',
                position:
                const NLatLng(37.606932467450326, 127.05578661133796));

            controller.addOverlayAll({marker, marker1});

            final onMarkerInfoWindow = NInfoWindow.onMarker(id: marker.info.id, text: '테스트');
            marker.openInfoWindow(onMarkerInfoWindow);

            onMarkerInfoWindow.setMinZoom(12);
            onMarkerInfoWindow.setMaxZoom(14);
            onMarkerInfoWindow.setIsMinZoomInclusive(true);
            onMarkerInfoWindow.setIsMaxZoomInclusive(false);

          },
        ),
      ),
    );
  }
}
