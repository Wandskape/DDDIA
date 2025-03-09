declare v_user_id number;
begin
    CreateUser('landlord1', 'pass123', 'Иван Петров', 'ivan@example.com', v_user_id);
end;
/

declare v_user_id number;
begin
    CreateUser('tenant1', 'pass456', 'Анна Смирнова', 'anna@example.com', v_user_id);
end;
/

select * from "User";

declare v_landlord_id number;
begin
    CreateLandlord(1, v_landlord_id);
end;
/

declare v_tenant_id number;
begin
    CreateTenant(2, v_tenant_id);
end;
/

declare v_room_id number;
begin
    CreateStorageRoom(
        1,
        N'Москва, ул. Ленина, 10',
        N'Рядом с метро',
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

select * from StorageRoom;


begin
    CreateAdditionalServices(1, 1, 1, 0);
end;
/


declare v_room_picture_id number;
begin
    CreateRoomPicture(1, 'http://example.com/warehouse1.jpg', v_room_picture_id);
end;
/

declare v_rental_payments_id number;
begin
    CreateRentalPayment(50000, 1, 0, v_rental_payments_id);
end;
/


declare v_rental_payments_id number;
begin
    CreateRentalPayment(50000, 1, 0, v_rental_payments_id);
end;
/

declare v_rental_period_id number;
begin
    CreateRentalPeriod(date '2025-01-01', date '2026-01-01', 'Возможность продления', v_rental_period_id);
end;
/

declare v_rental_conditions_id number;
begin
    CreateRentalCondition(
        'Арендатор должен содержать помещение в чистоте',
        'Арендодатель обязан поддерживать коммуникации',
        'Использование только по назначению',
        'Ответственность за повреждения лежит на арендаторе',
        v_rental_conditions_id
    );
end;
/

begin
    CreateContractAgreement(101, 1, 1, 1, 1, 1, 1, 10000,
        'Депозит возвращается при расторжении',
        'Минимальный срок – 1 год',
        date '2025-01-01', date '2026-01-01',
        5000, 'Штраф за досрочное расторжение 10% от суммы');
end;
/

declare v_deal_id number;
begin
    CreateDeal(101, 1, 1, 'Успешное заключение сделки', 5, v_deal_id);
end;
/

declare v_rental_application_id number;
begin
    CreateRentalApplication(1, 1, 'Аренда', 1, v_rental_application_id);
end;
/

declare v_room_id number;
begin
    CreateStorageRoom(1, 'Санкт-Петербург, Невский проспект, 50', 'Рядом с ж/д вокзалом', 'Торговый центр',
                      1200, 40, 30, 5, 900, 300, 1, 1, 1, v_room_id);

    CreateStorageRoom(1, 'Казань, ул. Баумана, 7', 'Транспортный узел', 'Рядом кафе и магазины',
                      800, 35, 25, 4, 700, 100, 0, 1, 1, v_room_id);

    CreateStorageRoom(1, 'Новосибирск, Красный проспект, 20', 'Рядом аэропорт', 'Гостиница, бизнес-центр',
                      1500, 50, 35, 6, 1100, 400, 1, 0, 1, v_room_id);

    CreateStorageRoom(1, 'Екатеринбург, ул. Ленина, 100', 'Остановка общественного транспорта', 'ТЦ, банк',
                      950, 30, 30, 5, 850, 100, 0, 0, 1, v_room_id);

    CreateStorageRoom(1, 'Ростов-на-Дону, ул. Пушкинская, 15', 'Рядом порт', 'Гостиница, кафе',
                      1100, 45, 28, 5, 1000, 100, 1, 1, 1, v_room_id);
end;
/



commit;