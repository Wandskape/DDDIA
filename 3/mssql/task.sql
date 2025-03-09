use warehouse_rental;
go


--1
alter table StorageRoom add
    ParentRoomID int null references StorageRoom(RoomID);

--2
create procedure GetChildRooms
    @RoomID int
as
begin
    with RoomHierarchy as (
        select RoomID, Address, ParentRoomID, 0 as Level
        from StorageRoom
        where RoomID = @RoomID
        union all
        select s.RoomID, s.Address, s.ParentRoomID, rh.Level + 1
        from StorageRoom s
        join RoomHierarchy rh on s.ParentRoomID = rh.RoomID
    )
    select RoomID, Address, Level from RoomHierarchy;
end;

exec GetChildRooms @RoomID = 4;

--3
create procedure AddChildRoom
    @ParentRoomID int,
    @Address nvarchar(100),
    @TransportHubs nvarchar(255),
    @InfrastructureNear nvarchar(255),
    @TotalArea float,
    @RoomLength float,
    @RoomWidth float,
    @RoomHeight float,
    @AvailableArea float,
    @SpecificNeedsArea float,
    @RoomCooling bit,
    @SunriseSide bit,
    @Status bit
as
begin
    insert into StorageRoom
    (ParentRoomID, Address, TransportHubs, InfrastructureNear, TotalArea, RoomLength, RoomWidth, RoomHeight, AvailableArea, SpecificNeedsArea, RoomCooling, SunriseSide, Status)
    values
    (@ParentRoomID, @Address, @TransportHubs,
     @InfrastructureNear, @TotalArea,
     @RoomLength, @RoomWidth, @RoomHeight,
     @AvailableArea, @SpecificNeedsArea, @RoomCooling,
     @SunriseSide, @Status);
end;


exec AddChildRoom
    @ParentRoomID = 4,
    @Address = N'Подсклад 1.1',
    @TransportHubs = N'Рядом с портом',
    @InfrastructureNear = N'Офисы рядом',
    @TotalArea = 500,
    @RoomLength = 20,
    @RoomWidth = 25,
    @RoomHeight = 10,
    @AvailableArea = 450,
    @SpecificNeedsArea = 50,
    @RoomCooling = 1,
    @SunriseSide = 0,
    @Status = 1;


--4
create procedure MoveChildRooms
    @OldParentID int,
    @NewParentID int
as
begin
    update StorageRoom
    set ParentRoomID = @NewParentID
    where ParentRoomID = @OldParentID;
end;

exec MoveChildRooms @OldParentID = 4, @NewParentID = 5;



