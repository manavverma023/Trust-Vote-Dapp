import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

class Blockchain {
  
  String contractName = 'Voting';
  
  Future<DeployedContract> getContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = '0xC5507ba335516D95200640C4BA9D1082996cAECD';

    DeployedContract contract = DeployedContract(
      ContractAbi.fromJson(abi, contractName),
      EthereumAddress.fromHex(contractAddress),
    );

    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args, Web3Client ethereumClient) async {
    DeployedContract contract = await getContract();
    ContractFunction function = contract.function(functionName);
    List<dynamic> result = await ethereumClient.call(
        contract: contract, function: function, params: args);
    return result;
  }

  Future<String> transaction(String functionName, List<dynamic> args, Web3Client ethereumClient, String privateKey) async {
    EthPrivateKey credential = EthPrivateKey.fromHex(privateKey);
    DeployedContract contract = await getContract();
    ContractFunction function = contract.function(functionName);
    print(contract);
    print(function);
    print(args);
    dynamic result = await ethereumClient.sendTransaction(
      credential,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: args,
        maxGas: 3000000,
        gasPrice: EtherAmount.inWei(BigInt.from(1000000)),
    
      ),
      fetchChainIdFromNetworkId: true,
      chainId: null,
    );

    return result;
  }


  
  
}