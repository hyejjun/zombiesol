함수 제어자
함수 제어자는 함수처럼 보이지만, function 키워드 대신 modifier 키워드를 사용한다네. 그리고 자네가 함수를 호출하듯이 직접 호출할 수는 없지. 대신에 함수 정의부 끝에 해당 함수의 작동 방식을 바꾸도록 제어자의 이름을 붙일 수 있네.

onlyOwner를 살펴보면서 더 자세히 알아보도록 하지.

/**
 * @dev Throws if called by any account other than the owner.
 */
modifier onlyOwner() {
  require(msg.sender == owner);
  _;
}
우리는 이 제어자를 다음과 같이 사용할 것이네:

contract MyContract is Ownable {
  event LaughManiacally(string laughter);

  // 아래 `onlyOwner`의 사용 방법을 잘 보게:
  function likeABoss() external onlyOwner {
    LaughManiacally("Muahahahaha");
  }
}

이거를

function _createZombie(string _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        NewZombie(id, _name, _dna);
    }