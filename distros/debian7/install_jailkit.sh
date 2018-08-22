#---------------------------------------------------------------------
# Function: InstallJailkit
#    Install Jailkit
#---------------------------------------------------------------------

#Program Versions
JKV="2.17"  #Jailkit Version -> Maybe this can be automated
SUM="7b5a68abe89a65e0e29458cc1fd9ad0b"

InstallJailkit() {
  echo -n "Installing Jailkit... "
  apt-get -y install build-essential autoconf automake1.9 libtool flex bison debhelper > /dev/null 2>&1
  cd /tmp
  wget -q https://olivier.sessink.nl/jailkit/jailkit-$JKV.tar.gz
  if [[ ! "$(md5sum jailkit-$JKV.tar.gz | head -c 32)" = "$SUM" ]]; then
    echo -e "${red}Error: md5sum does not match${NC}" >&2
    echo "Please try running this script again" >&2
    exit 1
  fi
  tar xfz jailkit-$JKV.tar.gz
  cd jailkit-$JKV
  ./debian/rules binary > /dev/null 2>&1
  cd ..
  dpkg -i jailkit_$JKV-1_*.deb > /dev/null 2>&1
  rm -rf jailkit-$JKV
  echo -e "${green}done! ${NC}\n"
}

