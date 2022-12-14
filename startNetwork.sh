#!/bin/bash
../fabric-samples/test-network/network.sh down
../fabric-samples/test-network/network.sh up createChannel -c lex-pharmacies

../fabric-samples/test-network/network.sh deployCC -c lex-pharmacies -ccn basic -ccp ../../cs395_files/chaincode/chaincode-go -ccl go

export PATH=${PWD}/../fabric-samples/bin:$PATH
export FABRIC_CFG_PATH=$PWD/../fabric-samples/config/

# Environment variables to run chaincode tests from Org1

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../fabric-samples/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C lex-pharmacies -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"InitLedger","Args":[]}'
sleep 1

peer chaincode query -C lex-pharmacies -n basic -c '{"Args":["GetAllAssets"]}'

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../fabric-samples/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C lex-pharmacies -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"TransferAsset","Args":["drug1", "CVS"]}'
sleep 1
peer chaincode query -C lex-pharmacies -n basic -c '{"Args":["GetAllAssets"]}'

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../fabric-samples/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C lex-pharmacies -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"TransferAsset","Args":["drug1", "Travis"]}'
sleep 1
peer chaincode query -C lex-pharmacies -n basic -c '{"Args":["GetAllAssets"]}'