pragma solidity ^0.4.19;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
  }
}

/*
    꽤나 헷갈렸다.
    Storage vs Memory

    Storage는 블록체인 상에 영구적으로 저장되는 변수를 의미하지.
    Memory는 임시적으로 저장되는 변수로, 컨트랙트 함수에 대한 외부 호출들이 일어나는 사이에 지워지지. 

    함수 선언하고
    reqire 로 
*/

contract SandwichFactory {
  struct Sandwich {
    string name;
    string status;
  }

  Sandwich[] sandwiches;

  function eatSandwich(uint _index) public {
    // Sandwich mySandwich = sandwiches[_index];

    // ^ 꽤 간단해 보이나, 솔리디티는 여기서 
    // `storage`나 `memory`를 명시적으로 선언해야 한다는 경고 메시지를 발생한다. 
    // 그러므로 `storage` 키워드를 활용하여 다음과 같이 선언해야 한다:
    Sandwich storage mySandwich = sandwiches[_index];
    // ...이 경우, `mySandwich`는 저장된 `sandwiches[_index]`를 가리키는 포인터이다.
    // 그리고 
    mySandwich.status = "Eaten!";
    // ...이 코드는 블록체인 상에서 `sandwiches[_index]`을 영구적으로 변경한다. 

    // 단순히 복사를 하고자 한다면 `memory`를 이용하면 된다: 
    Sandwich memory anotherSandwich = sandwiches[_index + 1];
    // ...이 경우, `anotherSandwich`는 단순히 메모리에 데이터를 복사하는 것이 된다. 
    // 그리고 
    anotherSandwich.status = "Eaten!";
    // ...이 코드는 임시 변수인 `anotherSandwich`를 변경하는 것으로 
    // `sandwiches[_index + 1]`에는 아무런 영향을 끼치지 않는다. 그러나 다음과 같이 코드를 작성할 수 있다: 
    sandwiches[_index + 1] = anotherSandwich;
    // ...이는 임시 변경한 내용을 블록체인 저장소에 저장하고자 하는 경우이다.
  }
}