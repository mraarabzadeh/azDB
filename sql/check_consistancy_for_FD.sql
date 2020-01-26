﻿-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
---- =============================================
---- Author:		<Author,,Name>
---- Create date: <Create Date,,>
---- Description:	<Description,,>
---- =============================================
--CREATE TRIGGER <Schema_Name, sysname, Schema_Name>.<Trigger_Name, sysname, Trigger_Name> 
--   ON  <Schema_Name, sysname, Schema_Name>.<Table_Name, sysname, Table_Name> 
--   AFTER <Data_Modification_Statements, , INSERT,DELETE,UPDATE>
--AS 
--BEGIN
--	-- SET NOCOUNT ON added to prevent extra result sets from
--	-- interfering with SELECT statements.
--	SET NOCOUNT ON;

--    -- Insert statements for trigger here

--END
--GO
CREATE TRIGGER	check_consistancy ON azDB.dbo.FullTimeDoctor
INSTEAD	OF INSERT
AS
DECLARE @DocId int
DECLARE @payment float
	SELECT @DocId=i.doctor_id FROM INSERTED i
	SELECT @payment= i.payment FROM INSERTED i
BEGIN
	IF(@DocId NOT IN	(SELECT 	ocd.doctor_id
						FROM  azDB.dbo.OnCallDoctor ocd))
		BEGIN
		INSERT INTO	dbo.FullTimeDoctor
		(
		    doctor_id,
		    payment
		)
		VALUES
		(
		    @DocId, -- doctor_id - int
		    @payment -- payment - money
		)	
		END
	else
	BEGIN
		PRINT	N'دکتر با این آی دی در دکتر های آن کال وجود دارد'
	END
END