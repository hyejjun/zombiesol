pragma solidity ^0.4.19;
import "./ownable.sol";
contract ZombieFactory is Ownable {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

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
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
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
/**
자, 그럼 다시 zombiefactory.sol으로 돌아가지.

우리의 Zombie 구조체에 2개의 속성을 더 추가하게: level(uint32)과 readyTime(마찬가지로 uint32)를 말이지. 우리는 이 데이터 타입들을 압축하길 원하니, 이 둘을 구조체의 마지막 부분에 쓰게.
좀비의 레벨과 시간 데이터(Timestamp)를 저장하는 데에는 충분하고도 남는 크기이니, 이렇게 하면 보통의 uint(256비트)를 쓰는 것보다 데이터를 더 압축해서 가스 비용을 줄이도록 해줄 것이네.

*/