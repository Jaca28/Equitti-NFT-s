// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20Token is ERC20, AccessControl {

    address public owner;
    address masterAddress;

    /**
     * @dev Roles definition.
     */
    bytes32 public constant masterRole = keccak256("masterRole");
    bytes32 public constant userRole = keccak256("userRole");

    /**
     * @dev Temporal by test, replaced by AccessControl.
     */
    modifier onlyOwner {
        require(
            msg.sender == owner,
            "You are not the contract admin"
        );
        _;
    }

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The default value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
   
    constructor(string memory name_, string memory symbol_) ERC20(
     name_, symbol_
    ) public {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        owner = msg.sender;

    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     *
     * Requirements:
     *
     * - caller must have `DEFAULT_ADMIN_ROLE` or `master_role`
     */
    function mint(address account, uint256 amount) public {

        require(
            hasRole (DEFAULT_ADMIN_ROLE, msg.sender)
        );
        _mint(account, amount);
    }
   
}
