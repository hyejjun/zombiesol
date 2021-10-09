//Keccak256과 형 변환

pragma solidity ^0.4.19;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    } 

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }
}

/*
설명이 자세히 나와있어서 풀 수 있었다.

1. keccak256 이라는 내장함수를 사용해서 입력 스트링을 랜덤 16진수로 매핑해 해쉬값을 반환해주는 함수이다.

사용은 
keccak256("aaaa")
이렇게 하면된다.


2. 형 변환
형 변환 자료형을 강제로 변환시켜준다.
uint a=5;
uint8(a);
이렇게 하면 uint8 로 형변환 가능하다.

3. 문풀
_str을 256 해쉬값으로 만들고 uint 형변환 한것을 rand 라는 변수에 넣음

그리고 return 값으로 rand를 주는데 16자리를 만들어줘야 하므로 모듈로를 사용,
return _str % dnaModules;
이렇게 하면 된다.


*/
