pragma solidity ^0.4.19;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    _createZombie("NoName", newDna);
  }

}

/*
    자리수 맞춰주고
    평균내서 
    함수 호출임

*/


Internal과 External
public과 private 이외에도 솔리디티에는 internal과 external이라는 함수 접근 제어자가 있지.

internal은 함수가 정의된 컨트랙트를 상속하는 컨트랙트에서도 접근이 가능하다 점을 제외하면 private과 동일하지. **(우리한테 필요한 게 바로 internal인 것 같군!

external은 함수가 컨트랙트 바깥에서만 호출될 수 있고 컨트랙트 내의 다른 함수에 의해 호출될 수 없다는 점을 제외하면 public과 동일하지. 나중에 external과 public이 각각 왜 필요한지 살펴 볼 것이네.

interal이나 external 함수를 선언하는 건 private과 public 함수를 선언하는 구문과 동일하네:

contract Sandwich {
  uint private sandwichesEaten = 0;

  function eat() internal {
    sandwichesEaten++;
  }
}

contract BLT is Sandwich {
  uint private baconSandwichesEaten = 0;

  function eatWithBacon() public returns (string) {
    baconSandwichesEaten++;
    // eat 함수가 internal로 선언되었기 때문에 여기서 호출이 가능하다 
    eat();
  }
}

/*
  private 함수는 아무리 상속 받았다해도 접근 못함 그래서 
  internal로 바꿔줌

*/