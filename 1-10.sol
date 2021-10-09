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
        
    }

}

/*
    반환 return
    솔리디티에서 함수 선언은 반환값 종류를 포함한다.

    함수 제어자
    view 와 pure 가 있는데 이 구분이 어려울 수 있다. 근데 이건 컴파일러에서 잘 알려준다고 한다.

    1. view 함수로 선언. 
    이는 함수가 데이터를 보기만 하고 변경하지 않는다는 뜻
    function sayHello() public view returns (string) { }

    2. pure 함수로 선언
    pure 함수는 앱에서 어떤 데이터도 접근하지 않는 것을 의미한다. 
    function _multiply(uint a, uint b) private pure returns (uint) {
        return a * b;
    }


    function _generateRandomDna(string _str) private view returns(unit){}
    function 함수명(전달인자형태 변수명) private/public view/pure returns(반환인자값형태){}

    generateRandomDna라는 private 함수를 만든다. 
    이 함수는 _str (string형)을 인자로 전달받고, 
    uint을 반환해야 하네.

    이 함수는 컨트랙트 변수를 보지만 
    변경하지는 않을 것이므로 view로 선언한다.
*/
