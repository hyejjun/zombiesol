pragma solidity ^0.4.19;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

/*
    이거는 좀 어려웠다...
    이벤트는 자네의 컨트랙트가 블록체인 상에서 자네 앱의 사용자 단에서 무언가 액션이 발생했을 때 의사소통하는 방법이지.

    이벤트라는게 있고...
    그걸 맨 첨에 선언해줘야하고

    어떤 함수에서 
    이벤트 호출해줘야함

    그리고 조금 이해가 어려웠던것은 arr.push 를 한 리턴값이 배열의 길이라는것.
    그래서 인덱스 값을 구하려면 길이-1 을 해줘야한다는... 암튼 그건 첨 알았고 
    길이 -1 한 것을 id 로 저장해서 이벤트 호출할때 사용했다.

*/