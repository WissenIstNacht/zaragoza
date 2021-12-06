/*
 * SPDX-License-Identifier:    MIT
 */

pragma solidity ^0.8.0;

import "./../DAO.sol";

contract PackageRegistry {
    string private constant ERROR_INVALID_BUMP = "MARKETPLACE_INVALID_BUMP";

    /** The data model for the versioning of packages:
    versionsNextIndex
        Voting
            3 (gets incremented)
    versions
        Voting
            0 => { base1, cid1, 0.1.0}
            1 => { base1, cid2, 0.1.1}
            2 => { base2, cid3, 1.0.0}

    versionIdForSemantic
        Voting
            0.1.0 => 0
            0.1.1 => 1
            1.0.0 => 2

    latestVersionIdForContract
        Voting
            base1 => 0
            base1 => 1
            base2 => 2
    */
    struct Package {
        bytes32 packageType;
        bool verified;
        uint256 versionsNextIndex;
        mapping(uint256 => Version) versions;
        mapping(bytes32 => uint256) versionIdForSemantic;
        mapping(address => uint256) latestVersionId;
    }

    struct Version {
        uint16[3] semanticVersion;
        address contractAddress;
        bytes contentURI; // contains metadata.json, arapp.json, ui folder. 
    }
    
    mapping (bytes32 => Package) internal packages;
    bytes32[] packageTypes; 

    event RegisterNewPackage(bytes32 packageName, uint256 versionId);
    
    /// @notice Registers a new package in the Aragon Registry.
    /// @dev Registers a new package by his name.
    /// @param _packageName The name of the package
    /// @param _baseContract The base contract used for the proxy pattern
    /// @param _contentURI The URI for all the static files as UI components. This package data will be stored on IPFS. 
    /// @param _newSemanticVersion the version of the package as array with three items (Major, Minor, Patch)
    function register(
        bytes32 _packageName, 
        address _baseContract, 
        bytes memory _contentURI,
        uint16[3] memory _newSemanticVersion
    ) external {
        Package storage package = packages[_packageName];

        require(
            isValidBump(
                package.versions[package.versionsNextIndex].semanticVersion,
                _newSemanticVersion
            ),
            ERROR_INVALID_BUMP
        );

        uint256 versionId = package.versionsNextIndex++;
        package.versions[versionId] = Version(_newSemanticVersion, _baseContract, _contentURI);

        package.versionIdForSemantic[semanticVersionHash(_newSemanticVersion)] = versionId;
        package.latestVersionId[_baseContract] = versionId;

        emit RegisterNewPackage(_packageName, versionId);
    }

    function getLatest(bytes32 _packageName) 
        public 
        view 
        returns (uint16[3] memory semanticVersion, address contractAddress, bytes memory contentURI)
    {
        return getByVersionId(
            _packageName,
            packages[_packageName].versionsNextIndex
        );
    }

    function getLatestForContractAddress(bytes32 _packageName, address _contractAddress)
        public
        view
        returns (uint16[3] memory semanticVersion, address contractAddress, bytes memory contentURI)
    {
        return getByVersionId(
            _packageName, 
            packages[_packageName].latestVersionId[_contractAddress]
        );
    }

    function getBySemanticVersion(bytes32 _packageName, uint16[3] memory _semanticVersion)
        public
        view
        returns (uint16[3] memory semanticVersion, address contractAddress, bytes memory contentURI)
    {
        return getByVersionId(
            _packageName,
            packages[_packageName].versionIdForSemantic[semanticVersionHash(_semanticVersion)]
        );
    }

    function getByVersionId(bytes32 _packageName, uint _versionId) 
        public 
        view 
        returns (uint16[3] memory semanticVersion, address contractAddress, bytes memory contentURI) 
    {
        Version storage version = packages[_packageName].versions[_versionId];
        return (version.semanticVersion, version.contractAddress, version.contentURI);
    }

    function getVersionsCount(bytes32 _packageName) public view returns (uint256) {
        return packages[_packageName].versionsNextIndex;
    }
    
    function isValidBump(uint16[3] memory _oldVersion, uint16[3] memory _newVersion) public pure returns (bool) {
        bool hasBumped;
        uint i = 0;
        while (i < 3) {
            if (hasBumped) {
                if (_newVersion[i] != 0) {
                    return false;
                }
            } else if (_newVersion[i] != _oldVersion[i]) {
                if (_oldVersion[i] > _newVersion[i] || _newVersion[i] - _oldVersion[i] != 1) {
                    return false;
                }
                hasBumped = true;
            }
            i++;
        }
        return hasBumped;
    }

    function semanticVersionHash(uint16[3] memory version) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(version[0], version[1], version[2]));
    }
}
