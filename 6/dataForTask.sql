select * from "User";
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

DECLARE
  v_NewUserID number;
BEGIN
  CreateUser(
    p_Login => 'user3',
    p_Password => 'password3',
    p_Name => 'Арсен Коломейчук',
    p_ContactInformation => 'arsen@mail.com',
    p_NewUserID => v_NewUserID
  );

  CreateUser(
    p_Login => 'user4',
    p_Password => 'password4',
    p_Name => 'Кирилл Русаков',
    p_ContactInformation => 'kirill@mail.com',
    p_NewUserID => v_NewUserID
  );

  CreateUser(
    p_Login => 'user5',
    p_Password => 'password5',
    p_Name => 'Тамара Белозерова',
    p_ContactInformation => 'tamara@mail.com',
    p_NewUserID => v_NewUserID
  );

  CreateUser(
    p_Login => 'user6',
    p_Password => 'password6',
    p_Name => 'Юлиан Рябов',
    p_ContactInformation => 'yll192@mail.com',
    p_NewUserID => v_NewUserID
  );

  CreateUser(
    p_Login => 'user7',
    p_Password => 'password7',
    p_Name => 'Максимиллиан Петухов',
    p_ContactInformation => 'maximil@mail.com',
    p_NewUserID => v_NewUserID
  );

  CreateUser(
    p_Login => 'user8',
    p_Password => 'password8',
    p_Name => 'Иннокентий Беляев',
    p_ContactInformation => 'beliy255@mail.com',
    p_NewUserID => v_NewUserID
  );

  CreateUser(
    p_Login => 'user9',
    p_Password => 'password9',
    p_Name => 'Лариса Селиверстова',
    p_ContactInformation => 'lara@mail.com',
    p_NewUserID => v_NewUserID
  );
END;
/

declare v_landlord_id number;
begin
    CreateLandlord(28, v_landlord_id);
    CreateLandlord(29, v_landlord_id);
end;
/

declare v_tenant_id number;
begin
    CreateTenant(30, v_tenant_id);
    CreateTenant(31, v_tenant_id);
    CreateTenant(32, v_tenant_id);
    CreateTenant(33, v_tenant_id);
    CreateTenant(34, v_tenant_id);
end;
/

declare v_room_id number;
begin
    CreateStorageRoom(
        25,
        N'Москва, ул. Ленина, 12',
        N'Рядом с автовокзалом',
        N'Супермаркет, кафе',
        1000,
        50,
        20,
        6,
        800,
        200,
        1,
        0,
        1,
        v_room_id
    );
end;
/

update StorageRoom set LANDLORDID = 26 where ROOMID = 6;

declare v_room_picture_id number;
begin
    CreateRoomPicture(2, 'http://example.com/warehouse2.jpg', v_room_picture_id);
    CreateRoomPicture(3, 'http://example.com/warehouse3.jpg', v_room_picture_id);
    CreateRoomPicture(4, 'http://example.com/warehouse4.jpg', v_room_picture_id);
    CreateRoomPicture(5, 'http://example.com/warehouse5.jpg', v_room_picture_id);
    CreateRoomPicture(6, 'http://example.com/warehouse6.jpg', v_room_picture_id);
    CreateRoomPicture(7, 'http://example.com/warehouse7.jpg', v_room_picture_id);
    CreateRoomPicture(1, 'http://example.com/warehouse8.jpg', v_room_picture_id);
    CreateRoomPicture(8, 'http://example.com/warehouse9.jpg', v_room_picture_id);
    CreateRoomPicture(12, 'http://example.com/warehouse12.jpg', v_room_picture_id);

end;
/

begin
    CreateAdditionalServices(12, 1, 1, 0);
    CreateAdditionalServices(2, 1, 0, 0);
    CreateAdditionalServices(3, 1, 0, 0);
    CreateAdditionalServices(4, 1, 1, 1);
    CreateAdditionalServices(5, 1, 1, 1);
    CreateAdditionalServices(6, 0, 1, 0);
    CreateAdditionalServices(7, 0, 1, 0);
    CreateAdditionalServices(8, 1, 0, 0);
end;
/

declare v_rental_payments_id number;
begin
    CreateRentalPayment(50000, 1, 0, v_rental_payments_id);
    CreateRentalPayment(80000, 2, 0, v_rental_payments_id);
    CreateRentalPayment(100000, 2, 0, v_rental_payments_id);
    CreateRentalPayment(150000, 4, 0, v_rental_payments_id);
    CreateRentalPayment(90000, 2, 0, v_rental_payments_id);
    CreateRentalPayment(55000, 4, 0, v_rental_payments_id);
    CreateRentalPayment(99000, 5, 0, v_rental_payments_id);

end;
/

declare v_rental_period_id number;
begin
    CreateRentalPeriod(date '2024-03-11', date '2025-03-18', 'по договоренности', v_rental_period_id);
    CreateRentalPeriod(date '2024-03-11', date '2025-01-10', 'по договоренности', v_rental_period_id);
    CreateRentalPeriod(date '2024-03-11', date '2025-02-15', 'по договоренности', v_rental_period_id);
    CreateRentalPeriod(date '2024-03-11', date '2025-02-13', 'по договоренности', v_rental_period_id);
    CreateRentalPeriod(date '2024-03-11', date '2024-10-13', 'по договоренности', v_rental_period_id);
    CreateRentalPeriod(date '2024-03-11', date '2024-10-16', 'по договоренности', v_rental_period_id);
    CreateRentalPeriod(date '2024-03-11', date '2024-11-13', 'по договоренности', v_rental_period_id);
    CreateRentalPeriod(date '2024-03-11', date '2024-12-26', 'по договоренности', v_rental_period_id);
    CreateRentalPeriod(date '2024-01-01', date '2026-01-01', 'по договоренности', v_rental_period_id);
    CreateRentalPeriod(date '2024-01-01', date '2025-01-01', 'по договоренности', v_rental_period_id);
    CreateRentalPeriod(date '2024-03-01', date '2026-11-01', 'по договоренности', v_rental_period_id);
    CreateRentalPeriod(date '2024-05-01', date '2026-12-01', 'по договоренности', v_rental_period_id);
end;
/

declare v_rental_conditions_id number;
begin
    CreateRentalCondition(
        '1. Уплата аренды вовремя;
                              2. Содержание арендуемого помещения в чистоте и порядке;
                              3. Немедленное уведомление арендодателя о повреждениях или неисправностях;
                              4. Соблюдение правил пожарной безопасности и общественного порядка',
        '1. Обеспечение безопасности арендуемого помещения;
                               2. Поддержание технического состояния здания и коммунальных систем;
                               3. Устранение неисправностей в разумные сроки;
                               4. Обеспечение арендатора необходимой документацией и инструкциями по эксплуатации оборудования',
        '1. Использование арендуемого помещения только для хранения;
                                          2. Запрещено хранение опасных и токсичных материалов;
                                          3. Соблюдение максимальной нагрузки на пол;
                                          4. Обеспечение свободного доступа к аварийным выходам',
        '1. Ответственность арендатора за ущерб, нанесенный арендуемому помещению;
                           2. Возмещение расходов на ремонт в случае повреждений по вине арендатора;
                           3. Обязательство арендатора застраховать имущество на случай ущерба',
        v_rental_conditions_id
    );
end;
/

begin
    CreateContractAgreement(
        119,
        26, --1, 25, 26
        30, -- 1, 26-30
        7, --1-8, 12
        5, --1-13
        9, --1-9
        1, --1-2
        10000,
        'Депозит возвращается при расторжении',
        'Минимальный срок – 1 год',
        date '2024-03-11',
        date '2025-02-13',
        5000,
        'Штраф за досрочное расторжение 10% от суммы'
    );
end;
/

select * from RentalPeriod;
select * from ContractAgreement;

commit;