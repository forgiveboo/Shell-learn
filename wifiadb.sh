#/bash/bin
# 该脚本用于开启Tasker的WFI ADB权限
echo "使用该脚本之前你需要做3件事："
echo "1. 在Termux中安装android-tools"
echo "2. 打开手机上的开发者模式和无线调试"
echo "3. 查看无线调试中的ip和端口以及配对码中的ip和端口并记住"

echo "输入配对码ip："
read ip1
echo "输入配对码port："
read port1
adb pair "$ip1:$port1"
results_pair = `adb pair "$ip1:$port1"`
if [[$results_pair =~ "Successfully"]]
then
  echo "配对完成"
else
  echo "配对失败，请检查ip以及port是否正确并重试"
  exit 1
fi

echo "输入无线调试ip："
read ip2
echo "输入无线调试port："
read port2
adb connect $ip2:$port2
results_connect = `adb connect $ip2:$port2`
if [[$results_connect =~ "connected"]]
then
  echo"连接成功"
else
  echo "连接失败，请检查ip以及port是否正确并重试"
  exit 1
fi

adb tcpip 5555
results_tcpip = `adb tcpip 5555`
if [[$results_tcpip =~ "5555"]]
then
  echo "WIFI ADB已开启"
else
  echo "权限开启失败，请重试"
  exit 1
fi
