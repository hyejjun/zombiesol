pragma solidity ^0.4.19;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }

  function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }
}
/*
changeName이라는 함수를 만들게. 이 함수는 2개의 인수를 받을 것이네: _zombieId(uint), _newName(string). 그리고 함수를 external로 만들게. 이 함수는 aboveLevel 제어자를 가져야 하고, _level에 2라는 값을 전달해야 하네. _zombieId 또한 전달하는 것을 잊지 말게나.

함수의 내용에서는, 먼저 우리는 msg.sender가 zombieToOwner[_zombieId]와 같은지 검증해야 하네. require 문장을 사용하게.

그리고 나서 이 함수에서는 zombies[_zombieId].name에 _newName을 대입해야 하네.

changeName 아래에 changeDna라는 또다른 함수를 만들게. 그리고 함수를 external로 만들게. 이 함수의 정의와 내용은 changeName과 거의 똑같지만, 두 번째 인수가 _newDna(uint)이고, aboveLevel의 _level 매개 변수에 20을 전달해야 할 것이네. 물론, 이 함수는 좀비의 이름을 설정하는 것 대신에 좀비의 dna를 _newDna로 설정해야 하겠지.


*/

// 사용자의 나이를 저장하기 위한 매핑
mapping (uint => uint) public age;

// 사용자가 특정 나이 이상인지 확인하는 제어자
modifier olderThan(uint _age, uint _userId) {
  require (age[_userId] >= _age);
  _;
}

// 차를 운전하기 위햐서는 16살 이상이어야 하네(적어도 미국에서는).
function driveCar(uint _userId) public olderThan(16, _userId) {
  // 필요한 함수 내용들
}