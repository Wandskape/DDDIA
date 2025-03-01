create index idx_user_login on "User"(Login);

create index idx_landlord_user on Landlord(UserID);

create index idx_tenant_user on Tenant(UserID);

create index idx_storageroom_landlord on StorageRoom(LandlordID);
create index idx_storageroom_address on StorageRoom(Address);

create index idx_storageroom_area_status on StorageRoom(TotalArea, Status);

create index idx_rentalapplication_tenant on RentalApplication(TenantID);
create index idx_rentalapplication_room on RentalApplication(RoomID);

create index idx_rentalapplication_type on RentalApplication(Type);

create index idx_contract_landlord on ContractAgreement(LandlordID);
create index idx_contract_tenant on ContractAgreement(TenantID);
create index idx_contract_room on ContractAgreement(RoomID);

create index idx_deal_contract on Deal(ContractNumber);

create index idx_rentalpayments_schedule on RentalPayments(PaymentSchedule);
create index idx_rentalpayments_method on RentalPayments(PaymentMethod);

create index idx_rentalperiod_dates on RentalPeriod(StartDate, EndDate);
