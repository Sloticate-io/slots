// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SLOTS is ERC20, Ownable {

    /**
     * @dev Constructor. Derived from ERC20 standard contract.
     *      Token name: Sloticate
     *      Token Symbol: SLOTS
     */
    constructor() ERC20("Sloticate", "SLOTS") {
        _mint(msg.sender, 1e9 * 10 ** decimals());
    }

    /**
     * @dev Manually withdraw stuck tokens
     * @param _token Token address
     * @param amount Amount of tokens to transfer
     */
    function WithdrawTokens(address _token, uint256 amount) external onlyOwner {
        require (address(this) != _token, "Is not possible to withdraw own tokens.");
        bool tranferResult = IERC20(_token).transfer(owner(), amount);
        require (tranferResult, "Transfer failed!");
    }

    /**
     * @dev Manually withdraw stuck ethers
     * @param amount Amount of ethers to transfer
     */
    function WithdrawContractFunds(uint256 amount) external onlyOwner {
        sendValue(payable(owner()), amount);
    }

    /**
     * @dev Send ethers to a recipient
     * @param amount Amount of ethers to transfer
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Low balance");
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "ETH Payment failed");
    }
}