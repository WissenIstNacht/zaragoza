/*
 * SPDX-License-Identifier:    MIT
 */

pragma solidity ^0.8.0;

contract Installer {
    event InstallAppOnDAO(address dao, bytes32 appName, address base);


    
    function install(address dao, bytes32 _appName) external {
        /*require(versions[_appName][0].contractAddress != address(0), "App Doesn't exist");
        (, address contractAddress, ) = getLatest(_appName);
        emit InstallAppOnDAO(dao, _appName, contractAddress);*/
    }
}