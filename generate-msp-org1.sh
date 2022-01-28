#!/usr/bin/env bash

mkdir -p consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers

createMSPPeer0() {
  # -----------------------------------------------------------------------------------
  #  Peer 0
  mkdir -p consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer0.org1.example.com

  echo
  echo "## Generate the peer0 msp"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.org1.example.com -M ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp --csr.hosts peer0.org1.example.com --tls.certfiles ${PWD}/consortium/fabric-ca/org1/tls-cert.pem

  sleep 5
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/msp/config.yaml ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.org1.example.com -M ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls --enrollment.profile tls --csr.hosts peer0.org1.example.com --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/org1/tls-cert.pem
  sleep 5
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/signcerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.crt
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/keystore/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.key

  mkdir ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/msp/tlscacerts
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/tlsca
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem

  mkdir ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/ca
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/cacerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/ca/ca.org1.example.com-cert.pem

  # ------------------------------------------------------------------------------------------------
}
createMSPPeer1() {
  # Peer1

  mkdir -p consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer1.org1.example.com

  echo
  echo "## Generate the peer1 msp"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.org1.example.com -M ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp --csr.hosts peer1.org1.example.com --tls.certfiles ${PWD}/consortium/fabric-ca/org1/tls-cert.pem

  sleep 5
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/msp/config.yaml ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.org1.example.com -M ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls --enrollment.profile tls --csr.hosts peer1.org1.example.com --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/org1/tls-cert.pem
  sleep 5
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/signcerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.crt
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/keystore/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.key

  # --------------------------------------------------------------------------------------------------

}
generateUserMSP() {
  mkdir -p consortium/crypto-config-ca/peerOrganizations/org1.example.com/users
  mkdir -p consortium/crypto-config-ca/peerOrganizations/org1.example.com/users/User1@org1.example.com

  echo
  echo "## Generate the user msp"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca.org1.example.com -M ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp --tls.certfiles ${PWD}/consortium/fabric-ca/org1/tls-cert.pem

  mkdir -p consortium/crypto-config-ca/peerOrganizations/org1.example.com/users/Admin@org1.example.com

}
generateAdminMSP() {
  echo
  echo "## Generate the org admin msp"
  echo
  fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:7054 --caname ca.org1.example.com -M ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp --tls.certfiles ${PWD}/consortium/fabric-ca/org1/tls-cert.pem

  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/msp/config.yaml ${PWD}/consortium/crypto-config-ca/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/config.yaml

}
createMSPPeer0
createMSPPeer1
generateUserMSP
generateAdminMSP
sleep 10
# docker-compose -f docker-compose-peer.yaml up -d
sleep 10
# docker ps -a