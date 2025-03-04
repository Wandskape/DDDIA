--1
alter table StorageRoom add ParentRoomID number references StorageRoom(RoomID) on delete cascade;

--2
create or replace procedure GetChildRooms(
    p_RoomID in number
) is
begin
    for rec in (
        select RoomID, Address, HierarchyLevel
        from (
            select RoomID, Address, ParentRoomID, level as HierarchyLevel
            from StorageRoom
            start with RoomID = p_RoomID
            connect by prior RoomID = ParentRoomID
        )
    ) loop
        dbms_output.put_line('RoomID: ' || rec.RoomID || ' | Address: ' || rec.Address || ' | Level: ' || rec.HierarchyLevel);
    end loop;
end GetChildRooms;
/

begin
    GetChildRooms(5);
end;
/
--3
create or replace procedure AddChildRoom(
    p_ParentRoomID in number,
    p_Address nvarchar2,
    p_TransportHubs nvarchar2,
    p_InfrastructureNear nvarchar2,
    p_TotalArea number,
    p_RoomLength number,
    p_RoomWidth number,
    p_RoomHeight number,
    p_AvailableArea number,
    p_SpecificNeedsArea number,
    p_RoomCooling number,
    p_SunriseSide number,
    p_Status number
) is
begin
    insert into StorageRoom
    (ParentRoomID, Address, TransportHubs, InfrastructureNear, TotalArea, RoomLength, RoomWidth, RoomHeight, AvailableArea, SpecificNeedsArea, RoomCooling, SunriseSide, Status)
    values
    (p_ParentRoomID, p_Address, p_TransportHubs, p_InfrastructureNear, p_TotalArea, p_RoomLength, p_RoomWidth, p_RoomHeight, p_AvailableArea, p_SpecificNeedsArea, p_RoomCooling, p_SunriseSide, p_Status);
end AddChildRoom;
/

begin
    AddChildRoom(1, 'Подсклад 1.1', 'Рядом с портом', 'Офисы рядом', 500, 20, 25, 10, 450, 50, 1, 0, 1);
end;
/

--4
create or replace procedure MoveChildRooms(
    p_OldParentID in number,
    p_NewParentID in number
) is
begin
    update StorageRoom
    set ParentRoomID = p_NewParentID
    where ParentRoomID = p_OldParentID;
end MoveChildRooms;
/

begin
    MoveChildRooms(1, 3);
end;
/

