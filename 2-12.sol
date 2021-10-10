pragma solidity ^0.4.19;

import "./zombiefactory.sol";

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KittyInterface kittyContract = KittyInterface(ckAddress);

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna);
  }

}


/* 
다수의 반환값 처리하기

feedOnKitty라는 함수를 생성한다. 이 함수는 _zombieId와 _kittyId라는 uint 인자 값 2개를 전달받고, public 함수로 선언되어야 한다.

이 함수는 kittyDna라는 uint를 먼저 선언해야 한다.

참고: KittyInterface 인터페이스에서 genes은 uint256형이지만, 레슨 1에서 배웠던 내용을 되새겨 보면 uint는 uint256의 다른 표현으로, 서로 동일하지.

그 다음, 이 함수는 _kittyID를 전달하여 kittyContract.getKitty 함수를 호출하고 genes을 kittyDna에 저장해야 한다.getKitty가 다수의 변수를 반환한다는 사실을 기억할 것 (정확히 말하자면 10개의 변수를 반환한다). 하지만 우리가 관심 있는 변수는 마지막 변수인 genes이다. 쉼표 수를 유심히 세어 보기 바란다!

마지막으로 이 함수는 feedAndMultiply를 호출하고 이 때 _zombieId와 kittyDna를 전달해야 한다.

설명대로만 하면 된다.



*/

// 다

function multipleReturns() internal returns(uint a, uint b, uint c) {
  return (1, 2, 3);
}

function processMultipleReturns() external {
  uint a;
  uint b;
  uint c;
  // 다음과 같이 다수 값을 할당한다:
  (a, b, c) = multipleReturns();
}

// 혹은 단 하나의 값에만 관심이 있을 경우: 
function getLastReturnValue() external {
  uint c;
  // 다른 필드는 빈칸으로 놓기만 하면 된다: 
  (,,c) = multipleReturns();
}