Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2810662FF0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbjAITJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbjAITIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:08:37 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16915395C4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:08:36 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vm8so22636456ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSqVE1Npu53dUzMwRfFPsKJ6inkj7DGO4q2n7SdPytE=;
        b=TesMS0/DQOi3fKCr2VJGm2ih+k3XV+kWtuMJRKQTasW3NylH6qTchH3fE+DuxsxdWg
         9x3PIDRlDcpoIepR3Ed4BkTBkGWhgagu4upcv/kxEEgsjf6GClDM8z1IHcnmkHPqn+DU
         lsn7fxD6ya08HKC+KPwPsoUbt8WIL/zBq7i5GdpQxy7gKAxdP3BBIgPxWzIWtzipT4p+
         LiXMnaL2mOTRm/KXC31HLVCvPkw5fKIpPikDi7AksW33wg5MJ95vFNjjMVyJhUJ28g1D
         iS++ccAkzE+3KkLBEWmYcAhbhAD83o4pox3DL7wSJ+fPZvhsiqulpgQUFvtxGfJS4cLf
         ClUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSqVE1Npu53dUzMwRfFPsKJ6inkj7DGO4q2n7SdPytE=;
        b=AeL0c8rJcMMWnO+D351beJPkyzKIa0SxmLQLskCLk1YmALXu+bIWxZiMD1cn/jpfNy
         NrQP727jVlepct6vU5S+9kqbLaLv8Ww9Y1qxc2uo3WxOcakclSjRVivp5QJR/+eX1EwM
         3XVivKrQktsGo4r4IpkBxo3XX0sjCQ5suxyVeYMnCrvNz1ejCB2ksb0JIEEMPTPQvXti
         7/zkPjhgLmU8W6Q+NCHxrcbE49Wyq1hcRfErq5Bb6SpUKt/diqoqYr90NFFny04LrLt0
         lConwGl6G4s5q+akWZNCip58f0iHocJ+79GID3OI4v/8P/jZisSXDXSevxTSCA+qS3ZU
         dL7A==
X-Gm-Message-State: AFqh2koOV1SdY/eJ53oqOlKGnr8x/Sb172UyRM3x9+nmY4btBtkgAH0z
        UsLU8NgDncfJ+lbVxEApgjA=
X-Google-Smtp-Source: AMrXdXvYvHRQEOVQLJyX1pVSaculzteW2U+AZXTiGy3kvUz4bxtPENj6VGNi77khMDlQQTEc2YOG9A==
X-Received: by 2002:a17:906:6a1a:b0:7a6:65c:5104 with SMTP id qw26-20020a1709066a1a00b007a6065c5104mr16880421ejc.6.1673291314724;
        Mon, 09 Jan 2023 11:08:34 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id sh39-20020a1709076ea700b007c0e6d6bd10sm4090039ejc.132.2023.01.09.11.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:08:34 -0800 (PST)
Date:   Mon, 9 Jan 2023 20:08:32 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] staging: rtl8192e: Rename TSSI_13dBm, Pwr_Track and
 NumTotalRFPath
Message-ID: <d3bb45535b7babd1cb8df437ca238eb0ce93c9fe.1673290428.git.philipp.g.hortmann@gmail.com>
References: <cover.1673290428.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673290428.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable TSSI_13dBm to tssi_13dBm, Pwr_Track to pwr_track and
NumTotalRFPath to num_total_rf_path to avoid CamelCase which is not
accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Changed TSSI_13dBm to tssi_13dBm instead of tssi_13dbm
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c |  8 ++++----
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |  2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |  6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         | 14 +++++++-------
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index 93928f3585c1..7517ec001421 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -21,7 +21,7 @@ void rtl92e_set_bandwidth(struct net_device *dev,
 		return;
 	}
 
-	for (eRFPath = 0; eRFPath < priv->NumTotalRFPath; eRFPath++) {
+	for (eRFPath = 0; eRFPath < priv->num_total_rf_path; eRFPath++) {
 		if (!rtl92e_is_legal_rf_path(dev, eRFPath))
 			continue;
 
@@ -63,10 +63,10 @@ bool rtl92e_config_rf(struct net_device *dev)
 	u8	ConstRetryTimes = 5, RetryTimes = 5;
 	u8 ret = 0;
 
-	priv->NumTotalRFPath = RTL819X_TOTAL_RF_PATH;
+	priv->num_total_rf_path = RTL819X_TOTAL_RF_PATH;
 
 	for (eRFPath = (enum rf90_radio_path)RF90_PATH_A;
-	     eRFPath < priv->NumTotalRFPath; eRFPath++) {
+	     eRFPath < priv->num_total_rf_path; eRFPath++) {
 		if (!rtl92e_is_legal_rf_path(dev, eRFPath))
 			continue;
 
@@ -195,7 +195,7 @@ void rtl92e_set_ofdm_tx_power(struct net_device *dev, u8 powerlevel)
 		if (index == 3) {
 			writeVal_tmp = (byte3 << 24) | (byte2 << 16) |
 				       (byte1 << 8) | byte0;
-			priv->Pwr_Track = writeVal_tmp;
+			priv->pwr_track = writeVal_tmp;
 		}
 
 		if (priv->bDynamicTxHighPower)
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 25fa7714df4e..8b61c7581fe0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -371,7 +371,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 						   0xff00) >> 8;
 		else
 			priv->EEPROMThermalMeter = EEPROM_Default_ThermalMeter;
-		priv->TSSI_13dBm = priv->EEPROMThermalMeter * 100;
+		priv->tssi_13dBm = priv->EEPROMThermalMeter * 100;
 
 		if (priv->epromtype == EEPROM_93C46) {
 			if (!priv->AutoloadFailFlag) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index a813eded4cb3..ccbce3e177b6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -904,7 +904,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 				break;
 			case CmdID_RF_WriteReg:
 				for (eRFPath = 0; eRFPath <
-				     priv->NumTotalRFPath; eRFPath++)
+				     priv->num_total_rf_path; eRFPath++)
 					rtl92e_set_rf_reg(dev,
 						 (enum rf90_radio_path)eRFPath,
 						 CurrentCmd->Para1, bMask12Bits,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 93b3b75a063f..825cb8ce06c0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -445,7 +445,7 @@ struct r8192_priv {
 	u8 nCur40MhzPrimeSC;
 
 	u32 RfReg0Value[4];
-	u8 NumTotalRFPath;
+	u8 num_total_rf_path;
 	bool brfpath_rxenable[4];
 
 	bool bTXPowerDataReadFromEEPORM;
@@ -461,8 +461,8 @@ struct r8192_priv {
 	u8 DM_Type;
 
 	u8 cck_pwr_enl;
-	u16 TSSI_13dBm;
-	u32 Pwr_Track;
+	u16 tssi_13dBm;
+	u32 pwr_track;
 	u8 CCKPresentAttentuation_20Mdefault;
 	u8 CCKPresentAttentuation_40Mdefault;
 	s8 CCKPresentAttentuation_difference;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index a18393c8a833..6cd49b3f6408 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -615,14 +615,14 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	u8	RF_Type, tmp_report[5] = {0, 0, 0, 0, 0};
 	u32	Value;
 	u8	Pwr_Flag;
-	u16	Avg_TSSI_Meas, TSSI_13dBm, Avg_TSSI_Meas_from_driver = 0;
+	u16	Avg_TSSI_Meas, tssi_13dBm, Avg_TSSI_Meas_from_driver = 0;
 	u32	delta = 0;
 
 	rtl92e_writeb(dev, Pw_Track_Flag, 0);
 	rtl92e_writeb(dev, FW_Busy_Flag, 0);
 	priv->rtllib->bdynamic_txpower_enable = false;
 
-	powerlevelOFDM24G = priv->Pwr_Track >> 24;
+	powerlevelOFDM24G = priv->pwr_track >> 24;
 	RF_Type = priv->rf_type;
 	Value = (RF_Type<<8) | powerlevelOFDM24G;
 
@@ -688,12 +688,12 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 				Avg_TSSI_Meas_from_driver += tmp_report[k];
 
 			Avg_TSSI_Meas_from_driver *= 100 / 5;
-			TSSI_13dBm = priv->TSSI_13dBm;
+			tssi_13dBm = priv->tssi_13dBm;
 
-			if (Avg_TSSI_Meas_from_driver > TSSI_13dBm)
-				delta = Avg_TSSI_Meas_from_driver - TSSI_13dBm;
+			if (Avg_TSSI_Meas_from_driver > tssi_13dBm)
+				delta = Avg_TSSI_Meas_from_driver - tssi_13dBm;
 			else
-				delta = TSSI_13dBm - Avg_TSSI_Meas_from_driver;
+				delta = tssi_13dBm - Avg_TSSI_Meas_from_driver;
 
 			if (delta <= E_FOR_TX_POWER_TRACK) {
 				priv->rtllib->bdynamic_txpower_enable = true;
@@ -701,7 +701,7 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 				rtl92e_writeb(dev, FW_Busy_Flag, 0);
 				return;
 			}
-			if (Avg_TSSI_Meas_from_driver < TSSI_13dBm - E_FOR_TX_POWER_TRACK)
+			if (Avg_TSSI_Meas_from_driver < tssi_13dBm - E_FOR_TX_POWER_TRACK)
 				_rtl92e_dm_tx_update_tssi_weak_signal(dev,
 								      RF_Type);
 			else
-- 
2.39.0

