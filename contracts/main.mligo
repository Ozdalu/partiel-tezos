#import "../.ligo/source/i/ligo_extendable_fa2__1.0.4__b6925cc6/lib/multi_asset/fa2.mligo" "FA2"

type extension = {
    admins : (address, bool) map; //first address is the added, bool for accepted or not
    banned : (address, address) map; // first address is the banned user, second address is the admin
    whitelisted : (address, bool) map; // first address is the chitelisted user, bool is if whitelisted

type storage = FA2.storage
type extended_storage = extension storage

// Définir un Administrateur
let first_admin (first_admin: address) (xd_storage: extended_storage) : extended_storage =
    let admin_map_size : address option = Map.size xd_storage.admins in
    let _ = assert_with_error ((address_map_size > 0),
        "There is already an admin") in
    // Adds admin auto accepted
    let new_admin = Map.add first_admin true xd_storage.admins in
    {xd_storage with admins = new_admins}

// ajouter d’autres administrateurs
let add_admin (new_admin: address) (xd_storage: extended_storage) : extended_storage =
    let sender_admin : address option = Map.find_opt Tezos.get_sender xd_storage.admins in
    match sender_admin with
    None -> failwith "You must be admin to add admin"
    | Some (_) -> 
        let new_admins = Map.add new_admin false xd_storage.admins in
        {xd_storage with admins = new_admins}

// supprimer d’autres administrateurs
let remove_admin (admin_to_remove) (xd_storage: extended_storage) : extended_storage =
    let sender_admin : address option = Map.find_opt Tezos.get_sender xd_storage.admins in
    match sender_admin with
    None -> failwith "You must be admin to remove admin"
    | Some (_) -> 
        let new_admins = Map.remove admin_to_remove xd_storage.admins in
        {xd_storage with admins = new_admins}

// L’Administrateur peut bannir (sur une blacklist) des Creators
let ban_creator (creator_to_ban) (xd_storage: extended_storage) : extended_storage =
    let sender_admin : address option = Map.find_opt Tezos.get_sender xd_storage.admins in
    match sender_admin with
    None -> failwith "You must be admin to ban creator"
    | Some (_) -> 
        let new_banned = Map.add creator_to_ban Tezos.get_sender xd_storage.banned in
        {xd_storage with banned = new_banned}

// creator must pay 10 tez to be automatically added to whitelist
let add_creator (creator_to_add) (xd_storage: extended_storage) : extended_storage =
    let enough_paid : bool = Tezos.get_amount () >= 10tz in
    if Tezos.get_amount () < 10tez then
        failwith "This contract does not accept tokens."
    else
        let new_whitelisted = Map.add creator_to_add true xd_storage.whitelisted in
        {xd_storage with whitelisted = new_whitelisted}
