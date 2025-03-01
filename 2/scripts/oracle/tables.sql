create table "User" (
    UserID number generated always as identity primary key,
    Login varchar2(30) unique not null,
    Password varchar2(255) not null,
    Name nvarchar2(50) not null,
    ContactInformation nvarchar2(255) not null
);

create table Landlord (
    LandlordID number generated always as identity primary key,
    UserID number unique references "User"(UserID) on delete cascade
);

create table Tenant (
    TenantID number generated always as identity primary key,
    UserID number unique references "User"(UserID) on delete cascade
);

create table StorageRoom (
    RoomID number generated always as identity primary key,
    LandlordID number references Landlord(LandlordID) on delete cascade,
    Address nvarchar2(100) not null,
    TransportHubs nvarchar2(255),
    InfrastructureNear nvarchar2(255),
    TotalArea number not null,
    RoomLength number not null,
    RoomWidth number not null,
    RoomHeight number not null,
    AvailableArea number not null,
    SpecificNeedsArea number not null,
    RoomCooling number(1) not null,
    SunriseSide number(1) not null,
    Status number(1) not null
);

create table AdditionalServices (
    RoomID number primary key references StorageRoom(RoomID) on delete cascade,
    HasSecurity number(1) not null,
    HasCleaning number(1) not null,
    HasRepairWork number(1) not null
);

create table RoomPicture (
    RoomPictureID number generated always as identity primary key,
    RoomID number references StorageRoom(RoomID) on delete cascade,
    PictureLink nvarchar2(255) not null
);

create table RentalPayments (
    RentalPaymentsID number generated always as identity primary key,
    MonthlyPayment number not null,
    PaymentSchedule number check (PaymentSchedule between 1 and 5),
    PaymentMethod number check (PaymentMethod in (0,1))
);

create table RentalPeriod (
    RentalPeriodID number generated always as identity primary key,
    StartDate date not null,
    EndDate date not null,
    PossibilityOfExtensions nvarchar2(255) not null
);

create table RentalConditions (
    RentalConditionsID number generated always as identity primary key,
    ObligationsOfTenant nvarchar2(1000) not null,
    ObligationsOfLandlord nvarchar2(1000) not null,
    ConditionsOfUseStorageFacilities nvarchar2(1000) not null,
    LiabilityDamages nvarchar2(1000) not null
);

create table ContractAgreement (
    ContractNumber number primary key,
    LandlordID number references Landlord(LandlordID) on delete cascade,
    TenantID number references Tenant(TenantID) on delete cascade,
    RoomID number references StorageRoom(RoomID) on delete cascade,
    RentalPeriodID number references RentalPeriod(RentalPeriodID) on delete cascade,
    RentalPaymentsID number references RentalPayments(RentalPaymentsID) on delete cascade,
    RentalConditionsID number references RentalConditions(RentalConditionsID) on delete cascade,
    DepositAmount number not null,
    TermsOfReturn nvarchar2(1000) not null,
    TermOfUse nvarchar2(255) not null,
    DateOfConclusion date not null,
    DateOfEndConclusion date not null,
    AmountOfFine number not null,
    TerminationConditions nvarchar2(500) not null
);

create table Deal (
    DealID number generated always as identity primary key,
    ContractNumber number references ContractAgreement(ContractNumber) on delete cascade,
    LandlordID number references Landlord(LandlordID) on delete cascade,
    TenantID number references Tenant(TenantID) on delete cascade,
    DealInformation nvarchar2(500),
    Rating number check (Rating between 0 and 5) not null
);

create table RentalApplication (
    RentalApplicationID number generated always as identity primary key,
    TenantID number references Tenant(TenantID) on delete cascade,
    RoomID number references StorageRoom(RoomID) on delete cascade,
    Type nvarchar2(30) check(Type in('Продление', 'Аренда')) not null,
    Status number(1) not null
);

drop table "User";
drop table Landlord;
drop table Tenant;
drop table StorageRoom;
drop table AdditionalServices;
drop table RoomPicture;
drop table RentalPayments;
drop table RentalPeriod;
drop table RentalConditions;
drop table ContractAgreement;
drop table Deal;
drop table RentalApplication;
