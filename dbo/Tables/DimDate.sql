CREATE TABLE [dbo].[DimDate] (
    [DateKey]     CHAR (8)      NULL,
    [Date]        DATETIME      NULL,
    [DayOfMonth]  INT           NULL,
    [DayName]     NVARCHAR (30) NULL,
    [Month]       INT           NULL,
    [MonthName]   NVARCHAR (30) NULL,
    [Quarter]     INT           NULL,
    [QuarterName] VARCHAR (6)   NULL,
    [Year]        INT           NULL,
    [YearName]    VARCHAR (33)  NULL,
    [MonthYear]   NVARCHAR (34) NULL,
    [MMYYYY]      VARCHAR (32)  NULL,
    [IsWeekday]   INT           NULL,
    [CreatedDate] DATETIME      NOT NULL
);

