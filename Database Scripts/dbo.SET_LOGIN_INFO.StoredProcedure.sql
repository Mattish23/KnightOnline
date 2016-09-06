USE [KN_online]
GO
/****** Object:  StoredProcedure [dbo].[SET_LOGIN_INFO]    Script Date: 09/06/2016 13:01:57 ******/
DROP PROCEDURE [dbo].[SET_LOGIN_INFO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- onurcanbektas
-- 09/06/2016
-- =============================================
CREATE PROCEDURE [dbo].[SET_LOGIN_INFO]
@nRet int OUTPUT,
@AccountID varchar(21),
@CharID varchar(30),--need to check the exact size
@ServerNo int,
@ServerIP varchar(15),
@ClientIP varchar(15),
@Init int
AS

IF @Init = 1
BEGIN
INSERT INTO CURRENTUSER (strAccountID, strCharID, nServerNo, strServerIP, strClientIP) VALUES ( @AccountID, @CharID, @ServerNo, @ServerIP, @ClientIP )

	IF @@ERROR <> 0
	BEGIN	 
		SET @nRet = 0
		RETURN @nRet
	END

END

IF @Init = 2 --not used in 1298
BEGIN
UPDATE CURRENTUSER SET nServerNo = @ServerNo, strServerIP = @ServerIP WHERE strAccountID = @AccountID

	IF @@ERROR <> 0
	BEGIN	  
		SET @nRet = 0
		RETURN @nRet
	END
	
END
SET @nRet = 1
RETURN @nRet
GO
