create database warehouse_rental
create database QGISLAB

use warehouse_rental;
go

create table [User] (
    UserID int primary key identity(1,1),
    Login varchar(30) unique not null,
    Password varchar(255) not null,
    Name nvarchar(50) not null,
    ContactInformation nvarchar(255) not null
);

create table Landlord (
    LandlordID int primary key identity(1,1),
    UserID int unique references [User](UserID)
);

create table Tenant (
    TenantID int primary key identity(1,1),
    UserID int unique references [User](UserID)
);

create table StorageRoom (
    RoomID int primary key identity(1,1),
    LandlordID int references Landlord(LandlordID),
    Address nvarchar(100) not null,
    TransportHubs nvarchar(255),
    InfrastructureNear nvarchar(255),
    TotalArea float not null,
    RoomLength float not null,
    RoomWidth float not null,
    RoomHeight float not null,
    AvailableArea float not null,
    SpecificNeedsArea float not null,
    RoomCooling bit not null,
    SunriseSide bit not null,
    Status bit not null
);

create table AdditionalServices (
    RoomID int primary key references StorageRoom(RoomID),
    HasSecurity bit not null,
    HasCleaning bit not null,
    HasRepairWork bit not null
);

create table RoomPicture (
    RoomPictureID int primary key identity(1,1),
    RoomID int references StorageRoom(RoomID),
    PictureLink nvarchar(255) not null
);

create table RentalPayments (
    RentalPaymentsID int primary key identity(1,1),
    MonthlyPayment float not null,
    PaymentSchedule int check (PaymentSchedule between 1 and 5),
    PaymentMethod int check (PaymentMethod in (0,1))
);

create table RentalPeriod (
    RentalPeriodID int primary key identity(1,1),
    StartDate date not null,
    EndDate date not null,
    PossibilityOfExtensions nvarchar(255) not null
);

create table RentalConditions (
    RentalConditionsID int primary key identity(1,1),
    ObligationsOfTenant nvarchar(1000) not null,
    ObligationsOfLandlord nvarchar(1000) not null,
    ConditionsOfUseStorageFacilities nvarchar(1000) not null,
    LiabilityDamages nvarchar(1000) not null
);

create table ContractAgreement (
    ContractNumber int primary key,
    LandlordID int references Landlord(LandlordID),
    TenantID int references Tenant(TenantID),
    RoomID int references StorageRoom(RoomID),
    RentalPeriodID int references RentalPeriod(RentalPeriodID),
    RentalPaymentsID int references RentalPayments(RentalPaymentsID),
    RentalConditionsID int references RentalConditions(RentalConditionsID),
    DepositAmount int not null,
    TermsOfReturn nvarchar(1000) not null,
    TermOfUse nvarchar(255) not null,
    DateOfConclusion date not null,
    DateOfEndConclusion date not null,
    AmountOfFine int not null,
    TerminationConditions nvarchar(500) not null
);

create table Deal(
    DealID int primary key identity(1,1),
    ContractNumber int references ContractAgreement(ContractNumber),
    LandlordID int references Landlord(LandlordID),
    TenantID int references Tenant(TenantID),
    DealInformation nvarchar(500),
    Rating int not null check (Rating in (0,5))
);

create table RentalApplication(
    RentalApplicationID int primary key identity(1,1),
    TenantID int references Tenant(TenantID),
    RoomID int references StorageRoom(RoomID),
    Type nvarchar(30) check(Type in('Продление', 'Аренда')) not null,
    Status bit not null
);

drop table [User];
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

