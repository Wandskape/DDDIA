create or replace procedure LoginUser(
    p_login in varchar2,
    p_password in varchar2
) as
    v_user_id number;
begin
    select UserID
    into v_user_id
    from "User"
    where Login = p_login and Password = p_password;

    --dbms_output.put_line('Авторизация успешна. UserID: ' || v_user_id);
exception
    when no_data_found then
        --dbms_output.put_line('Ошибка: Неверный логин или пароль');
end LoginUser;
/


create or replace procedure SearchStorageRoomByAddress(
    p_address in nvarchar2
) as
begin
    for rec in (
        select * from StorageRoom
        where Address like '%' || p_address || '%'
    ) loop
        --dbms_output.put_line('RoomID: ' || rec.RoomID || ', Address: ' || rec.Address);
    end loop;
end SearchStorageRoomByAddress;
/

create or replace procedure FilterStorageRooms(
    p_min_area number default null,
    p_max_area number default null,
    p_room_cooling number default null,
    p_min_height number default null,
    p_max_height number default null,
    p_min_available_area number default null,
    p_max_available_area number default null,
    p_status number default null
) as
begin
    for rec in (
        select * from StorageRoom
        where
            (p_min_area is null or TotalArea >= p_min_area) and
            (p_max_area is null or TotalArea <= p_max_area) and
            (p_room_cooling is null or RoomCooling = p_room_cooling) and
            (p_min_height is null or RoomHeight >= p_min_height) and
            (p_max_height is null or RoomHeight <= p_max_height) and
            (p_min_available_area is null or AvailableArea >= p_min_available_area) and
            (p_max_available_area is null or AvailableArea <= p_max_available_area) and
            (p_status is null or Status = p_status)
    ) loop
        --dbms_output.put_line('RoomID: ' || rec.RoomID || ', Address: ' || rec.Address);
    end loop;
end FilterStorageRooms;
/



