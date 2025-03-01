use warehouse_rental;
go

create procedure CreateUser
    @Login varchar(30),
    @Password varchar(255),
    @Name nvarchar(50),
    @ContactInformation nvarchar(255),
    @NewUserID int output
as
begin
    insert into [User] (Login, Password, Name, ContactInformation)
    values (@Login, @Password, @Name, @ContactInformation);

    set @NewUserID = SCOPE_IDENTITY();
end;

create procedure GetUser
    @UserID int
as
begin
    select * from [User] where UserID = @UserID;
end;

create procedure UpdateUser
    @UserID int,
    @Login varchar(30),
    @Password varchar(255),
    @Name nvarchar(50),
    @ContactInformation nvarchar(255)
as
begin
    update [User]
    set Login = @Login,
        Password = @Password,
        Name = @Name,
        ContactInformation = @ContactInformation
    where UserID = @UserID;
end;

create procedure DeleteUser
    @UserID int
as
begin
    delete from [User] where UserID = @UserID;
end;

create procedure CreateLandlord
    @UserID int,
    @NewLandlordID int output
as
begin
    insert into Landlord (UserID) values (@UserID);
    set @NewLandlordID = SCOPE_IDENTITY();
end;

create procedure GetLandlord
    @LandlordID int
as
begin
    select l.LandlordID, u.*
    from Landlord l
    join [User] u ON l.UserID = u.UserID
    where l.LandlordID = @LandlordID;
end;

create procedure DeleteLandlord
    @LandlordID int
as
begin
    delete from Landlord where LandlordID = @LandlordID;
end;

create procedure CreateTenant
    @UserID int,
    @NewTenantID int output
as
begin
    insert into Tenant (UserID) values (@UserID);
    set @NewTenantID = SCOPE_IDENTITY();
end;

create procedure GetTenant
    @TenantID int
as
begin
    select t.TenantID, u.*
    from Tenant t
    join [User] u ON t.UserID = u.UserID
    where t.TenantID = @TenantID;
end;

create procedure DeleteTenant
    @TenantID int
as
begin
    delete from Tenant where TenantID = @TenantID;
end;

create procedure CreateStorageRoom
    @LandlordID int,
    @Address nvarchar(100),
    @TransportHubs nvarchar(255),
    @InfrastructureNear nvarchar(255),
    @TotalArea FLOAT,
    @RoomLength FLOAT,
    @RoomWidth FLOAT,
    @RoomHeight FLOAT,
    @AvailableArea FLOAT,
    @SpecificNeedsArea FLOAT,
    @RoomCooling BIT,
    @SunriseSide BIT,
    @Status BIT,
    @NewRoomID int output
as
begin
    insert into StorageRoom (LandlordID, Address, TransportHubs, InfrastructureNear, TotalArea, RoomLength, RoomWidth, RoomHeight, AvailableArea, SpecificNeedsArea, RoomCooling, SunriseSide, Status)
    values (@LandlordID, @Address, @TransportHubs, @InfrastructureNear, @TotalArea, @RoomLength, @RoomWidth, @RoomHeight, @AvailableArea, @SpecificNeedsArea, @RoomCooling, @SunriseSide, @Status);

    set @NewRoomID = SCOPE_IDENTITY();
end;

create procedure GetStorageRoom
    @RoomID int
as
begin
    select * from StorageRoom where RoomID = @RoomID;
end;

create procedure UpdateStorageRoom
    @RoomID int,
    @Address nvarchar(100),
    @TransportHubs nvarchar(255),
    @InfrastructureNear nvarchar(255),
    @TotalArea FLOAT,
    @RoomLength FLOAT,
    @RoomWidth FLOAT,
    @RoomHeight FLOAT,
    @AvailableArea FLOAT,
    @SpecificNeedsArea FLOAT,
    @RoomCooling BIT,
    @SunriseSide BIT,
    @Status BIT
as
begin
    update StorageRoom
    set Address = @Address,
        TransportHubs = @TransportHubs,
        InfrastructureNear = @InfrastructureNear,
        TotalArea = @TotalArea,
        RoomLength = @RoomLength,
        RoomWidth = @RoomWidth,
        RoomHeight = @RoomHeight,
        AvailableArea = @AvailableArea,
        SpecificNeedsArea = @SpecificNeedsArea,
        RoomCooling = @RoomCooling,
        SunriseSide = @SunriseSide,
        Status = @Status
    where RoomID = @RoomID;
end;

create procedure DeleteStorageRoom
    @RoomID int
as
begin
    delete from StorageRoom where RoomID = @RoomID;
end;


create procedure CreateAdditionalServices
    @RoomID int,
    @HasSecurity BIT,
    @HasCleaning BIT,
    @HasRepairWork BIT
as
begin
    insert into AdditionalServices (RoomID, HasSecurity, HasCleaning, HasRepairWork)
    values (@RoomID, @HasSecurity, @HasCleaning, @HasRepairWork);
end;

create procedure GetAdditionalServices
    @RoomID int
as
begin
    select * from AdditionalServices where RoomID = @RoomID;
end;

create procedure UpdateAdditionalServices
    @RoomID int,
    @HasSecurity BIT,
    @HasCleaning BIT,
    @HasRepairWork BIT
as
begin
    update AdditionalServices
    set HasSecurity = @HasSecurity,
        HasCleaning = @HasCleaning,
        HasRepairWork = @HasRepairWork
    where RoomID = @RoomID;
end;

create procedure DeleteAdditionalServices
    @RoomID int
as
begin
    delete from AdditionalServices where RoomID = @RoomID;
end;

create procedure CreateRoomPicture
    @RoomID int,
    @PictureLink nvarchar(255),
    @NewRoomPictureID int output
as
begin
    insert into RoomPicture (RoomID, PictureLink)
    values (@RoomID, @PictureLink);

    set @NewRoomPictureID = SCOPE_IDENTITY();
end;

create procedure GetRoomPictures
    @RoomID int
as
begin
    select * from RoomPicture where RoomID = @RoomID;
end;

create procedure UpdateRoomPicture
    @RoomPictureID int,
    @PictureLink nvarchar(255)
as
begin
    update RoomPicture
    set PictureLink = @PictureLink
    where RoomPictureID = @RoomPictureID;
end;

create procedure DeleteRoomPicture
    @RoomPictureID int
as
begin
    delete from RoomPicture where RoomPictureID = @RoomPictureID;
end;

create procedure CreateRentalPayment
    @MonthlyPayment FLOAT,
    @PaymentSchedule int,
    @PaymentMethod int,
    @NewRentalPaymentsID int output
as
begin
    insert into RentalPayments (MonthlyPayment, PaymentSchedule, PaymentMethod)
    values (@MonthlyPayment, @PaymentSchedule, @PaymentMethod);

    set @NewRentalPaymentsID = SCOPE_IDENTITY();
end;

create procedure GetRentalPayment
    @RentalPaymentsID int
as
begin
    select * from RentalPayments where RentalPaymentsID = @RentalPaymentsID;
end;

create procedure UpdateRentalPayment
    @RentalPaymentsID int,
    @MonthlyPayment FLOAT,
    @PaymentSchedule int,
    @PaymentMethod int
as
begin
    update RentalPayments
    set MonthlyPayment = @MonthlyPayment,
        PaymentSchedule = @PaymentSchedule,
        PaymentMethod = @PaymentMethod
    where RentalPaymentsID = @RentalPaymentsID;
end;

create procedure DeleteRentalPayment
    @RentalPaymentsID int
as
begin
    delete from RentalPayments where RentalPaymentsID = @RentalPaymentsID;
end;

create procedure CreateRentalPeriod
    @StartDate DATE,
    @endDate DATE,
    @PossibilityOfExtensions nvarchar(255),
    @NewRentalPeriodID int output
as
begin
    insert into RentalPeriod (StartDate, endDate, PossibilityOfExtensions)
    values (@StartDate, @endDate, @PossibilityOfExtensions);

    set @NewRentalPeriodID = SCOPE_IDENTITY();
end;

create procedure GetRentalPeriod
    @RentalPeriodID int
as
begin
    select * from RentalPeriod where RentalPeriodID = @RentalPeriodID;
end;

create procedure UpdateRentalPeriod
    @RentalPeriodID int,
    @StartDate DATE,
    @endDate DATE,
    @PossibilityOfExtensions nvarchar(255)
as
begin
    update RentalPeriod
    set StartDate = @StartDate,
        endDate = @endDate,
        PossibilityOfExtensions = @PossibilityOfExtensions
    where RentalPeriodID = @RentalPeriodID;
end;

create procedure DeleteRentalPeriod
    @RentalPeriodID int
as
begin
    delete from RentalPeriod where RentalPeriodID = @RentalPeriodID;
end;

create procedure CreateRentalCondition
    @ObligationsOfTenant nvarchar(1000),
    @ObligationsOfLandlord nvarchar(1000),
    @ConditionsOfUseStorageFacilities nvarchar(1000),
    @LiabilityDamages nvarchar(1000),
    @NewRentalConditionsID int output
as
begin
    insert into RentalConditions (ObligationsOfTenant, ObligationsOfLandlord, ConditionsOfUseStorageFacilities, LiabilityDamages)
    values (@ObligationsOfTenant, @ObligationsOfLandlord, @ConditionsOfUseStorageFacilities, @LiabilityDamages);

    set @NewRentalConditionsID = SCOPE_IDENTITY();
end;

create procedure GetRentalCondition
    @RentalConditionsID int
as
begin
    select * from RentalConditions where RentalConditionsID = @RentalConditionsID;
end;

create procedure UpdateRentalCondition
    @RentalConditionsID int,
    @ObligationsOfTenant nvarchar(1000),
    @ObligationsOfLandlord nvarchar(1000),
    @ConditionsOfUseStorageFacilities nvarchar(1000),
    @LiabilityDamages nvarchar(1000)
as
begin
    update RentalConditions
    set ObligationsOfTenant = @ObligationsOfTenant,
        ObligationsOfLandlord = @ObligationsOfLandlord,
        ConditionsOfUseStorageFacilities = @ConditionsOfUseStorageFacilities,
        LiabilityDamages = @LiabilityDamages
    where RentalConditionsID = @RentalConditionsID;
end;

create procedure DeleteRentalCondition
    @RentalConditionsID int
as
begin
    delete from RentalConditions where RentalConditionsID = @RentalConditionsID;
end;

create procedure CreateContractAgreement
    @ContractNumber int,
    @LandlordID int,
    @TenantID int,
    @RoomID int,
    @RentalPeriodID int,
    @RentalPaymentsID int,
    @RentalConditionsID int,
    @DepositAmount int,
    @TermsOfReturn nvarchar(1000),
    @TermOfUse nvarchar(255),
    @DateOfConclusion DATE,
    @DateOfEndConclusion DATE,
    @AmountOfFine int,
    @TerminationConditions nvarchar(500)
as
begin
    insert into ContractAgreement
    (ContractNumber, LandlordID, TenantID, RoomID, RentalPeriodID, RentalPaymentsID, RentalConditionsID,
     DepositAmount, TermsOfReturn, TermOfUse, DateOfConclusion, DateOfEndConclusion, AmountOfFine, TerminationConditions)
    values
    (@ContractNumber, @LandlordID, @TenantID, @RoomID, @RentalPeriodID, @RentalPaymentsID, @RentalConditionsID,
     @DepositAmount, @TermsOfReturn, @TermOfUse, @DateOfConclusion, @DateOfEndConclusion, @AmountOfFine, @TerminationConditions);
end;

create procedure GetContractAgreement
    @ContractNumber int
as
begin
    select * from ContractAgreement where ContractNumber = @ContractNumber;
end;

create procedure UpdateContractAgreement
    @ContractNumber int,
    @DepositAmount int,
    @TermsOfReturn nvarchar(1000),
    @TermOfUse nvarchar(255),
    @DateOfEndConclusion DATE,
    @AmountOfFine int,
    @TerminationConditions nvarchar(500)
as
begin
    update ContractAgreement
    set DepositAmount = @DepositAmount,
        TermsOfReturn = @TermsOfReturn,
        TermOfUse = @TermOfUse,
        DateOfEndConclusion = @DateOfEndConclusion,
        AmountOfFine = @AmountOfFine,
        TerminationConditions = @TerminationConditions
    where ContractNumber = @ContractNumber;
end;

create procedure DeleteContractAgreement
    @ContractNumber int
as
begin
    delete from ContractAgreement where ContractNumber = @ContractNumber;
end;

create procedure CreateDeal
    @ContractNumber int,
    @LandlordID int,
    @TenantID int,
    @DealInformation nvarchar(500),
    @Rating int,
    @NewDealID int output
as
begin
    insert into Deal (ContractNumber, LandlordID, TenantID, DealInformation, Rating)
    values (@ContractNumber, @LandlordID, @TenantID, @DealInformation, @Rating);

    set @NewDealID = SCOPE_IDENTITY();
end;

create procedure GetDeal
    @DealID int
as
begin
    select * from Deal where DealID = @DealID;
end;

create procedure UpdateDeal
    @DealID int,
    @DealInformation nvarchar(500),
    @Rating int
as
begin
    update Deal
    set DealInformation = @DealInformation,
        Rating = @Rating
    where DealID = @DealID;
end;

create procedure DeleteDeal
    @DealID int
as
begin
    delete from Deal where DealID = @DealID;
end;

create procedure CreateRentalApplication
    @TenantID int,
    @RoomID int,
    @Type nvarchar(30),
    @Status BIT,
    @NewRentalApplicationID int output
as
begin
    insert into RentalApplication (TenantID, RoomID, Type, Status)
    values (@TenantID, @RoomID, @Type, @Status);

    set @NewRentalApplicationID = SCOPE_IDENTITY();
end;

create procedure GetRentalApplication
    @RentalApplicationID int
as
begin
    select * from RentalApplication where RentalApplicationID = @RentalApplicationID;
end;

create procedure UpdateRentalApplication
    @RentalApplicationID int,
    @Status BIT
as
begin
    update RentalApplication
    set Status = @Status
    where RentalApplicationID = @RentalApplicationID;
end;

create procedure DeleteRentalApplication
    @RentalApplicationID int
as
begin
    delete from RentalApplication where RentalApplicationID = @RentalApplicationID;
end;





