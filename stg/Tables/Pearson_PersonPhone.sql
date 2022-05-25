CREATE TABLE [stg].[Pearson_PersonPhone] (
    [BusinessEntityID]  INT           NULL,
    [PhoneNumber]       NVARCHAR (25) NULL,
    [PhoneNumberTypeID] INT           NULL,
    [ModifiedDate]      DATETIME      NULL,
    [Timestamp]         DATETIME      DEFAULT (getdate()) NULL
);

