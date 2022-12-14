# CS395-Blockchain
A sample repository to run and desmonstrate the use of a Hyperledger Fabric blockchain to manage pharmeceutical assets

This work is built upon the fabric-samples provided by Hyperledger Fabric, and it is required to follow the installation instructions found here:
https://hyperledger-fabric.readthedocs.io/en/latest/getting_started.html

From there, make sure that this repository is located in the same location as the fabric-samples folder.

Finally, make sure that the scripts startNetwork.sh and stopNetwork.sh have executable permission by running:

chmod +x startNetwork.sh
chmod +x stopNetwork.sh

you can then run 

./startNetwork.sh 

to start the Fabric network. It automically commits a chaincode to the channel "lex-pharmacies" with methods for creating and transfering simple assets.

One oversight with this current implementation is the inability to generate multiple assets with the same id, which would be essential in a practical application of this in pharmacies.

A forward implementation might utilize fungible tokens to address this.
