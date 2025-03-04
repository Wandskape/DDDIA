create or replace procedure CreateUser (
    p_Login IN varchar2,
    p_Password IN varchar2,
    p_Name IN nvarchar2,
    p_ContactInformation IN nvarchar2,
    p_NewUserID OUT number
) as
begin
    insert Into "User" (Login, Password, Name, ContactInformation)
    values (p_Login, p_Password, p_Name, p_ContactInformation)
    returning UserID into p_NewUserID;
end;
/

create or replace procedure GetUser (
    p_UserID IN number
) as
begin
    select * from "User" where UserID = p_UserID;
end;
/

create or replace procedure UpdateUser (
    p_UserID IN number,
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
    p_UserID IN number
) as
begin
    delete from "User" where UserID = p_UserID;
end;
/

create or replace procedure CreateLandlord (
    p_UserID IN number,
    p_NewLandlordID OUT number
) as
begin
    insert into Landlord (UserID) values (p_UserID)
    returning LandlordID into p_NewLandlordID;
end;
/

create or replace procedure GetLandlord (
    p_LandlordID IN number
) as
begin
    select l.LandlordID, u.*
    from Landlord l
    join "User" u ON l.UserID = u.UserID
    where l.LandlordID = p_LandlordID;
end;
/

create or replace procedure DeleteLandlord (
    p_LandlordID IN number
) as
begin
    delete from Landlord where LandlordID = p_LandlordID;
end;
/

create or replace procedure CreateTenant (
    p_UserID IN number,
    p_NewTenantID OUT number
) as
begin
    insert into Tenant (UserID) values (p_UserID)
    returning TenantID into p_NewTenantID;
end;
/

create or replace procedure GetTenant (
    p_TenantID IN number
) as
begin
    select t.TenantID, u.*
    from Tenant t
    join "User" u ON t.UserID = u.UserID
    where t.TenantID = p_TenantID;
end;
/

create or replace procedure DeleteTenant (
    p_TenantID IN number
) as
begin
    delete from Tenant where TenantID = p_TenantID;
end;
/

create or replace procedure CreateStorageRoom (
    p_LandlordID IN number,
    p_Address IN nvarchar2,
    p_TransportHubs IN nvarchar2,
    p_InfrastructureNear IN nvarchar2,
    p_TotalArea IN number,
    p_RoomLength IN number,
    p_RoomWidth IN number,
    p_RoomHeight IN number,
    p_AvailableArea IN number,
    p_SpecificNeedsArea IN number,
    p_RoomCooling IN number,
    p_SunriseSide IN number,
    p_Status IN number,
    p_NewRoomID OUT number
) is
begin
    insert into StorageRoom (LandlordID, Address, TransportHubs, InfrastructureNear, TotalArea, RoomLength, RoomWidth, RoomHeight, AvailableArea, SpecificNeedsArea, RoomCooling, SunriseSide, Status)
    values (p_LandlordID, p_Address, p_TransportHubs, p_InfrastructureNear, p_TotalArea, p_RoomLength, p_RoomWidth, p_RoomHeight, p_AvailableArea, p_SpecificNeedsArea, p_RoomCooling, p_SunriseSide, p_Status)
    returning RoomID into p_NewRoomID;
end;
/


create or replace procedure GetStorageRoom (
    p_RoomID IN number
) as
begin
    select * from StorageRoom where RoomID = p_RoomID;
end;
/

create or replace procedure UpdateStorageRoom (
    p_RoomID IN number,
    p_Address IN nvarchar2,
    p_TransportHubs IN nvarchar2,
    p_InfrastructureNear IN nvarchar2,
    p_TotalArea IN number,
    p_RoomLength IN number,
    p_RoomWidth IN number,
    p_RoomHeight IN number,
    p_AvailableArea IN number,
    p_SpecificNeedsArea IN number,
    p_RoomCooling IN number,
    p_SunriseSide IN number,
    p_Status IN number
) is
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
    p_RoomID IN number
) as
begin
    delete from StorageRoom where RoomID = p_RoomID;
end;
/

create or replace procedure CreateAdditionalServices (
    p_RoomID IN number,
    p_HasSecurity IN number,
    p_HasCleaning IN number,
    p_HasRepairWork IN number
) is
begin
    insert into AdditionalServices (RoomID, HasSecurity, HasCleaning, HasRepairWork)
    values (p_RoomID, p_HasSecurity, p_HasCleaning, p_HasRepairWork);
end;
/


create or replace procedure GetAdditionalServices (
    p_RoomID IN number
) as
begin
    select * from AdditionalServices where RoomID = p_RoomID;
end;
/

create or replace procedure UpdateAdditionalServices (
    p_RoomID IN number,
    p_HasSecurity IN number,
    p_HasCleaning IN number,
    p_HasRepairWork IN number
) is
begin
    update AdditionalServices
    set HasSecurity = p_HasSecurity,
        HasCleaning = p_HasCleaning,
        HasRepairWork = p_HasRepairWork
    where RoomID = p_RoomID;
end;
/


create or replace procedure DeleteAdditionalServices (
    p_RoomID IN number
) as
begin
    delete from AdditionalServices where RoomID = p_RoomID;
end;
/

create or replace procedure CreateRoomPicture (
    p_RoomID IN number,
    p_PictureLink IN nvarchar2,
    p_NewRoomPictureID OUT number
) as
begin
    insert Into RoomPicture (RoomID, PictureLink)
    values (p_RoomID, p_PictureLink)
    returning RoomPictureID Into p_NewRoomPictureID;
end;
/

create or replace procedure GetRoomPictures (
    p_RoomID IN number
) as
begin
    select * from RoomPicture where RoomID = p_RoomID;
end;
/

create or replace procedure UpdateRoomPicture (
    p_RoomPictureID IN number,
    p_PictureLink IN nvarchar2
) as
begin
    update RoomPicture
    set PictureLink = p_PictureLink
    where RoomPictureID = p_RoomPictureID;
end;
/

create or replace procedure DeleteRoomPicture (
    p_RoomPictureID IN number
) as
begin
    delete from RoomPicture where RoomPictureID = p_RoomPictureID;
end;
/

create or replace procedure CreateRentalPayment (
    p_MonthlyPayment IN FLOAT,
    p_PaymentSchedule IN number,
    p_PaymentMethod IN number,
    p_NewRentalPaymentsID OUT number
) as
begin
    insert Into RentalPayments (MonthlyPayment, PaymentSchedule, PaymentMethod)
    values (p_MonthlyPayment, p_PaymentSchedule, p_PaymentMethod)
    returning RentalPaymentsID Into p_NewRentalPaymentsID;
end;
/

create or replace procedure GetRentalPayment (
    p_RentalPaymentsID IN number
) as
begin
    select * from RentalPayments where RentalPaymentsID = p_RentalPaymentsID;
end;
/

create or replace procedure UpdateRentalPayment (
    p_RentalPaymentsID IN number,
    p_MonthlyPayment IN FLOAT,
    p_PaymentSchedule IN number,
    p_PaymentMethod IN number
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
    p_RentalPaymentsID IN number
) as
begin
    delete from RentalPayments where RentalPaymentsID = p_RentalPaymentsID;
end;
/

create or replace procedure CreateRentalPeriod (
    p_StartDate IN DATE,
    p_endDate IN DATE,
    p_PossibilityOfExtensions IN nvarchar2,
    p_NewRentalPeriodID OUT number
) as
begin
    insert Into RentalPeriod (StartDate, endDate, PossibilityOfExtensions)
    values (p_StartDate, p_endDate, p_PossibilityOfExtensions)
    returning RentalPeriodID Into p_NewRentalPeriodID;
end;
/

create or replace procedure GetRentalPeriod (
    p_RentalPeriodID IN number
) as
begin
    select * from RentalPeriod where RentalPeriodID = p_RentalPeriodID;
end;
/

create or replace procedure UpdateRentalPeriod (
    p_RentalPeriodID IN number,
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
    p_RentalPeriodID IN number
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
    p_NewRentalConditionsID OUT number
) as
begin
    insert Into RentalConditions (ObligationsOfTenant, ObligationsOfLandlord, ConditionsOfUseStorageFacilities, LiabilityDamages)
    values (p_ObligationsOfTenant, p_ObligationsOfLandlord, p_ConditionsOfUseStorageFacilities, p_LiabilityDamages)
    returning RentalConditionsID Into p_NewRentalConditionsID;
end;
/

create or replace procedure GetRentalCondition (
    p_RentalConditionsID IN number
) as
begin
    select * from RentalConditions where RentalConditionsID = p_RentalConditionsID;
end;
/

create or replace procedure UpdateRentalCondition (
    p_RentalConditionsID IN number,
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
    p_RentalConditionsID IN number
) as
begin
    delete from RentalConditions where RentalConditionsID = p_RentalConditionsID;
end;
/

create or replace procedure CreateContractAgreement (
    p_ContractNumber IN number,
    p_LandlordID IN number,
    p_TenantID IN number,
    p_RoomID IN number,
    p_RentalPeriodID IN number,
    p_RentalPaymentsID IN number,
    p_RentalConditionsID IN number,
    p_DepositAmount IN number,
    p_TermsOfReturn IN nvarchar2,
    p_TermOfUse IN nvarchar2,
    p_DateOfConclusion IN DATE,
    p_DateOfEndConclusion IN DATE,
    p_AmountOfFine IN number,
    p_TerminationConditions IN nvarchar2
) as
begin
    insert Into ContractAgreement
    (ContractNumber, LandlordID, TenantID, RoomID, RentalPeriodID, RentalPaymentsID, RentalConditionsID,
     DepositAmount, TermsOfReturn, TermOfUse, DateOfConclusion, DateOfEndConclusion, AmountOfFine, TerminationConditions)
    values
    (p_ContractNumber, p_LandlordID, p_TenantID, p_RoomID, p_RentalPeriodID, p_RentalPaymentsID, p_RentalConditionsID,
     p_DepositAmount, p_TermsOfReturn, p_TermOfUse, p_DateOfConclusion, p_DateOfEndConclusion, p_AmountOfFine, p_TerminationConditions);
end;
/

create or replace procedure GetContractAgreement (
    p_ContractNumber IN number
) as
begin
    select * from ContractAgreement where ContractNumber = p_ContractNumber;
end;
/

create or replace procedure UpdateContractAgreement (
    p_ContractNumber IN number,
    p_DepositAmount IN number,
    p_TermsOfReturn IN nvarchar2,
    p_TermOfUse IN nvarchar2,
    p_DateOfEndConclusion IN DATE,
    p_AmountOfFine IN number,
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
    p_ContractNumber IN number
) as
begin
    delete from ContractAgreement where ContractNumber = p_ContractNumber;
end;
/

create or replace procedure CreateDeal (
    p_ContractNumber IN number,
    p_LandlordID IN number,
    p_TenantID IN number,
    p_DealInformation IN nvarchar2,
    p_Rating IN number,
    p_NewDealID OUT number
) as
begin
    insert Into Deal (ContractNumber, LandlordID, TenantID, DealInformation, Rating)
    values (p_ContractNumber, p_LandlordID, p_TenantID, p_DealInformation, p_Rating)
    returning DealID Into p_NewDealID;
end;
/

create or replace procedure GetDeal (
    p_DealID IN number
) as
begin
    select * from Deal where DealID = p_DealID;
end;
/

create or replace procedure UpdateDeal (
    p_DealID IN number,
    p_DealInformation IN nvarchar2,
    p_Rating IN number
) as
begin
    update Deal
    set DealInformation = p_DealInformation,
        Rating = p_Rating
    where DealID = p_DealID;
end;
/

create or replace procedure DeleteDeal (
    p_DealID IN number
) as
begin
    delete from Deal where DealID = p_DealID;
end;
/

create or replace procedure CreateRentalApplication (
    p_TenantID IN number,
    p_RoomID IN number,
    p_Type IN nvarchar2,
    p_Status IN number,
    p_NewRentalApplicationID OUT number
) is
begin
    insert into RentalApplication (TenantID, RoomID, "TYPE", Status)
    values (p_TenantID, p_RoomID, p_Type, p_Status)
    returning RentalApplicationID into p_NewRentalApplicationID;
end;
/


create or replace procedure GetRentalApplication (
    p_RentalApplicationID IN number
) as
begin
    select * from RentalApplication where RentalApplicationID = p_RentalApplicationID;
end;
/

create or replace procedure UpdateRentalApplication (
    p_RentalApplicationID IN number,
    p_Status IN number
) is
begin
    update RentalApplication
    set Status = p_Status
    where RentalApplicationID = p_RentalApplicationID;
end;
/

create or replace procedure DeleteRentalApplication (
    p_RentalApplicationID IN number
) as
begin
    delete from RentalApplication where RentalApplicationID = p_RentalApplicationID;
end;
/


commit;