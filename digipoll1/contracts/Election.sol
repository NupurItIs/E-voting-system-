pragma solidity >=0.4.21 ;

contract Election{

	//model candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}
	
	// Store accounts that have voted
    mapping(address => bool) public voters;
    
	//store candidate
	//fetch candidate
	mapping(uint => Candidate) public candidates; 
	
	//store candidate count
	uint public candidatesCount;

	// voted event
    event votedEvent (
        uint indexed _candidateId
    );

	constructor () public{
		
		addCandidate("BJP");
		addCandidate("Congress");
	}

	//function to add candidate
	function addCandidate(string memory _name) private{
		candidatesCount ++;
		candidates[candidatesCount] = Candidate(candidatesCount,_name,0);
	}

	function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }


}