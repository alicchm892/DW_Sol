﻿CREATE TABLE [stg].[Pearson_Address] (
    [AddressID]       INT              NULL,
    [AddressLine1]    NVARCHAR (60)    NULL,
    [AddressLine2]    NVARCHAR (60)    NULL,
    [City]            NVARCHAR (30)    NULL,
    [StateProvinceID] INT              NULL,
    [PostalCode]      NVARCHAR (15)    NULL,
    [SpatialLocation] VARBINARY (MAX)  NULL,
    [rowguid]         UNIQUEIDENTIFIER NULL,
    [ModifiedDate]    DATETIME         NULL,
    [Timestamp]       DATETIME         DEFAULT (getdate()) NULL
);

