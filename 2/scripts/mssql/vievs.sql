use warehouse_rental;
go

create view AvailableStorage as
select RoomID, Address, TotalArea, AvailableArea, Status
from StorageRoom
where Status = 1;

create view ContractDetails as
select
    c.ContractNumber,
    u1.Name as LandlordName,
    u2.Name as TenantName,
    s.Address,
    r.StartDate,
    r.EndDate,
    p.MonthlyPayment
from ContractAgreement c
join Landlord l on c.LandlordID = l.LandlordID
join Tenant t on c.TenantID = t.TenantID
join [User] u1 on l.UserID = u1.UserID
join [User] u2 on t.UserID = u2.UserID
join StorageRoom s on c.RoomID = s.RoomID
join RentalPeriod r on c.RentalPeriodID = r.RentalPeriodID
join RentalPayments p on c.RentalPaymentsID = p.RentalPaymentsID;

