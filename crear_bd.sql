-- stdb_test.dbo.WS_AddressStates definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_AddressStates;

CREATE TABLE stdb_test.dbo.WS_AddressStates (
	odataEtag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	State varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CountryRegionId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);

-- stdb_test.dbo.WS_PositionsV2 definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_PositionsV2;

CREATE TABLE stdb_test.dbo.WS_PositionsV2 (
	odataEtag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	WorkerPersonnelNumber varchar(60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	WorkerName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PositionId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);

-- stdb_test.dbo.d365_ws_control definition

-- Drop table

DROP TABLE stdb_discor_prev365.dbo.d365_ws_control;

CREATE TABLE stdb_discor_prev365.dbo.d365_ws_control (
	data_area_id varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	service_name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	service_url varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	client_id varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	client_secret varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	token_endpoint varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	token_resource varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	table_name  varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	column_list varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	last_run_time datetime NULL,
	minutes_interval int NULL,
	next_run_time datetime NULL,
	enable bit DEFAULT 1 NOT NULL,
	CONSTRAINT d365_ws_control_pk PRIMARY KEY (data_area_id,service_name)
);

