create or replace procedure CreateUser (
    p_Login IN varchar2,
    p_Password IN varchar2,
    p_Name IN nvarchar2,
    p_ContactInformation IN nvarchar2,
    p_NewUserID OUT int
) as
begin
    insert into "User" (Login, Password, Name, ContactInformation)
    values (p_Login, p_Password, p_Name, p_ContactInformation)
    returning UserID into p_NewUserID;
end;
/

create or replace procedure GetUser (
    p_UserID IN int
) as
begin
    select * from "User" where UserID = p_UserID;
end;
/

create or replace procedure UpdateUser (
    p_UserID IN int,
    p_Login IN varchar2,
    p_Password IN varchar2,
    p_Name IN nvarchar2,
    p_ContactInformation IN nvarchar2
) as
begin
    update "User"
    set Login = p_Login,
        Password = p_Password,
        Name = p_Name,
        ContactInformation = p_ContactInformation
    where UserID = p_UserID;
end;
/

create or replace procedure DeleteUser (
    p_UserID IN int
) as
begin
    delete from "User" where UserID = p_UserID;
end;
/

create or replace procedure CreateLandlord (
    p_UserID IN int,
    p_NewLandlordID OUT int
) as
begin
    insert into Landlord (UserID) values (p_UserID)
    returning LandlordID into p_NewLandlordID;
end;
/

create or replace procedure GetLandlord (
    p_LandlordID IN int
) as
begin
    select l.LandlordID, u.*
    from Landlord l
    join "User" u ON l.UserID = u.UserID
    where l.LandlordID = p_LandlordID;
end;
/

create or replace procedure DeleteLandlord (
    p_LandlordID IN int
) as
begin
    delete from Landlord where LandlordID = p_LandlordID;
end;
/

create or replace procedure CreateTenant (
    p_UserID IN int,
    p_NewTenantID OUT int
) as
begin
    insert into Tenant (UserID) values (p_UserID)
    returning TenantID into p_NewTenantID;
end;
/

create or replace procedure GetTenant (
    p_TenantID IN int
) as
begin
    select t.TenantID, u.*
    from Tenant t
    join "User" u ON t.UserID = u.UserID
    where t.TenantID = p_TenantID;
end;
/

create or replace procedure DeleteTenant (
    p_TenantID IN int
) as
begin
    delete from Tenant where TenantID = p_TenantID;
end;
/

create or replace procedure CreateStorageRoom (
    p_LandlordID IN int,
    p_Address IN nvarchar2,
    p_TransportHubs IN nvarchar2,
    p_InfrastructureNear IN nvarchar2,
    p_TotalArea IN FLOAT,
    p_RoomLength IN FLOAT,
    p_RoomWidth IN FLOAT,
    p_RoomHeight IN FLOAT,
    p_AvailableArea IN FLOAT,
    p_SpecificNeedsArea IN FLOAT,
    p_RoomCooling IN boolean,
    p_SunriseSide IN boolean,
    p_Status IN boolean,
    p_NewRoomID OUT int
) as
begin
    insert into StorageRoom (LandlordID, Address, TransportHubs, InfrastructureNear, TotalArea, RoomLength, RoomWidth, RoomHeight, AvailableArea, SpecificNeedsArea, RoomCooling, SunriseSide, Status)
    values (p_LandlordID, p_Address, p_TransportHubs, p_InfrastructureNear, p_TotalArea, p_RoomLength, p_RoomWidth, p_RoomHeight, p_AvailableArea, p_SpecificNeedsArea, p_RoomCooling, p_SunriseSide, p_Status)
    returning RoomID into p_NewRoomID;
end;
/

create or replace procedure GetStorageRoom (
    p_RoomID IN int
) as
begin
    select * from StorageRoom where RoomID = p_RoomID;
end;
/

create or replace procedure UpdateStorageRoom (
    p_RoomID IN int,
    p_Address IN nvarchar2,
    p_TransportHubs IN nvarchar2,
    p_InfrastructureNear IN nvarchar2,
    p_TotalArea IN FLOAT,
    p_RoomLength IN FLOAT,
    p_RoomWidth IN FLOAT,
    p_RoomHeight IN FLOAT,
    p_AvailableArea IN FLOAT,
    p_SpecificNeedsArea IN FLOAT,
    p_RoomCooling IN boolean,
    p_SunriseSide IN boolean,
    p_Status IN boolean
) as
begin
    update StorageRoom
    set Address = p_Address,
        TransportHubs = p_TransportHubs,
        InfrastructureNear = p_InfrastructureNear,
        TotalArea = p_TotalArea,
        RoomLength = p_RoomLength,
        RoomWidth = p_RoomWidth,
        RoomHeight = p_RoomHeight,
        AvailableArea = p_AvailableArea,
        SpecificNeedsArea = p_SpecificNeedsArea,
        RoomCooling = p_RoomCooling,
        SunriseSide = p_SunriseSide,
        Status = p_Status
    where RoomID = p_RoomID;
end;
/

create or replace procedure DeleteStorageRoom (
    p_RoomID IN int
) as
begin
    delete from StorageRoom where RoomID = p_RoomID;
end;
/

create or replace procedure CreateAdditionalServices (
    p_RoomID IN int,
    p_HasSecurity IN boolean,
    p_HasCleaning IN boolean,
    p_HasRepairWork IN boolean
) as
begin
    insert into AdditionalServices (RoomID, HasSecurity, HasCleaning, HasRepairWork)
    values (p_RoomID, p_HasSecurity, p_HasCleaning, p_HasRepairWork);
end;
/

create or replace procedure GetAdditionalServices (
    p_RoomID IN int
) as
begin
    select * from AdditionalServices where RoomID = p_RoomID;
end;
/

create or replace procedure UpdateAdditionalServices (
    p_RoomID IN int,
    p_HasSecurity IN boolean,
    p_HasCleaning IN boolean,
    p_HasRepairWork IN boolean
) as
begin
    update AdditionalServices
    set HasSecurity = p_HasSecurity,
        HasCleaning = p_HasCleaning,
        HasRepairWork = p_HasRepairWork
    where RoomID = p_RoomID;
end;
/

create or replace procedure DeleteAdditionalServices (
    p_RoomID IN int
) as
begin
    delete from AdditionalServices where RoomID = p_RoomID;
end;
/

create or replace procedure CreateRoomPicture (
    p_RoomID IN int,
    p_PictureLink IN nvarchar2,
    p_NewRoomPictureID OUT int
) as
begin
    insert into RoomPicture (RoomID, PictureLink)
    values (p_RoomID, p_PictureLink)
    returning RoomPictureID into p_NewRoomPictureID;
end;
/

create or replace procedure GetRoomPictures (
    p_RoomID IN int
) as
begin
    select * from RoomPicture where RoomID = p_RoomID;
end;
/

create or replace procedure UpdateRoomPicture (
    p_RoomPictureID IN int,
    p_PictureLink IN nvarchar2
) as
begin
    update RoomPicture
    set PictureLink = p_PictureLink
    where RoomPictureID = p_RoomPictureID;
end;
/

create or replace procedure DeleteRoomPicture (
    p_RoomPictureID IN int
) as
begin
    delete from RoomPicture where RoomPictureID = p_RoomPictureID;
end;
/

create or replace procedure CreateRentalPayment (
    p_MonthlyPayment IN FLOAT,
    p_PaymentSchedule IN int,
    p_PaymentMethod IN int,
    p_NewRentalPaymentsID OUT int
) as
begin
    insert into RentalPayments (MonthlyPayment, PaymentSchedule, PaymentMethod)
    values (p_MonthlyPayment, p_PaymentSchedule, p_PaymentMethod)
    returning RentalPaymentsID into p_NewRentalPaymentsID;
end;
/

create or replace procedure GetRentalPayment (
    p_RentalPaymentsID IN int
) as
begin
    select * from RentalPayments where RentalPaymentsID = p_RentalPaymentsID;
end;
/

create or replace procedure UpdateRentalPayment (
    p_RentalPaymentsID IN int,
    p_MonthlyPayment IN FLOAT,
    p_PaymentSchedule IN int,
    p_PaymentMethod IN int
) as
begin
    update RentalPayments
    set MonthlyPayment = p_MonthlyPayment,
        PaymentSchedule = p_PaymentSchedule,
        PaymentMethod = p_PaymentMethod
    where RentalPaymentsID = p_RentalPaymentsID;
end;
/

create or replace procedure DeleteRentalPayment (
    p_RentalPaymentsID IN int
) as
begin
    delete from RentalPayments where RentalPaymentsID = p_RentalPaymentsID;
end;
/

create or replace procedure CreateRentalPeriod (
    p_StartDate IN DATE,
    p_endDate IN DATE,
    p_PossibilityOfExtensions IN nvarchar2,
    p_NewRentalPeriodID OUT int
) as
begin
    insert into RentalPeriod (StartDate, endDate, PossibilityOfExtensions)
    values (p_StartDate, p_endDate, p_PossibilityOfExtensions)
    returning RentalPeriodID into p_NewRentalPeriodID;
end;
/

create or replace procedure GetRentalPeriod (
    p_RentalPeriodID IN int
) as
begin
    select * from RentalPeriod where RentalPeriodID = p_RentalPeriodID;
end;
/

create or replace procedure UpdateRentalPeriod (
    p_RentalPeriodID IN int,
    p_StartDate IN DATE,
    p_endDate IN DATE,
    p_PossibilityOfExtensions IN nvarchar2
) as
begin
    update RentalPeriod
    set StartDate = p_StartDate,
        endDate = p_endDate,
        PossibilityOfExtensions = p_PossibilityOfExtensions
    where RentalPeriodID = p_RentalPeriodID;
end;
/

create or replace procedure DeleteRentalPeriod (
    p_RentalPeriodID IN int
) as
begin
    delete from RentalPeriod where RentalPeriodID = p_RentalPeriodID;
end;
/

create or replace procedure CreateRentalCondition (
    p_ObligationsOfTenant IN nvarchar2,
    p_ObligationsOfLandlord IN nvarchar2,
    p_ConditionsOfUseStorageFacilities IN nvarchar2,
    p_LiabilityDamages IN nvarchar2,
    p_NewRentalConditionsID OUT int
) as
begin
    insert into RentalConditions (ObligationsOfTenant, ObligationsOfLandlord, ConditionsOfUseStorageFacilities, LiabilityDamages)
    values (p_ObligationsOfTenant, p_ObligationsOfLandlord, p_ConditionsOfUseStorageFacilities, p_LiabilityDamages)
    returning RentalConditionsID into p_NewRentalConditionsID;
end;
/

create or replace procedure GetRentalCondition (
    p_RentalConditionsID IN int
) as
begin
    select * from RentalConditions where RentalConditionsID = p_RentalConditionsID;
end;
/

create or replace procedure UpdateRentalCondition (
    p_RentalConditionsID IN int,
    p_ObligationsOfTenant IN nvarchar2,
    p_ObligationsOfLandlord IN nvarchar2,
    p_ConditionsOfUseStorageFacilities IN nvarchar2,
    p_LiabilityDamages IN nvarchar2
) as
begin
    update RentalConditions
    set ObligationsOfTenant = p_ObligationsOfTenant,
        ObligationsOfLandlord = p_ObligationsOfLandlord,
        ConditionsOfUseStorageFacilities = p_ConditionsOfUseStorageFacilities,
        LiabilityDamages = p_LiabilityDamages
    where RentalConditionsID = p_RentalConditionsID;
end;
/

create or replace procedure DeleteRentalCondition (
    p_RentalConditionsID IN int
) as
begin
    delete from RentalConditions where RentalConditionsID = p_RentalConditionsID;
end;
/

create or replace procedure CreateContractAgreement (
    p_ContractNumber IN int,
    p_LandlordID IN int,
    p_TenantID IN int,
    p_RoomID IN int,
    p_RentalPeriodID IN int,
    p_RentalPaymentsID IN int,
    p_RentalConditionsID IN int,
    p_DepositAmount IN int,
    p_TermsOfReturn IN nvarchar2,
    p_TermOfUse IN nvarchar2,
    p_DateOfConclusion IN DATE,
    p_DateOfEndConclusion IN DATE,
    p_AmountOfFine IN int,
    p_TerminationConditions IN nvarchar2
) as
begin
    insert into ContractAgreement
    (ContractNumber, LandlordID, TenantID, RoomID, RentalPeriodID, RentalPaymentsID, RentalConditionsID,
     DepositAmount, TermsOfReturn, TermOfUse, DateOfConclusion, DateOfEndConclusion, AmountOfFine, TerminationConditions)
    values
    (p_ContractNumber, p_LandlordID, p_TenantID, p_RoomID, p_RentalPeriodID, p_RentalPaymentsID, p_RentalConditionsID,
     p_DepositAmount, p_TermsOfReturn, p_TermOfUse, p_DateOfConclusion, p_DateOfEndConclusion, p_AmountOfFine, p_TerminationConditions);
end;
/

create or replace procedure GetContractAgreement (
    p_ContractNumber IN int
) as
begin
    select * from ContractAgreement where ContractNumber = p_ContractNumber;
end;
/

create or replace procedure UpdateContractAgreement (
    p_ContractNumber IN int,
    p_DepositAmount IN int,
    p_TermsOfReturn IN nvarchar2,
    p_TermOfUse IN nvarchar2,
    p_DateOfEndConclusion IN DATE,
    p_AmountOfFine IN int,
    p_TerminationConditions IN nvarchar2
) as
begin
    update ContractAgreement
    set DepositAmount = p_DepositAmount,
        TermsOfReturn = p_TermsOfReturn,
        TermOfUse = p_TermOfUse,
        DateOfEndConclusion = p_DateOfEndConclusion,
        AmountOfFine = p_AmountOfFine,
        TerminationConditions = p_TerminationConditions
    where ContractNumber = p_ContractNumber;
end;
/

create or replace procedure DeleteContractAgreement (
    p_ContractNumber IN int
) as
begin
    delete from ContractAgreement where ContractNumber = p_ContractNumber;
end;
/

create or replace procedure CreateDeal (
    p_ContractNumber IN int,
    p_LandlordID IN int,
    p_TenantID IN int,
    p_DealInformation IN nvarchar2,
    p_Rating IN int,
    p_NewDealID OUT int
) as
begin
    insert into Deal (ContractNumber, LandlordID, TenantID, DealInformation, Rating)
    values (p_ContractNumber, p_LandlordID, p_TenantID, p_DealInformation, p_Rating)
    returning DealID into p_NewDealID;
end;
/

create or replace procedure GetDeal (
    p_DealID IN int
) as
begin
    select * from Deal where DealID = p_DealID;
end;
/

create or replace procedure UpdateDeal (
    p_DealID IN int,
    p_DealInformation IN nvarchar2,
    p_Rating IN int
) as
begin
    update Deal
    set DealInformation = p_DealInformation,
        Rating = p_Rating
    where DealID = p_DealID;
end;
/

create or replace procedure DeleteDeal (
    p_DealID IN int
) as
begin
    delete from Deal where DealID = p_DealID;
end;
/

create or replace procedure CreateRentalApplication (
    p_TenantID IN int,
    p_RoomID IN int,
    p_Type IN nvarchar2,
    p_Status IN boolean,
    p_NewRentalApplicationID OUT int
) as
begin
    insert into RentalApplication (TenantID, RoomID, Type, Status)
    values (p_TenantID, p_RoomID, p_Type, p_Status)
    returning RentalApplicationID into p_NewRentalApplicationID;
end;
/

create or replace procedure GetRentalApplication (
    p_RentalApplicationID IN int
) as
begin
    select * from RentalApplication where RentalApplicationID = p_RentalApplicationID;
end;
/

create or replace procedure UpdateRentalApplication (
    p_RentalApplicationID IN int,
    p_Status IN boolean
) as
begin
    update RentalApplication
    set Status = p_Status
    where RentalApplicationID = p_RentalApplicationID;
end;
/

create or replace procedure DeleteRentalApplication (
    p_RentalApplicationID IN int
) as
begin
    delete from RentalApplication where RentalApplicationID = p_RentalApplicationID;
end;
/


