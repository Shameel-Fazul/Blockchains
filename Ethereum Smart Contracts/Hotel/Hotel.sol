pragma solidity >=0.7.0 <0.9.0;

contract Main {
    address payable internal owner;
    address[] internal rooms;
    enum status{ AVAILABLE, UNAVAILABLE }
    status Hotel;
    
    constructor() public {
        owner = payable(msg.sender);
        Hotel = status.AVAILABLE;
    }
    
    event Booking(string n, uint d);
    
    struct Room {
        uint number;
        string name;
        uint day_s;
    }
    
    mapping(address => Room) internal NewRoom;
    
    modifier billing() {
        require(msg.value >= 5 ether, 'Booking a room costs 5 ether');
        require(Hotel == status.AVAILABLE, 'The hotel is currently unavailable');
        require(rooms.length <= 10, 'Rooms are not available, the hotel is fully booked');
        _;
    }
    
     function Book_Room(string memory name, uint day_s) public payable billing {
        owner.transfer(msg.value);
        rooms.push(msg.sender);
        uint room_number = rooms.length;
        NewRoom[msg.sender] = Room(room_number, name, day_s);
        emit Booking(name, day_s);
    }
    function Search_Room(address room_address) public view returns(Room memory) {
        return NewRoom[room_address];
    }
    function Booked_Rooms() public view returns(uint) {
        return rooms.length;
    }
    function Set_Status(bool true_false) public {
        if (true_false) {
            Hotel = status.AVAILABLE;
        } else {
            Hotel = status.UNAVAILABLE;
        }
    }
}