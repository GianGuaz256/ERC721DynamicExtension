// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Collection1 is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;


    Counters.Counter private _tokenIdCounter;
    
    // Mapping from token ID to dynamicData
    mapping(uint256=>string[]) private dynamicData;

    constructor() ERC721("Collection1", "CLL1") {}

    modifier onlyTokenOwner(uint256 _tokenId){
        require(ownerOf(_tokenId)==msg.sender, "Sender is not the owner of the token");
        _;
    }

    function safeMint(address to, string memory _uri) public onlyOwner {
        _safeMint(to, _tokenIdCounter.current());
        _setTokenURI(_tokenIdCounter.current(), _uri);
        _tokenIdCounter.increment();
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
    
    /**
     * @dev Add a DynamicData to the array of a specific 'tokenId'.
     *
     * Tokens dynamicData can only be managed by the owner of that token.
     *
     * DynamicData can only be pushed into the array and not popped. 
     * Check first if the token exists and then add data. 
     */
    function addDataToDynamicNFT(uint256 _tokenId, string memory _data) public onlyTokenOwner(_tokenId) {
        require(_exists(_tokenId), "ERC721URIStorage: URI set of nonexistent token");
        dynamicData[_tokenId].push(_data);
    }
    
    /**
     * @dev Returns the DynamicData of a specific 'tokenId'.
     *
     * Tokens dynamicData can be seen by everybody in order to make it a standard for marketplace.
     * 
     * Check first if the token exists and then return the dynamicData. 
     */
    function getDynamiData(uint256 _tokenId) external view returns(string[] memory) {
        require(_exists(_tokenId), "ERC721URIStorage: URI set of nonexistent token");
        return dynamicData[_tokenId];
    }
    
    /**
     * @dev Returns the current tokenId counter.
     */
    function getTokenIdsCount() external view returns(uint256) {
        return _tokenIdCounter.current();
    }
}