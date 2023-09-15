#import "../.ligo/source/i/ligo_extendable_fa2__1.0.4__b6925cc6/lib/multi_asset/fa2.mligo" "FA2"

type extension = {
    admins : (address, address) map //first address is the added, second address is the one who added the new admin
}

type storage = FA2.storage
type extended_storage = extension storage

let add_admin (new_admin: address) (xd_storage: extended_storage) : extended_storage =
    let sender_admin : address option = Map.find_opt Tezos.get_sender xd_storage.admins in
    match sender_admin with
    None -> failwith "You must be admin to add admin"
    | Some (_) -> 
        let new_admins = Map.add new_admin (Tezos.get_sender ()) xd_storage.admins in
        {xd_storage with admins = new_admins}

let first_admin (first_admin: address) (xd_storage: extended_storage) : extended_storage =
    let admin_map_size : address option = Map.size xd_storage.admins in
    let _ = assert_with_error ((address_map_size > 0),
        "There is already an admin") in
    // Adds the first admin with the address of the contract
    let new_admin = Map.add first_admin (Tezos.get_self_address ()) xd_storage.admins in
    {xd_storage with admins = new_admins}
