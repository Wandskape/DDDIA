use warehouse_rental;
go

create index idx_user_login on [User](Login);
create index idx_user_contact on [User](ContactInformation);

create index idx_landlord_user on Landlord(UserID);
create index idx_tenant_user on Tenant(UserID);

create index idx_storage_address on StorageRoom(Address);
create index idx_storage_status on StorageRoom(Status);

create index idx_contract_landlord on ContractAgreement(LandlordID);
create index idx_contract_tenant on ContractAgreement(TenantID);
create index idx_contract_room on ContractAgreement(RoomID);

create index idx_rental_application on RentalApplication(RoomID);
