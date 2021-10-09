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
    /*
    이 함수를 private로 선언하면 이 ZombieFactory contract 안에 있는 애들만 
    저 함수를 사용해서 struct 에 값을 넣어서 새로운 좀비를 만들 수 있다.

    function _함수명(타입 _변수, 타입 _변수) private{

    }
    이렇게 작성해주면 된다.
    private 혹은 지역변수의 경우 변수명 앞에 _ 언더바를 붙여주는게 관례이다.
    
    */
}

