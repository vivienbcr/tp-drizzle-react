pragma solidity 0.5.16;

contract fightGame {
    mapping (address => Personnage) private _players;
    struct Personnage {
        string name;
        uint8 level;
        uint8 exp;
        uint8 strength;
        uint8 pv;
        uint8 wins;
        uint8 loses;
        bool exist;
    }

    address[] public players_adresses;
    
    address public owner;

    constructor() public {
        owner = msg.sender;
    }
//
    function random() private returns (uint256) {
        return
            uint256(
                keccak256(abi.encodePacked(block.difficulty, now, players_adresses))
            );
    }

    // CreatePlayer set new player 
    function CreatePlayer(string memory _name) public {
        //require(_players[msg.sender].exist == true, "You already have a personnage");
        _players[msg.sender] = Personnage(_name, 1, 0, 0, 100, 0, 0,true);
        players_adresses.push(msg.sender);
    }
    
    // GetPlayer return player spec
    function GetPlayer()public view returns (string memory name,uint8 level, uint8 exp, uint8 strength,uint8 pv){
        return (_players[msg.sender].name,_players[msg.sender].level,_players[msg.sender].exp,_players[msg.sender].strength,_players[msg.sender].pv);
    } 
    // GetPlayerStats return player stats
    function GetPlayerStats() public view returns(uint8 wins, uint8 loses){
        return (_players[msg.sender].wins,_players[msg.sender].loses);
    }

    function GetPlayerName(address _addr) public view returns(string memory name){
        return _players[_addr].name;
    }
    // GetAllPlayers return list of players addresses
    function GetAllPlayers()public view returns(address[] memory){
        return players_adresses;
    }
    // Fight return winner
   function Fight() public returns(string memory _name, uint exp, uint level){
        Personnage storage winner = _players[msg.sender];
        require(players_adresses.length > 1, "Il n'y a pas assez de joueur");
        uint256 rand = random() % players_adresses.length;
        Personnage storage loser =  _players[players_adresses[rand]];
        require(players_adresses[rand] != msg.sender, "Aucun joueur trouvé");
        
        if(_players[players_adresses[rand]].strength >= _players[msg.sender].strength) 
        {
            winner = _players[players_adresses[rand]];
            loser = _players[msg.sender];
        } else {
            uint256 randWinner = random() % 2;
            winner = _players[players_adresses[randWinner]];
            loser = _players[msg.sender];
        }
        winner.exp = winner.exp + 5;
        if(winner.exp >= 10*winner.level) {
            winner.level = winner.level+1;
            winner.strength = winner.strength+1;
            winner.exp = 0;
        }
        winner.wins = winner.wins+1;
        loser.loses = loser.loses+1;
        return (winner.name, winner.exp, winner.level);
    }
    // ResetPlayer reset player Personnage
    function ResetPlayer(address a) public restricted returns(bool){
        _players[a].name = "";
        _players[a].level = 0;
        _players[a].exp = 0;
        _players[a].strength = 0;
        _players[a].pv = 0;
        _players[a].wins = 0;
        _players[a].loses = 0;
        _players[a].exist= false;
        return true;
    }
    modifier restricted() {
        require(
            msg.sender == owner,
            "You are not the owner of this contract"
        );
        _;
    }
}
