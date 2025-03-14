CREATE OR REPLACE PROCEDURE CalculateRentalSums (
    PeriodType IN NUMBER
)
AS
    Year NUMBER;
    Month NUMBER;
    Quarter NUMBER;
    HalfYear VARCHAR2(20);
    RentalSum NUMBER;
BEGIN
    IF PeriodType = 1 THEN
        FOR rec IN (
            WITH CTE AS (
                SELECT
                    EXTRACT(YEAR FROM DateOfConclusion) AS Year,
                    EXTRACT(MONTH FROM DateOfConclusion) AS Month,
                    RP.MonthlyPayment
                FROM ContractAgreement CA
                JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
            )
            SELECT Year, Month, SUM(MonthlyPayment) AS RentalSum
            FROM CTE
            GROUP BY Year, Month
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Year: ' || rec.Year || ', Month: ' || rec.Month || ', RentalSum: ' || rec.RentalSum);
        END LOOP;

    ELSIF PeriodType = 2 THEN
        FOR rec IN (
            WITH CTE AS (
                SELECT
                    EXTRACT(YEAR FROM DateOfConclusion) AS Year,
                    CEIL(EXTRACT(MONTH FROM DateOfConclusion) / 3) AS Quarter,
                    RP.MonthlyPayment
                FROM ContractAgreement CA
                JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
            )
            SELECT Year, Quarter, SUM(MonthlyPayment * 3) AS RentalSum
            FROM CTE
            GROUP BY Year, Quarter
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Year: ' || rec.Year || ', Quarter: ' || rec.Quarter || ', RentalSum: ' || rec.RentalSum);
        END LOOP;

    ELSIF PeriodType = 3 THEN
        FOR rec IN (
            WITH CTE AS (
                SELECT
                    EXTRACT(YEAR FROM DateOfConclusion) AS Year,
                    CASE
                        WHEN EXTRACT(MONTH FROM DateOfConclusion) BETWEEN 1 AND 6 THEN 'First Half'
                        ELSE 'Second Half'
                    END AS HalfYear,
                    RP.MonthlyPayment
                FROM ContractAgreement CA
                JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
            )
            SELECT Year, HalfYear, SUM(MonthlyPayment * 6) AS RentalSum
            FROM CTE
            GROUP BY Year, HalfYear
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Year: ' || rec.Year || ', HalfYear: ' || rec.HalfYear || ', RentalSum: ' || rec.RentalSum);
        END LOOP;

    ELSIF PeriodType = 4 THEN
        FOR rec IN (
            WITH CTE AS (
                SELECT
                    EXTRACT(YEAR FROM DateOfConclusion) AS Year,
                    RP.MonthlyPayment
                FROM ContractAgreement CA
                JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
            )
            SELECT Year, SUM(MonthlyPayment * 12) AS RentalSum
            FROM CTE
            GROUP BY Year
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Year: ' || rec.Year || ', RentalSum: ' || rec.RentalSum);
        END LOOP;

    ELSE
        DBMS_OUTPUT.PUT_LINE('Ошибка: Неверный тип периода. Допустимые значения: 1 (Месяц), 2 (Квартал), 3 (Полугодие), 4 (Год).');
    END IF;
END;
/

begin
    CalculateRentalSums(3);
end;


CREATE OR REPLACE PROCEDURE CalculateRentalSumsByRoom (
    StartDate IN DATE,
    EndDate IN DATE
)
AS
BEGIN
    FOR rec IN (
        SELECT
            SR.RoomID,
            SUM(RP.MonthlyPayment) AS RoomTotal
        FROM ContractAgreement CA
        JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
        JOIN StorageRoom SR ON CA.RoomID = SR.RoomID
        WHERE CA.DateOfConclusion BETWEEN StartDate AND EndDate
        GROUP BY SR.RoomID
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('RoomID: ' || rec.RoomID || ', RoomTotal: ' || rec.RoomTotal);
    END LOOP;

    FOR rec2 IN (
        SELECT SUM(RoomTotal) AS TotalRentalSum
        FROM (
            SELECT
                SUM(RP.MonthlyPayment) AS RoomTotal
            FROM ContractAgreement CA
            JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
            JOIN StorageRoom SR ON CA.RoomID = SR.RoomID
            WHERE CA.DateOfConclusion BETWEEN StartDate AND EndDate
            GROUP BY SR.RoomID
        )
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('TotalRentalSum: ' || rec2.TotalRentalSum);
    END LOOP;

    FOR rec3 IN (
        SELECT RoomID, RoomTotal AS MaxRoomTotal
        FROM (
            SELECT
                SR.RoomID,
                SUM(RP.MonthlyPayment) AS RoomTotal
            FROM ContractAgreement CA
            JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
            JOIN StorageRoom SR ON CA.RoomID = SR.RoomID
            WHERE CA.DateOfConclusion BETWEEN StartDate AND EndDate
            GROUP BY SR.RoomID
            ORDER BY RoomTotal DESC
        )
        WHERE ROWNUM = 1
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('RoomID: ' || rec3.RoomID || ', MaxRoomTotal: ' || rec3.MaxRoomTotal);
    END LOOP;

    FOR rec4 IN (
        SELECT
            RT.RoomID,
            RT.RoomTotal,
            TRS.TotalRentalSum,
            MR.MaxRoomTotal
        FROM (
            SELECT
                SR.RoomID,
                SUM(RP.MonthlyPayment) AS RoomTotal
            FROM ContractAgreement CA
            JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
            JOIN StorageRoom SR ON CA.RoomID = SR.RoomID
            WHERE CA.DateOfConclusion BETWEEN StartDate AND EndDate
            GROUP BY SR.RoomID
        ) RT
        CROSS JOIN (
            SELECT SUM(RoomTotal) AS TotalRentalSum
            FROM (
                SELECT
                    SUM(RP.MonthlyPayment) AS RoomTotal
                FROM ContractAgreement CA
                JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
                JOIN StorageRoom SR ON CA.RoomID = SR.RoomID
                WHERE CA.DateOfConclusion BETWEEN StartDate AND EndDate
                GROUP BY SR.RoomID
            )
        ) TRS
        CROSS JOIN (
            SELECT RoomID, RoomTotal AS MaxRoomTotal
            FROM (
                SELECT
                    SR.RoomID,
                    SUM(RP.MonthlyPayment) AS RoomTotal
                FROM ContractAgreement CA
                JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
                JOIN StorageRoom SR ON CA.RoomID = SR.RoomID
                WHERE CA.DateOfConclusion BETWEEN StartDate AND EndDate
                GROUP BY SR.RoomID
                ORDER BY RoomTotal DESC
            )
            WHERE ROWNUM = 1
        ) MR
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('RoomID: ' || rec4.RoomID || ', RoomTotal: ' || rec4.RoomTotal || ', TotalRentalSum: ' || rec4.TotalRentalSum || ', MaxRoomTotal: ' || rec4.MaxRoomTotal);
    END LOOP;
END;
/

begin
    CalculateRentalSumsByRoom(TO_DATE('2024-01-02', 'YYYY-MM-DD'), TO_DATE('2025-01-01', 'YYYY-MM-DD'));
end;
/

CREATE OR REPLACE PROCEDURE GetRentalSumsLast6Months
AS
    ClientID NUMBER;
    ClientType VARCHAR2(10);
    Year NUMBER;
    Month NUMBER;
    TotalRent NUMBER;
    MonthlyPayment NUMBER;
BEGIN
    FOR rec IN (
        WITH RentalSums AS (
            SELECT
                T.TenantID AS ClientID,
                'Tenant' AS ClientType,
                EXTRACT(YEAR FROM ADD_MONTHS(SYSDATE, -v.column_value)) AS Year,
                EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, -v.column_value)) AS Month,
                SUM(RP.MonthlyPayment) AS TotalRent
            FROM ContractAgreement CA
            JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
            JOIN Tenant T ON CA.TenantID = T.TenantID
            JOIN TABLE(CAST(MULTISET(
                SELECT LEVEL - 1 AS column_value
                FROM DUAL
                CONNECT BY LEVEL <= MONTHS_BETWEEN(CA.DateOfEndConclusion, CA.DateOfConclusion) + 1
            ) AS SYS.odcinumberlist)) v ON 1=1
            WHERE CA.DateOfConclusion >= ADD_MONTHS(SYSDATE, -6)
            GROUP BY T.TenantID, EXTRACT(YEAR FROM ADD_MONTHS(SYSDATE, -v.column_value)), EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, -v.column_value))

            UNION ALL

            SELECT
                L.LandlordID AS ClientID,
                'Landlord' AS ClientType,
                EXTRACT(YEAR FROM ADD_MONTHS(SYSDATE, -v.column_value)) AS Year,
                EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, -v.column_value)) AS Month,
                SUM(RP.MonthlyPayment) AS TotalRent
            FROM ContractAgreement CA
            JOIN RentalPayments RP ON CA.RentalPaymentsID = RP.RentalPaymentsID
            JOIN Landlord L ON CA.LandlordID = L.LandlordID
            JOIN TABLE(CAST(MULTISET(
                SELECT LEVEL - 1 AS column_value
                FROM DUAL
                CONNECT BY LEVEL <= MONTHS_BETWEEN(CA.DateOfEndConclusion, CA.DateOfConclusion) + 1
            ) AS SYS.odcinumberlist)) v ON 1=1
            WHERE CA.DateOfConclusion >= ADD_MONTHS(SYSDATE, -6)
            GROUP BY L.LandlordID, EXTRACT(YEAR FROM ADD_MONTHS(SYSDATE, -v.column_value)), EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, -v.column_value))
        )
        SELECT
            ClientType,
            Year,
            Month,
            SUM(TotalRent) AS MonthlyPayment
        FROM RentalSums
        GROUP BY ClientType, Year, Month
        ORDER BY Year DESC, Month DESC, ClientType
    ) LOOP
        ClientType := rec.ClientType;
        Year := rec.Year;
        Month := rec.Month;
        MonthlyPayment := rec.MonthlyPayment;

        DBMS_OUTPUT.PUT_LINE('ClientType: ' || ClientType || ', Year: ' || Year || ', Month: ' || Month || ', MonthlyPayment: ' || MonthlyPayment);
    END LOOP;
END;
/


begin
    GetRentalSumsLast6Months();
end;

CREATE OR REPLACE PROCEDURE GetMostFrequentlyRentedRoom
AS
BEGIN
    FOR rec IN (
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
        JOIN MaxRentalCount MRC ON RC.TenantID = MRC.TenantID AND RC.RentalCount = MRC.MaxCount
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('TenantID: ' || rec.TenantID || ', RoomID: ' || rec.RoomID || ', RentalCount: ' || rec.RentalCount);
    END LOOP;
END;
/

begin
    GetMostFrequentlyRentedRoom();
end;
