interface IMathUtilsHuff {
	function factorial(uint256) external pure returns (uint256);
	function getNumber() external view returns (uint256);
	function setNumber(uint256) external;
	function square(uint256) external pure returns (uint256);
}