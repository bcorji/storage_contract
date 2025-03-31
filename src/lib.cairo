use core::starknet::contract_address::ContractAddress;

// Define the contract interface
#[starknet::interface]
trait IStudentStorage<TContractState> {
    fn set_student_data(ref self: TContractState, name: felt252, age: u8);
    fn get_student_data(self: @TContractState) -> (felt252, u8);
}

// Define the contract module
#[starknet::contract]
mod StudentStorage {
    use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    // Define the storage struct
    #[storage]
    struct Storage {
        name: felt252,
        age: u8,
    }

    // Implement the contract interface
    #[abi(embed_v0)]
    impl StudentStorageImpl of super::IStudentStorage<ContractState> {
        // Set the student's name and age
        fn set_student_data(ref self: ContractState, name: felt252, age: u8) {
            self.name.write(name);
            self.age.write(age);
        }

        // Get the student's name and age
        fn get_student_data(self: @ContractState) -> (felt252, u8) {
            (self.name.read(), self.age.read())
        }
    }
}

