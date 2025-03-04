use warehouse_rental;
go

delete [User] where UserID >= 11

-- Создание пользователей
DECLARE @UserID1 int, @UserID2 int, @UserID3 int;
EXEC CreateUser @Login = 'user1', @Password = 'password1', @Name = 'Иван Иванов', @ContactInformation = 'ivan@mail.com', @NewUserID = @UserID1 OUTPUT;
EXEC CreateUser @Login = 'user2', @Password = 'password2', @Name = 'Мария Петрова', @ContactInformation = 'maria@mail.com', @NewUserID = @UserID2 OUTPUT;
EXEC CreateUser @Login = 'user3', @Password = 'password3', @Name = 'Петр Сидоров', @ContactInformation = 'petr@mail.com', @NewUserID = @UserID3 OUTPUT;
select * from [User];
-- Создание арендодателей
DECLARE @LandlordID1 int, @LandlordID2 int;
EXEC CreateLandlord @UserID = @UserID1, @NewLandlordID = @LandlordID1 OUTPUT;
EXEC CreateLandlord @UserID = @UserID2, @NewLandlordID = @LandlordID2 OUTPUT;
select * from Landlord;

-- Создание арендаторов
DECLARE @TenantID1 int;
EXEC CreateTenant @UserID = @UserID3, @NewTenantID = @TenantID1 OUTPUT;
select * from Tenant;
-- Создание складских помещений
DECLARE @RoomID1 int, @RoomID2 int;
EXEC CreateStorageRoom @LandlordID = @LandlordID1, @Address = N'ул. Ленина, д. 1', @TransportHubs = N'метро, автобусы', @InfrastructureNear = N'магазины, кафе',
     @TotalArea = 100.0, @RoomLength = 10.0, @RoomWidth = 10.0, @RoomHeight = 3.0, @AvailableArea = 90.0, @SpecificNeedsArea = 10.0, @RoomCooling = 1, @SunriseSide = 1, @Status = 1, @NewRoomID = @RoomID1 OUTPUT;
EXEC CreateStorageRoom @LandlordID = @LandlordID2, @Address = 'ул. Пушкина, д. 2', @TransportHubs = 'трамваи, троллейбусы', @InfrastructureNear = 'аптеки, банки',
@TotalArea = 120.0, @RoomLength = 12.0, @RoomWidth = 10.0, @RoomHeight = 3.0, @AvailableArea = 110.0, @SpecificNeedsArea = 10.0, @RoomCooling = 0, @SunriseSide = 0, @Status = 1, @NewRoomID = @RoomID2 OUTPUT;
select * from StorageRoom;
-- Создание дополнительных услуг
EXEC CreateAdditionalServices @RoomID = @RoomID1, @HasSecurity = 1, @HasCleaning = 1, @HasRepairWork = 0;
EXEC CreateAdditionalServices @RoomID = @RoomID2, @HasSecurity = 0, @HasCleaning = 1, @HasRepairWork = 1;
select * from AdditionalServices;
-- Добавление фотографий складских помещений
DECLARE @RoomPictureID1 int, @RoomPictureID2 int;
EXEC CreateRoomPicture @RoomID = @RoomID1, @PictureLink = 'http://example.com/room1.jpg', @NewRoomPictureID = @RoomPictureID1 OUTPUT;
EXEC CreateRoomPicture @RoomID = @RoomID2, @PictureLink = 'http://example.com/room2.jpg', @NewRoomPictureID = @RoomPictureID2 OUTPUT;
select * from RoomPicture;
-- Создание платежей за аренду
DECLARE @RentalPaymentsID1 int;
EXEC CreateRentalPayment @MonthlyPayment = 500.0, @PaymentSchedule = 1, @PaymentMethod = 1, @NewRentalPaymentsID = @RentalPaymentsID1 OUTPUT;
select * from RentalPayments;
-- Создание периода аренды
DECLARE @RentalPeriodID1 int;
EXEC CreateRentalPeriod @StartDate = '2025-03-01', @endDate = '2026-03-01', @PossibilityOfExtensions = 'по договоренности', @NewRentalPeriodID = @RentalPeriodID1 OUTPUT;
select * from RentalPeriod;
-- Создание условий аренды
DECLARE @RentalConditionsID1 int;
EXEC CreateRentalCondition @ObligationsOfTenant = 'уплата аренды вовремя', @ObligationsOfLandlord = 'обеспечение безопасности', @ConditionsOfUseStorageFacilities = 'только для хранения',
@LiabilityDamages = 'ответственность арендатора за ущерб', @NewRentalConditionsID = @RentalConditionsID1 OUTPUT;
select * from RentalConditions;
-- Создание договоров аренды
EXEC CreateContractAgreement @ContractNumber = 1, @LandlordID = @LandlordID1, @TenantID = @TenantID1, @RoomID = @RoomID1, @RentalPeriodID = @RentalPeriodID1,
@RentalPaymentsID = @RentalPaymentsID1, @RentalConditionsID = @RentalConditionsID1, @DepositAmount = 1000, @TermsOfReturn = 'возврат по окончании аренды',
@TermOfUse = '1 год', @DateOfConclusion = '2025-02-15', @DateOfEndConclusion = '2025-03-01', @AmountOfFine = 100, @TerminationConditions = 'в случае нарушения условий договора';
select * from ContractAgreement;
-- Создание сделок
DECLARE @DealID1 int;
EXEC CreateDeal @ContractNumber = 1, @LandlordID = @LandlordID1, @TenantID = @TenantID1, @DealInformation = 'Успешная сделка', @Rating = 5, @NewDealID = @DealID1 OUTPUT;
select * from Deal;
-- Создание заявок на аренду
DECLARE @RentalApplicationID1 int;
EXEC CreateRentalApplication @TenantID = @TenantID1, @RoomID = @RoomID1, @Type = 1, @Status = 1, @NewRentalApplicationID = @RentalApplicationID1 OUTPUT;
select * from RentalApplication;

-- Создание складских помещений
DECLARE @RoomID3 int, @RoomID4 int, @RoomID5 int;
EXEC CreateStorageRoom @LandlordID = 1, @Address = N'ул. Ленина, д. 3', @TransportHubs = N'метро, автобусы',
@InfrastructureNear = N'магазины, кафе', @TotalArea = 150.0, @RoomLength = 15.0, @RoomWidth = 10.0, @RoomHeight = 3.0,
@AvailableArea = 140.0, @SpecificNeedsArea = 10.0, @RoomCooling = 1, @SunriseSide = 1, @Status = 1, @NewRoomID = @RoomID3 OUTPUT;

EXEC CreateStorageRoom @LandlordID = 2, @Address = N'ул. Пушкина, д. 4', @TransportHubs = N'трамваи, троллейбусы',
@InfrastructureNear = N'аптеки, банки', @TotalArea = 180.0, @RoomLength = 18.0, @RoomWidth = 10.0, @RoomHeight = 3.5,
@AvailableArea = 170.0, @SpecificNeedsArea = 10.0, @RoomCooling = 0, @SunriseSide = 0, @Status = 1, @NewRoomID = @RoomID4 OUTPUT;

EXEC CreateStorageRoom @LandlordID = 3, @Address = N'ул. Советская, д. 5', @TransportHubs = N'автобусы, троллейбусы',
@InfrastructureNear = N'школы, поликлиники', @TotalArea = 200.0, @RoomLength = 20.0, @RoomWidth = 10.0, @RoomHeight = 4.0,
@AvailableArea = 190.0, @SpecificNeedsArea = 10.0, @RoomCooling = 1, @SunriseSide = 1, @Status = 1, @NewRoomID = @RoomID5 OUTPUT;


