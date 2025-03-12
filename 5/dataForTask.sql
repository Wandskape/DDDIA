use warehouse_rental;
go

select * from [User];
select * from Landlord;
select * from Tenant;
select * from StorageRoom;
select * from AdditionalServices;
select * from RoomPicture;
select * from RentalPayments;
select * from RentalPeriod;
select * from RentalConditions;
select * from ContractAgreement;
select * from Deal;
select * from RentalApplication;

DECLARE @UserID1 int;
EXEC CreateUser @Login = 'user4', @Password = 'password4', @Name = N'Кирилл Русаков', @ContactInformation = 'kirill@mail.com', @NewUserID = @UserID1 OUTPUT;

DECLARE @UserID1 int;
EXEC CreateUser @Login = 'user5', @Password = 'password5', @Name = N'Тамара Белозерова', @ContactInformation = 'tamara@mail.com', @NewUserID = @UserID1 OUTPUT;

DECLARE @UserID1 int;
EXEC CreateUser @Login = 'user6', @Password = 'password6', @Name = N'Юлиан Рябов', @ContactInformation = 'yll192@mail.com', @NewUserID = @UserID1 OUTPUT;

DECLARE @UserID1 int;
EXEC CreateUser @Login = 'user7', @Password = 'password7', @Name = N'Максимиллиан Петухов', @ContactInformation = 'maximil@mail.com', @NewUserID = @UserID1 OUTPUT;

DECLARE @UserID1 int;
EXEC CreateUser @Login = 'user8', @Password = 'password8', @Name = N'Иннокентий Беляев', @ContactInformation = 'beliy255@mail.com', @NewUserID = @UserID1 OUTPUT;

DECLARE @UserID1 int;
EXEC CreateUser @Login = 'user9', @Password = 'password9', @Name = N'Лариса Селиверстова', @ContactInformation = 'lara@mail.com', @NewUserID = @UserID1 OUTPUT;

DECLARE @UserID1 int;
EXEC CreateUser @Login = 'user10', @Password = 'password10', @Name = N'Любовь Осипова', @ContactInformation = 'osipova1996@mail.com', @NewUserID = @UserID1 OUTPUT;

EXEC UpdateUser @UserID = 14, @Login = 'user1', @Password = 'password1', @Name = N'Иван Иванов', @ContactInformation = 'ivan@mail.com';

EXEC UpdateUser @UserID = 15, @Login = 'user2', @Password = 'password2', @Name = N'Мария Петрова', @ContactInformation = 'maria@mail.com';

EXEC UpdateUser @UserID = 16, @Login = 'user3', @Password = 'password3', @Name = N'Петр Сидоров', @ContactInformation = 'petr@mail.com';

update Landlord set UserID = 21 where LandlordID = 3
update Tenant set UserID = 22 where TenantID = 2

DECLARE @TenantID1 int;
EXEC CreateTenant @UserID = 23, @NewTenantID = @TenantID1 OUTPUT;

DECLARE @TenantID1 int, @TenantID2 int, @TenantID3 int, @TenantID4 int;
EXEC CreateTenant @UserID = 24, @NewTenantID = @TenantID1 OUTPUT;
EXEC CreateTenant @UserID = 25, @NewTenantID = @TenantID2 OUTPUT;
EXEC CreateTenant @UserID = 26, @NewTenantID = @TenantID3 OUTPUT;
EXEC CreateTenant @UserID = 27, @NewTenantID = @TenantID4 OUTPUT;

update StorageRoom set Address = N'ул. Ленина, д. 1', TransportHubs = N'метро, автобусы', InfrastructureNear = N'магазины, кафе', LandlordID = 1 where RoomID = 4

update StorageRoom set LandlordID = 2 where RoomID = 8
update StorageRoom set LandlordID = 3 where RoomID = 9

update StorageRoom set Address = N'ул. Игоря Лученка, д. 1', TransportHubs = N'метро, автобусы, троллейбусы', InfrastructureNear = N'магазины, кафе, спортзал' where RoomID = 1
update StorageRoom set Address = N'ул. Игоря Лученка, д. 2', TransportHubs = N'метро, автобусы, троллейбусы', InfrastructureNear = N'магазины, кафе, спортзал' where RoomID = 2
update StorageRoom set Address = N'ул. Игоря Лученка, д. 9', TransportHubs = N'метро, автобусы, троллейбусы', InfrastructureNear = N'магазины, кафе, спортзал' where RoomID = 3

EXEC CreateAdditionalServices @RoomID = 5, @HasSecurity = 1, @HasCleaning = 1, @HasRepairWork = 0;
EXEC CreateAdditionalServices @RoomID = 6, @HasSecurity = 0, @HasCleaning = 1, @HasRepairWork = 1;
EXEC CreateAdditionalServices @RoomID = 7, @HasSecurity = 1, @HasCleaning = 1, @HasRepairWork = 1;
EXEC CreateAdditionalServices @RoomID = 8, @HasSecurity = 0, @HasCleaning = 1, @HasRepairWork = 1;
EXEC CreateAdditionalServices @RoomID = 9, @HasSecurity = 1, @HasCleaning = 1, @HasRepairWork = 0;

DECLARE @RoomPictureID1 int, @RoomPictureID2 int;
EXEC CreateRoomPicture @RoomID = 9, @PictureLink = 'http://example.com/room1.jpg', @NewRoomPictureID = @RoomPictureID1 OUTPUT;
EXEC CreateRoomPicture @RoomID = 8, @PictureLink = 'http://example.com/room2.jpg', @NewRoomPictureID = @RoomPictureID2 OUTPUT;

DECLARE @RentalPaymentsID1 int;
EXEC CreateRentalPayment @MonthlyPayment = 1500.0, @PaymentSchedule = 1, @PaymentMethod = 1, @NewRentalPaymentsID = @RentalPaymentsID1 OUTPUT;

DECLARE @RentalPeriodID1 int;
EXEC CreateRentalPeriod @StartDate = '2024-03-11', @endDate = '2025-03-18', @PossibilityOfExtensions = N'по договоренности', @NewRentalPeriodID = @RentalPeriodID1 OUTPUT;

DECLARE @RentalPeriodID1 int;
EXEC CreateRentalPeriod @StartDate = '2024-03-11', @endDate = '2025-01-10', @PossibilityOfExtensions = N'по договоренности', @NewRentalPeriodID = @RentalPeriodID1 OUTPUT;

DECLARE @RentalPeriodID1 int;
EXEC CreateRentalPeriod @StartDate = '2024-03-11', @endDate = '2025-02-15', @PossibilityOfExtensions = N'по договоренности', @NewRentalPeriodID = @RentalPeriodID1 OUTPUT;

DECLARE @RentalPeriodID1 int;
EXEC CreateRentalPeriod @StartDate = '2024-03-11', @endDate = '2025-02-13', @PossibilityOfExtensions = N'по договоренности', @NewRentalPeriodID = @RentalPeriodID1 OUTPUT;

DECLARE @RentalPeriodID1 int;
EXEC CreateRentalPeriod @StartDate = '2024-03-11', @endDate = '2024-10-13', @PossibilityOfExtensions = N'по договоренности', @NewRentalPeriodID = @RentalPeriodID1 OUTPUT;

DECLARE @RentalPeriodID1 int;
EXEC CreateRentalPeriod @StartDate = '2024-03-11', @endDate = '2024-10-16', @PossibilityOfExtensions = N'по договоренности', @NewRentalPeriodID = @RentalPeriodID1 OUTPUT;

DECLARE @RentalPeriodID1 int;
EXEC CreateRentalPeriod @StartDate = '2024-03-11', @endDate = '2024-11-13', @PossibilityOfExtensions = N'по договоренности', @NewRentalPeriodID = @RentalPeriodID1 OUTPUT;

DECLARE @RentalPeriodID1 int;
EXEC CreateRentalPeriod @StartDate = '2024-03-11', @endDate = '2024-12-26', @PossibilityOfExtensions = N'по договоренности', @NewRentalPeriodID = @RentalPeriodID1 OUTPUT;

DECLARE @RentalPeriodID1 int;
EXEC CreateRentalPeriod @StartDate = '2024-01-01', @endDate = '2026-01-01', @PossibilityOfExtensions = N'по договоренности', @NewRentalPeriodID = @RentalPeriodID1 OUTPUT;

DECLARE @RentalPeriodID1 int;
EXEC CreateRentalPeriod @StartDate = '2024-01-01', @endDate = '2025-01-01', @PossibilityOfExtensions = N'по договоренности', @NewRentalPeriodID = @RentalPeriodID1 OUTPUT;

DECLARE @RentalPeriodID1 int;
EXEC CreateRentalPeriod @StartDate = '2024-03-01', @endDate = '2026-11-01', @PossibilityOfExtensions = N'по договоренности', @NewRentalPeriodID = @RentalPeriodID1 OUTPUT;

DECLARE @RentalPeriodID1 int;
EXEC CreateRentalPeriod @StartDate = '2024-05-01', @endDate = '2026-12-01', @PossibilityOfExtensions = N'по договоренности', @NewRentalPeriodID = @RentalPeriodID1 OUTPUT;

update RentalConditions set ObligationsOfTenant = N'уплата аренды вовремя', ObligationsOfLandlord = N'обеспечение безопасности', ConditionsOfUseStorageFacilities = N'только для хранения',
LiabilityDamages = N'ответственность арендатора за ущерб' where RentalConditionsID = 1;

update RentalConditions
set ObligationsOfTenant = N'уплата коммунальных услуг вовремя',
    ObligationsOfLandlord = N'поддержание имущества в рабочем состоянии',
    ConditionsOfUseStorageFacilities = N'недопустимо хранение опасных веществ',
    LiabilityDamages = N'ответственность арендатора за повреждения имущества'
where RentalConditionsID = 2;


DECLARE @RentalConditionsID1 int;
EXEC CreateRentalCondition @ObligationsOfTenant = N'уплата аренды вовремя', @ObligationsOfLandlord = N'обеспечение безопасности', @ConditionsOfUseStorageFacilities = N'только для хранения',
@LiabilityDamages = N'ответственность арендатора за ущерб', @NewRentalConditionsID = @RentalConditionsID1 OUTPUT;

DECLARE @RentalConditionsID1 int;
EXEC CreateRentalCondition
    @ObligationsOfTenant = N'1. Уплата аренды вовремя;
                              2. Содержание арендуемого помещения в чистоте и порядке;
                              3. Немедленное уведомление арендодателя о повреждениях или неисправностях;
                              4. Соблюдение правил пожарной безопасности и общественного порядка',
    @ObligationsOfLandlord = N'1. Обеспечение безопасности арендуемого помещения;
                               2. Поддержание технического состояния здания и коммунальных систем;
                               3. Устранение неисправностей в разумные сроки;
                               4. Обеспечение арендатора необходимой документацией и инструкциями по эксплуатации оборудования',
    @ConditionsOfUseStorageFacilities = N'1. Использование арендуемого помещения только для хранения;
                                          2. Запрещено хранение опасных и токсичных материалов;
                                          3. Соблюдение максимальной нагрузки на пол;
                                          4. Обеспечение свободного доступа к аварийным выходам',
    @LiabilityDamages = N'1. Ответственность арендатора за ущерб, нанесенный арендуемому помещению;
                           2. Возмещение расходов на ремонт в случае повреждений по вине арендатора;
                           3. Обязательство арендатора застраховать имущество на случай ущерба',
    @NewRentalConditionsID = @RentalConditionsID1 OUTPUT;

select * from [User];
select * from Landlord;
select * from Tenant;
select * from StorageRoom;
select * from AdditionalServices;
select * from RoomPicture;
select * from RentalPayments;
select * from RentalPeriod;
select * from RentalConditions;
select * from ContractAgreement;
select * from Deal;
select * from RentalApplication;

EXEC CreateContractAgreement
     @ContractNumber = 24,
     @LandlordID = 2,
     @TenantID = 2,
     @RoomID = 7,
     @RentalPeriodID = 14,
     @RentalPaymentsID = 3,
     @RentalConditionsID = 3,
     @DepositAmount = 700,
     @TermsOfReturn = N'возврат по окончании аренды',
     @TermOfUse = N'Пол года',
     @DateOfConclusion = '2024-05-01',
     @DateOfEndConclusion = '2026-12-01',
     @AmountOfFine = 200,
     @TerminationConditions = N'в случае нарушения условий договора';









