#!/usr/bin/env bash

mkdir -p consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com
createMSPPeer0() {
  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp --csr.hosts peer0.org2.example.com --tls.certfiles ${PWD}/consortium/fabric-ca/org2/tls-cert.pem
  sleep 2

  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/msp/config.yaml ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls --enrollment.profile tls --csr.hosts peer0.org2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/org2/tls-cert.pem

  sleep 2
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/signcerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/server.crt
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/keystore/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/server.key

  mkdir ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/msp/tlscacerts
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/tlsca
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/tlsca/tlsca.org2.example.com-cert.pem

  mkdir ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/ca
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp/cacerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/ca/ca.org2.example.com-cert.pem

}
createMSPPeer1() {
  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/msp --csr.hosts peer1.org2.example.com --tls.certfiles ${PWD}/consortium/fabric-ca/org2/tls-cert.pem

  sleep 2
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/msp/config.yaml ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls --enrollment.profile tls --csr.hosts peer1.org2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/consortium/fabric-ca/org2/tls-cert.pem
  sleep 2

  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/tlscacerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/signcerts/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.crt
  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/keystore/* ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.key
}
generateUserMSP() {
  mkdir -p consortium/crypto-config-ca/peerOrganizations/org2.example.com/users
  mkdir -p consortium/crypto-config-ca/peerOrganizations/org2.example.com/users/User1@org2.example.com

  echo consortium/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/msp --csr.hosts peer1.org2.example.com --tls.certfiles ${PWD}/consortium/fabric-ca/org2/tls-cert.pem

  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/users/User1@org2.example.com/msp --tls.certfiles ${PWD}/consortium/fabric-ca/org2/tls-cert.pem
  sleep 2

  mkdir -p consortium/crypto-config-ca/peerOrganizations/org2.example.com/users/Admin@org2.example.com

}
generateAdminMSP() {
  echo
  echo "## Generate the org admin msp"
  echo

  fabric-ca-client enroll -u https://org2admin:org2adminpw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp --tls.certfiles ${PWD}/consortium/fabric-ca/org2/tls-cert.pem

  cp ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/msp/config.yaml ${PWD}/consortium/crypto-config-ca/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp/config.yaml
}
createMSPPeer0
createMSPPeer1
generateUserMSP
generateAdminMSP
# docker-compose -f docker-compose-peer.yaml up -d
# docker ps -a