//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import {Base64} from "./Base64.sol";

contract ValNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    constructor() ERC721 ("ValNFT", "Valo") {

    }

    function mintNFT() public {
        
    uint256 newItemId = _tokenIds.current();
    uint256 no = newItemId++;
    string memory serialNo = string(abi.encodePacked(no, ".", "svg"));

    _safeMint(msg.sender, newItemId);
    string memory json = string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "Valo", "description": "A valNFT collection", "image":"',
                                "https://ipfs.io/ipfs/QmaAjEJnvsz4n8oeVjmEHgogSEexF8yQoqAmF9ZLH9Df3u/",
                                serialNo,
                                '"}'
                            )
                        )
                    )
                )
            );
    _setTokenURI(newItemId, json);

    _tokenIds.increment();
    }
}