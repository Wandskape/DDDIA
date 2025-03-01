use warehouse_rental;
go

create procedure LoginUser
    @login varchar(30),
    @password varchar(255)
as
begin
    declare @user_id int;

    select @user_id = userID
    from [user]
    where login = @login and password = @password;

    if @user_id is not null
    begin
        select userID, login, name, contactInformation
        from [user]
        where userID = @user_id;
    end
    else
    begin
        print 'Ошибка: Неверный логин или пароль';
    end
end;

create procedure SearchStorageRoomByAddress
    @address nvarchar(100)
as
begin
    select *
    from storageRoom
    where address like '%' + @address + '%';
end;


create procedure FilterStorageRooms
    @min_area float = null,
    @max_area float = null,
    @room_cooling bit = null,
    @min_height float = null,
    @max_height float = null,
    @min_available_area float = null,
    @max_available_area float = null,
    @status bit = null
as
begin
    select *
    from storageRoom
    where
        (@min_area is null or totalArea >= @min_area) and
        (@max_area is null or totalArea <= @max_area) and
        (@room_cooling is null or roomCooling = @room_cooling) and
        (@min_height is null or roomHeight >= @min_height) and
        (@max_height is null or roomHeight <= @max_height) and
        (@min_available_area is null or availableArea >= @min_available_area) and
        (@max_available_area is null or availableArea <= @max_available_area) and
        (@status is null or status = @status);
end;
