-- stdb_test.dbo.RPOS_CollectionsReceived definition
-- Drop table
DROP TABLE stdb_test.dbo.RPOS_CollectionsReceived;

CREATE TABLE stdb_test.dbo.RPOS_CollectionsReceived (
	odatacontext varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	odataetag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ID int NULL,
	Code_Account varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Num_Line bigint NULL,
	Code_Type varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Total_Collected numeric(11,3) NULL,
	HcmPersonnelNumberId varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Date_Expiration varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	NumDocum varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Payment varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Discount numeric(5,2) NULL,
	Date_Doc varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Observations varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Amount_Gross numeric(11,3) NULL,
	Moneda_Cobro varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Total_Discount numeric(11,3) NULL,
	Num_Check varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Num_Invoice varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Collecting_Type varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	transfer_status char(1) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT '0' NULL,
	Status_API varchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ErrorGenerado varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	id_d365 int NULL,
	Bank varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DepositNumber varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TotalAmountDeposit numeric(11,3) NULL,
	ReceiptNumberTelynet varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreationDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.RPOS_SalesOrderHeadersV2 definition

-- Drop table

DROP TABLE stdb_test.dbo.RPOS_SalesOrderHeadersV2;

CREATE TABLE stdb_test.dbo.RPOS_SalesOrderHeadersV2 (
	odataetag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	InvoiceCustomerAccountNumber varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PersonnelNumber varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PurchOrderFormNum varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ConfirmedReceiptDate varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	KCP_GRCOR_Order_Num varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	PaymMode varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesOrderNumber varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OrderingCustomerAccountNumber varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Status_API varchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT '0' NULL,
	ErrorGenerado varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DeliveryValidFrom varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DeliveryAddressLocationId varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL,
	InternalNote varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressNum_KCP int NULL,
	CONSTRAINT RPOS_SalesOrderHeadersV2_PK PRIMARY KEY (KCP_GRCOR_Order_Num)
);
 CREATE NONCLUSTERED INDEX RPOS_SalesOrderHeadersV2_CreateDate_IDX ON dbo.RPOS_SalesOrderHeadersV2 (  CreateDate ASC  , Status_API ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- stdb_test.dbo.RPOS_SalesOrderLines definition

-- Drop table

DROP TABLE stdb_test.dbo.RPOS_SalesOrderLines;

CREATE TABLE stdb_test.dbo.RPOS_SalesOrderLines (
	odatacontext varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	odataetag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ItemNumber varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DeliveryAddressDescription varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LineDiscountAmount varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DeliveryAddressCountryRegionId varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesUnitSymbol varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OrderedSalesQuantity varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesOrderNumber varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LineDiscountPercentage numeric(10,3) NULL,
	LineNumber int NOT NULL,
	LineAmount numeric(11,3) NULL,
	ReturnReasonCodeId varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	transfer_status char(1) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT '0' NULL,
	PurchOrderFormNum varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Status_API varchar(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	KCP_GRCOR_Order_Num varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ErrorGenerado varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesPrice numeric(11,3) NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL,
	Order_NumClient varchar(24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DiscountId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT RPOS_SalesOrderLines_PK PRIMARY KEY (KCP_GRCOR_Order_Num,LineNumber)
);


-- stdb_test.dbo.RPOS_SalesOrdersPromo definition

-- Drop table

DROP TABLE stdb_test.dbo.RPOS_SalesOrdersPromo;

CREATE TABLE stdb_test.dbo.RPOS_SalesOrdersPromo (
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL,
	dataAreaId varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	KCP_GRCOR_Order_Num varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	OfferID varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT RPOS_SalesOrdersPromo_PK PRIMARY KEY (KCP_GRCOR_Order_Num,OfferID)
);


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


-- stdb_test.dbo.WS_BusinessDocSalesInvoiceBases definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_BusinessDocSalesInvoiceBases;

CREATE TABLE stdb_test.dbo.WS_BusinessDocSalesInvoiceBases (
	odataEtag varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	InvoiceId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	InvoiceDate varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CustomerAccountNum varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	NCFType_KCP varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	InvoiceAmount varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DueDate varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PaymentMode varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Total_Collected varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SettleAmountMST real NULL,
	PendingBalanceCur real NULL,
	PendingBalanceMST real NULL,
	CustTableTableId varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SettleAmountCur real NULL,
	CurrencyCode varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.WS_CustomerGroups definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_CustomerGroups;

CREATE TABLE stdb_test.dbo.WS_CustomerGroups (
	odataEtag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CustomerGroupId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Description varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Type] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DefaultDimensionDisplayValue varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.WS_CustomerPaymentJournalHeaders definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_CustomerPaymentJournalHeaders;

CREATE TABLE stdb_test.dbo.WS_CustomerPaymentJournalHeaders (
	odataEtag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	JournalName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Description varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	JournalBatchNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.WS_CustomerPaymentJournalLines definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_CustomerPaymentJournalLines;

CREATE TABLE stdb_test.dbo.WS_CustomerPaymentJournalLines (
	odataEtag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DataAreaId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	MarkedInvoice varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LineNumber varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TransactionDate varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AccountType varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AccountDisplayValue varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PaymentMethodName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PaymentReference varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DebitAmount varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreditAmount varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CurrencyCode varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TransactionText varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	KCP_Seller varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	JournalBatchNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.WS_CustomerPostalAddresses definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_CustomerPostalAddresses;

CREATE TABLE stdb_test.dbo.WS_CustomerPostalAddresses (
	odataEtag varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CustomerAccountNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CustomerLegalEntityId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsPrimary varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsRoleDelivery varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsRoleBusiness varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressDescription varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressCountyId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressStreetNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	BuildingCompliment varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressCity varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressLongitude float NULL,
	AddressZipCode varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressStreet varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressLatitude float NULL,
	AddressCountryRegionId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsRoleHome varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsRoleInvoice varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressState varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PartyNumber varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressLocationId varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Effective varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL,
	KCP_Days varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	KCP_Freq varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	KCP_FreqOrder varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Route_KCP varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	VisitOrder_KCP int NULL,
	BusinessUnit_KCP varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressNum_KCP int NULL,
	PersonnelNumber varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


-- stdb_test.dbo.WS_CustomersV3 definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_CustomersV3;

CREATE TABLE stdb_test.dbo.WS_CustomersV3 (
	odataEtag text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CustomerAccount varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PersonFirstName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PersonMiddleName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	VATRegistrationNum_KCP varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PartyCountry varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressZipCode varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	FullPrimaryAddress text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PartyState varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PrimaryContactPhone varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PrimaryContactFax varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PrimaryContactEmail varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OnHoldStatus varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressLatitude varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressLongitude varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesCurrencyCode varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	WarehouseId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PaymentTerms varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesTaxGroup varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ContactPersonId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	EmployeeResponsibleNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CustomerGroupId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	KCP_BankImpTransPaymentAssignment varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Name text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreditLimit real NULL,
	AddressCity varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	IsGenericClient varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressStreet text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressBuildingComplement varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AddressStreetNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	RetailAffiliation varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriceGroupId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.WS_OpenSalesPriceJournalLines definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_OpenSalesPriceJournalLines;

CREATE TABLE stdb_test.dbo.WS_OpenSalesPriceJournalLines (
	odataEtag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ItemNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Price varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	QuantityUnitSymbol varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriceCurrencyCode varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriceApplicableFromDate varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriceApplicableToDate varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Base varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PriceListGroup varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	RecordId varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	status_api varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.WS_PaymentTerms definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_PaymentTerms;

CREATE TABLE stdb_test.dbo.WS_PaymentTerms (
	odataEtag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Description varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	NumberOfDays varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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


-- stdb_test.dbo.WS_ProdSpecificUnitOfMeasureConv definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_ProdSpecificUnitOfMeasureConv;

CREATE TABLE stdb_test.dbo.WS_ProdSpecificUnitOfMeasureConv (
	odataEtag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ProductNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	FromUnitSymbol varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Factor varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ToUnitSymbol varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	InnerOffset varchar(12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OuterOffset varchar(12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Rounding varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Denominator varchar(12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Numerator varchar(12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.WS_ProductCategoryAssignments definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_ProductCategoryAssignments;

CREATE TABLE stdb_test.dbo.WS_ProductCategoryAssignments (
	DataAreaId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ProductNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ProductCategoryName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.WS_ReleasedProductsV2 definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_ReleasedProductsV2;

CREATE TABLE stdb_test.dbo.WS_ReleasedProductsV2 (
	odataEtag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ItemNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ProductSearchName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SearchName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesUnitSymbol varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	InventoryUnitSymbol varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	NetProductWeight varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ProductVolume varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesSalesTaxItemGroupCode varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Unit_Type_Volume varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ProductNumber text COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Hierarchy4 varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Hierarchy5 varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Hierarchy6 varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Hierarchy1 varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Hierarchy2 varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Hierarchy3 varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ProductName varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_ClassificationB varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Stopped varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CommercialCost float NULL,
	AvailPhysical numeric(10,0) NULL,
	TaxPackagingQtyPrimary numeric(10,0) NULL,
	TaxPackagingQtySecondary numeric(10,0) NULL,
	TaxValue int NULL,
	AverageCostPriceUnit float NULL,
	AvailPhysicalExceptLocation10 numeric(10,0) NULL,
	AvailPhysicalbyLocation5 numeric(10,0) NULL,
	LowestQty numeric(10,0) NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL,
	KCP_GRCOR_BusinessUnit varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


-- stdb_test.dbo.WS_ResponsibleSellerTables definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_ResponsibleSellerTables;

CREATE TABLE stdb_test.dbo.WS_ResponsibleSellerTables (
	odataetag varchar(1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AccountNum varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PersonnelNumber varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.WS_RetailDiscountLineComb definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_RetailDiscountLineComb;

CREATE TABLE stdb_test.dbo.WS_RetailDiscountLineComb (
	createDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL,
	dataAreaId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	OfferId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Product varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	DiscountPercentOrValue decimal(18,0) NOT NULL,
	UnitOfMeasure varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	discountType varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	numberOfItemsNeeded int NOT NULL,
	Category varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
);


-- stdb_test.dbo.WS_RetailEcoResCategory definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_RetailEcoResCategory;

CREATE TABLE stdb_test.dbo.WS_RetailEcoResCategory (
	odataEtag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Level] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ParentCategory varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	KCP_GRCOR_BrandHierarchy varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	EcoResCategoryHierarchy_Name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AxRecId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Hierarchy1 varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Hierarchy2 varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Hierarchy3 varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Hierarchy4 varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Hierarchy5 varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_clasificationB varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Hierarchy6 varchar(250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.WS_SalesInvoiceV3Lines definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_SalesInvoiceV3Lines;

CREATE TABLE stdb_test.dbo.WS_SalesInvoiceV3Lines (
	odataEtag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LineCreationSequenceNumber varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ConfirmedShippingDate varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ProductNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	InvoicedQuantity varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesUnitSymbol varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesPrice varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LineAmount varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LineTotalDiscountAmount varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CurrencyCode varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Order_Num varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Order_Date varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Account varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Por_Discount1 varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Amount_Discount1 varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Por_Tax1 varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Amount_Tax1 varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Order_Type varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_ReturnCause varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PaymMode varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	KCP_GRCOR_Order_Num varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DiscPercent real NULL,
	PurchOrderFormNum varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ReturnReasonCodeId varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreatedDateTime1 varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DiscAmount real NULL,
	CustAccount varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesType varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TaxAmount real NULL,
	TaxValue real NULL,
	PersonnelNumber varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	AccountNum varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Type] varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	InvoiceNumber varchar(150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.WS_SalesOrderHeadersV2 definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_SalesOrderHeadersV2;

CREATE TABLE stdb_test.dbo.WS_SalesOrderHeadersV2 (
	odataEtag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DataAreaId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesOrderNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ConfirmedReceiptDate varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OrderingCustomerAccountNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	InvoiceCustomerAccountNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Type_Rec varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Order_Date varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Order_Num_Cli varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Paymentway varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Code_Seller varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PersonnelNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PurchOrderFormNum varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	KCP_GRCOR_Order_Num varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PaymMode varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.WS_SalesOrderLines definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_SalesOrderLines;

CREATE TABLE stdb_test.dbo.WS_SalesOrderLines (
	odataEtag varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	dataAreaId varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LineNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ItemNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	OrderedSalesQuantity varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesUnitSymbol varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesPrice varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LineAmount varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LineDiscountPercentage varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LineDiscountAmount varchar(18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CurrencyCode varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SalesOrderNumber varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	KCP_GRCOR_Order_Num varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DeliveryAddressDescription varchar(2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DeliveryAddressCountryRegionId varchar(2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ReturnReasonCodeId varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL
);


-- stdb_test.dbo.WS_UnitsOfMeasure definition

-- Drop table

DROP TABLE stdb_test.dbo.WS_UnitsOfMeasure;

CREATE TABLE stdb_test.dbo.WS_UnitsOfMeasure (
	UnitSymbol varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UnitClass varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UnitDescription varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CreateDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL,
	KCP_GRCOR_TelynetUnit varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


-- stdb_test.dbo.d365_ws_control definition

-- Drop table

DROP TABLE stdb_test.dbo.d365_ws_control;

CREATE TABLE stdb_test.dbo.d365_ws_control (
	data_area_id varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	service_name varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	service_url varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	client_id varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	client_secret varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	token_endpoint varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	token_resource varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	last_run_time datetime NULL,
	minutes_interval int NULL,
	next_run_time datetime NULL,
	enable bit DEFAULT 1 NOT NULL,
	CONSTRAINT d365_ws_control_pk PRIMARY KEY (data_area_id,service_name)
);


-- stdb_test.dbo.ws_CustomerAffiliations definition

-- Drop table

DROP TABLE stdb_test.dbo.ws_CustomerAffiliations;

CREATE TABLE stdb_test.dbo.ws_CustomerAffiliations (
	createDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL,
	dataAreaId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CustomerAccount varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	RetailAffiliationName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


-- stdb_test.dbo.ws_RetailDiscountHeaderComb definition

-- Drop table

DROP TABLE stdb_test.dbo.ws_RetailDiscountHeaderComb;

CREATE TABLE stdb_test.dbo.ws_RetailDiscountHeaderComb (
	createDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL,
	dataAreaId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	OfferId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ConcurrencyMode varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	DealPriceValue decimal(18,0) NOT NULL,
	DiscountPercentValue decimal(18,0) NOT NULL,
	PeriodicDiscountType varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ValidFrom varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CurrencyCode varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	PriceDiscGroup varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	DiscountAmountValue decimal(18,0) NULL,
	ValidTo varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Status varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	MultibuyDiscountType varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	MixAndMatchDiscountType varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	NameAffiliation varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CombNameAffiliation varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


-- stdb_test.dbo.ws_RetailDiscountHeaderQty definition

-- Drop table

DROP TABLE stdb_test.dbo.ws_RetailDiscountHeaderQty;

CREATE TABLE stdb_test.dbo.ws_RetailDiscountHeaderQty (
	createDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL,
	dataAreaId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	OfferId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ConcurrencyMode varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	PeriodicDiscountType varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ValidFrom varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CurrencyCode varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	PriceDiscGroup varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ValidTo varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	qtyLowest int NOT NULL,
	Status varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	MultibuyDiscountType varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	priceDiscPct decimal(18,0) NOT NULL,
	NameAffiliation varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CombNameAffiliation varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


-- stdb_test.dbo.ws_RetailDiscountHeaderSimple definition

-- Drop table

DROP TABLE stdb_test.dbo.ws_RetailDiscountHeaderSimple;

CREATE TABLE stdb_test.dbo.ws_RetailDiscountHeaderSimple (
	createDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL,
	dataAreaId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	OfferId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	PeriodicDiscountType varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CurrencyCode varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Status varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ValidTo varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ConcurrencyMode varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	PriceDiscGroup varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ValidFrom varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	NameAffiliation varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


-- stdb_test.dbo.ws_RetailDiscountLineQty definition

-- Drop table

DROP TABLE stdb_test.dbo.ws_RetailDiscountLineQty;

CREATE TABLE stdb_test.dbo.ws_RetailDiscountLineQty (
	createDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL,
	dataAreaId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	OfferId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Product varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	UnitOfMeasure varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Category varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
);


-- stdb_test.dbo.ws_RetailDiscountLineSimple definition

-- Drop table

DROP TABLE stdb_test.dbo.ws_RetailDiscountLineSimple;

CREATE TABLE stdb_test.dbo.ws_RetailDiscountLineSimple (
	createDate datetime DEFAULT getdate() NULL,
	ModifyDate datetime DEFAULT getdate() NULL,
	dataAreaId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	OfferId varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Product varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	discAmount decimal(18,0) NOT NULL,
	Name varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	UnitOfMeasure varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	discPct decimal(18,0) NOT NULL,
	discountMethod varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Category varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
);

