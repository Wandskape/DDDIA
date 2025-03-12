use warehouse_rental;
go

CREATE PROCEDURE CalculateRentalSums
    @PeriodType INT
AS
BEGIN
    IF @PeriodType = 1
    BEGIN
        WITH CTE AS (
            SELECT
                YEAR(DateOfConclusion) AS Year,
                MONTH(DateOfConclusion) AS Month,
                RP.MonthlyPayment
            FROM ContractAgreement CA
            JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
        )
        SELECT Year, Month, SUM(MonthlyPayment) AS RentalSum
        FROM CTE
        GROUP BY Year, Month;
    END
    ELSE IF @PeriodType = 2
    BEGIN
        WITH CTE AS (
            SELECT
                YEAR(DateOfConclusion) AS Year,
                DATEPART(QUARTER, DateOfConclusion) AS Quarter,
                RP.MonthlyPayment
            FROM ContractAgreement CA
            INNER JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
        )
        SELECT Year, Quarter, SUM(MonthlyPayment * 3) AS RentalSum
        FROM CTE
        GROUP BY Year, Quarter;
    END
    ELSE IF @PeriodType = 3
    BEGIN
        WITH CTE AS (
            SELECT
                YEAR(DateOfConclusion) AS Year,
                CASE
                    WHEN MONTH(DateOfConclusion) BETWEEN 1 AND 6 THEN 'First Half'
                    ELSE 'Second Half'
                END AS HalfYear,
                RP.MonthlyPayment
            FROM ContractAgreement CA
            INNER JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
        )
        SELECT Year, HalfYear, SUM(MonthlyPayment * 6) AS RentalSum
        FROM CTE
        GROUP BY Year, HalfYear;
    END
    ELSE IF @PeriodType = 4
    BEGIN
        WITH CTE AS (
            SELECT
                YEAR(DateOfConclusion) AS Year,
                RP.MonthlyPayment
            FROM ContractAgreement CA
            INNER JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
        )
        SELECT Year, SUM(MonthlyPayment * 12) AS RentalSum
        FROM CTE
        GROUP BY Year;
    END
    ELSE
    BEGIN
        PRINT N'Ошибка: Неверный тип периода. Допустимые значения: 1 (Месяц), 2 (Квартал), 3 (Полугодие), 4 (Год).';
        RETURN;
    END
END;
GO

EXEC CalculateRentalSums @PeriodType = 4;

CREATE OR ALTER PROCEDURE CalculateRentalSumsByRoom
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT
        SR.RoomID,
        SUM(RP.MonthlyPayment) AS RoomTotal
    INTO #RoomTotals
    FROM ContractAgreement CA
    JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
    JOIN StorageRoom SR ON CA.RoomID = SR.RoomID
    WHERE CA.DateOfConclusion BETWEEN @StartDate AND @EndDate
    GROUP BY SR.RoomID;

    SELECT
        SUM(RoomTotal) AS TotalRentalSum
    INTO #TotalRentalSum
    FROM #RoomTotals;

    SELECT
        TOP 1 RoomID,
        RoomTotal AS MaxRoomTotal
    INTO #MaxRoom
    FROM #RoomTotals
    ORDER BY RoomTotal DESC;

    SELECT
        RT.RoomID,
        RT.RoomTotal,
        TRS.TotalRentalSum,
        MR.MaxRoomTotal
    FROM #RoomTotals RT
    CROSS JOIN #TotalRentalSum TRS
    CROSS JOIN #MaxRoom MR;

    DROP TABLE #RoomTotals;
    DROP TABLE #TotalRentalSum;
    DROP TABLE #MaxRoom;
END;

EXEC CalculateRentalSumsByRoom '2024-01-02', '2025-01-01';

CREATE OR ALTER PROCEDURE GetRentalSumsLast6Months
AS
BEGIN
    WITH RentalSums AS (
        SELECT
            T.TenantID AS ClientID,
            'Tenant' AS ClientType,
            YEAR(PM.MonthDate) AS Year,
            MONTH(PM.MonthDate) AS Month,
            SUM(RP.MonthlyPayment) AS TotalRent
        FROM ContractAgreement CA
        JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
        JOIN Tenant T ON CA.TenantID = T.TenantID
        CROSS APPLY (
            SELECT DATEADD(MONTH, v.number, CA.DateOfConclusion) AS MonthDate
            FROM master.dbo.spt_values v
            WHERE v.type = 'P' AND v.number BETWEEN 0 AND DATEDIFF(MONTH, CA.DateOfConclusion, CA.DateOfEndConclusion)
        ) PM
        WHERE CA.DateOfConclusion >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY T.TenantID, YEAR(PM.MonthDate), MONTH(PM.MonthDate)

        UNION ALL

        SELECT
            L.LandlordID AS ClientID,
            'Landlord' AS ClientType,
            YEAR(PM.MonthDate) AS Year,
            MONTH(PM.MonthDate) AS Month,
            SUM(RP.MonthlyPayment) AS TotalRent
        FROM ContractAgreement CA
        INNER JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
        INNER JOIN Landlord L ON CA.LandlordID = L.LandlordID
        CROSS APPLY (
            SELECT DATEADD(MONTH, v.number, CA.DateOfConclusion) AS MonthDate
            FROM master.dbo.spt_values v
            WHERE v.type = 'P' AND v.number BETWEEN 0 AND DATEDIFF(MONTH, CA.DateOfConclusion, CA.DateOfEndConclusion)
        ) PM
        WHERE CA.DateOfConclusion >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY L.LandlordID, YEAR(PM.MonthDate), MONTH(PM.MonthDate)
    )

    SELECT
        ClientType,
        Year,
        Month,
        SUM(TotalRent) AS MonthlyPayment
    FROM RentalSums
    GROUP BY ClientType, Year, Month
    ORDER BY Year DESC, Month DESC, ClientType;
END;
GO

EXEC GetRentalSumsLast6Months;

CREATE OR ALTER PROCEDURE GetMostFrequentlyRentedRoom
AS
BEGIN
    WITH RentalCount AS (
        SELECT
            CA.TenantID,
            CA.RoomID,
            COUNT(*) AS RentalCount
        FROM ContractAgreement CA
        GROUP BY CA.TenantID, CA.RoomID
    ),
    MaxRentalCount AS (
        SELECT
            TenantID,
            MAX(RentalCount) AS MaxCount
        FROM RentalCount
        GROUP BY TenantID
    )
    SELECT
        RC.TenantID,
        RC.RoomID,
        RC.RentalCount
    FROM RentalCount RC
    JOIN MaxRentalCount MRC ON RC.TenantID = MRC.TenantID AND RC.RentalCount = MRC.MaxCount;
END;


EXEC GetMostFrequentlyRentedRoom;


