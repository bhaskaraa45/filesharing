import 'package:network_info_plus/network_info_plus.dart';

class WifiInfo {
  getIpV4Address() async {
    final info = NetworkInfo();
    final wifiIP = await info.getWifiIP();
    return wifiIP;
  }
  // getIpV6Address()async{
  //   final wifiIP = await info.getWifiIPv6();
  //   return wifiIP;
  // }
}
