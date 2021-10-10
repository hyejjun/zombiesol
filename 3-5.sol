pragma solidity ^0.4.19;
import "./ownable.sol";
contract ZombieFactory is Ownable {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Zombie {
      string name;
      uint dna;
      uint32 level;
      uint32 readyTime;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime))) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createZombie(_name, randDna);
    }

}

/*
cooldownTime이라는 uint 변수를 선언하고, 여기에 1 days를 대입하게.(문법적으로 이상하게 보여도 넘어가게. 자네가 "1 day"를 대입한다면, 컴파일이 되지 않을 것일세!)

우리가 이전 챕터에서 우리의 Zombie 구조체에 level과 readyTime을 추가했으니, 우린 Zombie 구조체를 생성할 때 함수의 인수 개수가 정확히 맞도록 _createZombie() 함수를 업데이트해야 하네.

코드의 zombies.push 줄에 2개의 인수를 더 사용하도록 업데이트하게: 1(level에 사용), uint32(now + cooldownTime)(readyTime에 사용).

참고: now가 기본적으로 uint256을 반환하기 때문에, uint32(.




*/


uint lastUpdated;

// `lastUpdated`를 `now`로 설정
function updateTimestamp() public {
  lastUpdated = now;
}

// 마지막으로 `updateTimestamp`가 호출된 뒤 5분이 지났으면 `true`를, 5분이 아직 지나지 않았으면 `false`를 반환
function fiveMinutesHavePassed() public view returns (bool) {
  return (now >= (lastUpdated + 5 minutes));
}