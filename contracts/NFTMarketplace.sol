// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTMarketplace is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Item {
        uint256 id;
        address creator;
        string uri;
    }

    mapping(uint256 => Item) public items;

    constructor() ERC721("NFTMarketplace", "NFTM") {}

    function createToken(string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        items[newItemId] = Item({
            id: newItemId,
            creator: msg.sender,
            uri: tokenURI
        });

        return newItemId;
    }

    function getCurrentTokenId() public view returns (uint256) {
        return _tokenIds.current();
    }
} 