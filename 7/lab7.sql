SELECT
    UserID,
    Login,
    Name,
    COUNT(Month) AS ContractMonths,
    ROUND(MIN(CurrentYearPayment), 2) AS MinPayment,
    ROUND(MAX(CurrentYearPayment), 2) AS MaxPayment,
    ROUND(AVG(CurrentYearPayment * 1.10), 2) AS AvgNextYearPayment
FROM (
    SELECT
        u.UserID,
        u.Login,
        u.Name,
        EXTRACT(MONTH FROM ca.DateOfConclusion) AS Month,
        AVG(rp.MonthlyPayment) AS CurrentYearPayment
    FROM
        "User" u
        JOIN Tenant t ON u.UserID = t.UserID
        JOIN ContractAgreement ca ON t.TenantID = ca.TenantID
        JOIN RentalPayments rp ON ca.RentalPaymentsID = rp.RentalPaymentsID
    WHERE
        EXTRACT(YEAR FROM ca.DateOfConclusion) = EXTRACT(YEAR FROM SYSDATE) - 1
    GROUP BY
        u.UserID,
        u.Login,
        u.Name,
        EXTRACT(MONTH FROM ca.DateOfConclusion)
)
GROUP BY
    UserID, Login, Name
ORDER BY
    UserID;

SELECT *
FROM (
    SELECT
        sr.RoomID,
        sr.Address,
        ca.DateOfConclusion,
        LEAD(ca.DateOfConclusion) OVER (PARTITION BY sr.RoomID ORDER BY ca.DateOfConclusion) AS NextContractDate,
        CASE
            WHEN LEAD(ca.DateOfConclusion) OVER (PARTITION BY sr.RoomID ORDER BY ca.DateOfConclusion) IS NULL
            THEN 0
            ELSE 1
        END AS StatusChange
    FROM
        StorageRoom sr
        LEFT JOIN ContractAgreement ca ON sr.RoomID = ca.RoomID
)
MATCH_RECOGNIZE (
    PARTITION BY RoomID
    ORDER BY DateOfConclusion
    MEASURES
        MATCH_NUMBER() AS match_num,
        CLASSIFIER() AS pattern,
        FIRST(DateOfConclusion) AS start_date,
        LAST(DateOfConclusion) AS end_date,
        COUNT(*) AS pattern_length
    ONE ROW PER MATCH
    AFTER MATCH SKIP TO LAST DOWN
    PATTERN (UP DOWN UP)
    DEFINE
        UP AS (StatusChange = 1),
        DOWN AS (StatusChange = 0)
)
ORDER BY
    RoomID, start_date;


SELECT *
FROM (
    SELECT
        sr.RoomID,
        sr.Address,
        ca.DateOfConclusion,
        LEAD(ca.DateOfConclusion) OVER (PARTITION BY sr.RoomID ORDER BY ca.DateOfConclusion) AS NextContractDate,
        CASE
            WHEN LEAD(ca.DateOfConclusion) OVER (PARTITION BY sr.RoomID ORDER BY ca.DateOfConclusion) IS NULL
            THEN 0
            ELSE 1
        END AS StatusChange
    FROM
        StorageRoom sr
        LEFT JOIN ContractAgreement ca ON sr.RoomID = ca.RoomID
)
MATCH_RECOGNIZE (
    PARTITION BY RoomID
    ORDER BY DateOfConclusion
    MEASURES
        MATCH_NUMBER() AS match_num,
        CLASSIFIER() AS pattern,
        FIRST(DateOfConclusion) AS start_date,
        LAST(DateOfConclusion) AS end_date,
        COUNT(*) AS pattern_length
    ONE ROW PER MATCH
    AFTER MATCH SKIP TO LAST DOWN
    PATTERN (UP DOWN | DOWN UP) -- Ищем либо рост-падение, либо падение-рост
    DEFINE
        UP AS (StatusChange = 1),
        DOWN AS (StatusChange = 0)
)
ORDER BY
    RoomID, start_date;

INSERT INTO RentalPayments (MonthlyPayment, PaymentSchedule, PaymentMethod) VALUES
(5000, 1, 1);
INSERT INTO RentalPayments (MonthlyPayment, PaymentSchedule, PaymentMethod) VALUES
(6000, 1, 1);

INSERT INTO RentalPeriod (StartDate, EndDate, PossibilityOfExtensions) VALUES
(TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('01-03-2023', 'DD-MM-YYYY'), 'Да');
INSERT INTO RentalPeriod (StartDate, EndDate, PossibilityOfExtensions) VALUES
(TO_DATE('01-05-2023', 'DD-MM-YYYY'), TO_DATE('01-07-2023', 'DD-MM-YYYY'), 'Да');

INSERT INTO RentalConditions (ObligationsOfTenant, ObligationsOfLandlord,
                             ConditionsOfUseStorageFacilities, LiabilityDamages) VALUES
('Содержать в чистоте', 'Ремонтировать', 'Использовать по назначению', 'Возмещать ущерб');

INSERT INTO ContractAgreement (ContractNumber, LandlordID, TenantID, RoomID,
                              RentalPeriodID, RentalPaymentsID, RentalConditionsID,
                              DepositAmount, TermsOfReturn, TermOfUse,
                              DateOfConclusion, DateOfEndConclusion, AmountOfFine,
                              TerminationConditions) VALUES
(1001, 1, 26, 1, 14, 10, 1, 10000, 'Возврат при окончании', '2 года',
 TO_DATE('01-01-2023', 'DD-MM-YYYY'), TO_DATE('01-03-2023', 'DD-MM-YYYY'), 5000, 'За 1 месяц');

INSERT INTO ContractAgreement (ContractNumber, LandlordID, TenantID, RoomID,
                              RentalPeriodID, RentalPaymentsID, RentalConditionsID,
                              DepositAmount, TermsOfReturn, TermOfUse,
                              DateOfConclusion, DateOfEndConclusion, AmountOfFine,
                              TerminationConditions) VALUES
(1002, 1, 27, 1, 15, 11, 1, 12000, 'Возврат при окончании', '2 года',
 TO_DATE('01-05-2023', 'DD-MM-YYYY'), TO_DATE('01-07-2023', 'DD-MM-YYYY'), 6000, 'За 1 месяц');

select * from TENANT;
select * from LANDLORD;

select * from RENTALPERIOD;

select * from RENTALPAYMENTS;

select * from RENTALCONDITIONS;

select * from ContractAgreement;

delete ContractAgreement where CONTRACTNUMBER = 1001;