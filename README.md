<h1 align="center">
	ERC721DynamicExtension
</h1>

<p align="center">
  <a href="" target="blank"><img src="https://drive.google.com/file/d/1pwYdPMii55YuhIJHgxtc0wNlu5Nbytxh/view?usp=sharing" width="350" alt="DynamicNFT" /></a>
</p>

<p align="center" style="margin: 10px">A Smart Contract that allows you to add stories to a given non-fungible token. The tokens developed start from <a href="https://docs.openzeppelin.com/contracts/4.x/erc721">OpenZeppelin</a> code on ERC721 with URIStorage extension and are therefore fully compatible with <a href="https://opensea.io/">Opensea</a> and the various marketplaces. Below you can find an explanation of the functions and state variables.</p>

<h2>
	State Variables
</h2>

When the token is minted the contract creates a state variable that tracks the stories for each tokenId present. 

```bash
mapping(uint256=>string[]) private dynamicData;
```

<h2>
	Modifier
</h2>

Modifier that checks if the msg.sender of the transaction is the owner of that particular tokenId in order to push new dynamicData inside the array.

```
modifier onlyTokenOwner(uint256 _tokenId){
        require(ownerOf(_tokenId)==msg.sender, "Sender is not the owner of the token");
        _;
}
```

<h2>
	Functions
</h2>

### Add Dynamic Data 

Function that adds a new story or dynamic data to the array of string. It takes the _**tokenId**_ of the token to be modified and the _**data**_ string pointing to the IPFS in order to store metadata.

```
function addDataToDynamicNFT(uint256 _tokenId, string memory _data) public onlyTokenOwner(_tokenId) {
        require(_exists(_tokenId), "ERC721URIStorage: URI set of nonexistent token");
        dynamicData[_tokenId].push(_data);
}
```

### Get Dynamic Data

Function that retrieves data from a particular token. It takes the _**tokenId**_ and return an array of string pointing to the metadata in the IPFS.

```
function getDynamiData(uint256 _tokenId) external view returns(string[] memory) {
        require(_exists(_tokenId), "ERC721URIStorage: URI set of nonexistent token");
        return dynamicData[_tokenId];
}
```

<h2>
	Stay in touch
</h2>

Author: Guazzo Gianmarco
- <a href="https://www.linkedin.com/in/gianmarco-guazzo/">LinkedIn</a>
- <a href="https://www.blockacademy.it/">Website</a>
- <a href="https://guazzogianmarco.medium.com/">Medium</a>