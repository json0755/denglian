// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataStorage {
    string private data;

    function setData(string memory newData) public {
        data = newData;
    }

    function getData() public view returns (string memory) {
        return data;
    }
}

contract DataConsumer {
    address private dataStorageAddress;

    constructor(address _dataStorageAddress) {
        dataStorageAddress = _dataStorageAddress;
    }

    function getDataByABI() public returns (string memory) {
        bytes4 selector = bytes4(keccak256("getData()"));
        bytes memory payload = abi.encode(selector);
        (bool success, bytes memory returnData) = dataStorageAddress.call(payload);
        require(success, "call function failed");
        
        // return data
        return abi.decode(returnData, (string));
    }

//补充完整setDataByABI1，使用abi.encodeWithSignature()编码调用setData函数，确保调用能够成功
    function setDataByABI1(string calldata newData) public returns (bool) {
        bytes memory payload = abi.encodeWithSignature("setData(string)", newData);
        // playload
        (bool success, ) = dataStorageAddress.call(payload);

        return success;
    }

//补充完整setDataByABI2，使用abi.encodeWithSelector()编码调用setData函数，确保调用能够成功
    function setDataByABI2(string calldata newData) public returns (bool) {
        // selector
        bytes memory payload = abi.encodeWithSelector(bytes4(keccak256("setData(string)")), newData);
        // playload

        (bool success, ) = dataStorageAddress.call(payload);

        return success;
    }

//补充完整setDataByABI3，使用abi.encodeCall()编码调用setData函数，确保调用能够成功
    function setDataByABI3(string calldata newData) public returns (bool) {
        // playload
        bytes memory payload = abi.encodeCall(DataStorage.setData, (newData));
        (bool success, ) = dataStorageAddress.call(payload);
        return success;
    }
}
