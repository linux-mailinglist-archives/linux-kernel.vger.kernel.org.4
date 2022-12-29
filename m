Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6C658F09
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiL2Q0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiL2QZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:25:51 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E613D1E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:25:50 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qk9so46091121ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x8lP7ydRMGUwV1Ross2Ed1IrnFNvMI3LfJx3zEWET/c=;
        b=KOIOJzXi2fSTKQghBJfAclApEuXEO+z4J4tHUBPVGzBh6ud+pdt3NdQlc+Zpayvf6Q
         9KD2EX483x7jkwmd3Lk9S1FaRoA1vj88cQTzB+fe92DlCzTC6afcQ5B2ovauXhCZoeG9
         orYUuZQmx+pl+IYJifRB92W6mwFjLQ48reM2t8tmOswxkjhdDpdY5MRWRRUzmqI4LrGQ
         jv5T5QdO4b3l4DuM+NdQ8DFfOu2h01+QYjUyH7z1E6O7anaQTKxMGc3skXj1REcLvyXc
         /5tTXzeKal7fgKauTvz8uwSndgZkIqgsg1YgTr8T7MCs85r32Hvkic+OoD5S2zLmnqtO
         3CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8lP7ydRMGUwV1Ross2Ed1IrnFNvMI3LfJx3zEWET/c=;
        b=dPTdyLVHjdiAWLIN+OSPSV55+MAna1SKeijDXLvyufHfn5rIj0+4ZUZVt+v1nZw6rE
         Q9tMvGInTPzut8puRqRt2GXIjDF4P9O1z814yj1GUUd4GHqyhiSoubup/JVBvnq20483
         /3opJMmqYPJ1TaPT6EjGgX/14bRl4omLNPuWlFqM51+HT3GOnqE+Wkag0pIhgbD7OZVx
         ZIKeQotq5ZBXky2zuI5U9rBEC9oXDkYviJAveIBkd/+wCKhqrVO/WWOdWZFR2QzEhHQK
         iWw7Fk4XqKWTRNV6wksn2Ns/BjnKJ5foK009HgvuSD/TvF/iSXvr4Obzy+/o4ot5ht54
         j7hw==
X-Gm-Message-State: AFqh2kpqzmObAi0OfEBxER4dsMxuubrvv7C9YzZLzsywJWmnwrMv5Kz+
        7q+mCJFMiqYDcvNMkjziVoc=
X-Google-Smtp-Source: AMrXdXsQwwb9S5E5bOXG/JdCW2hO/vy4aFkWCxwXA72qIMlXj+gIw6VIan8y6zp1ob1yKtgoMpabig==
X-Received: by 2002:a17:906:280d:b0:837:c290:eb83 with SMTP id r13-20020a170906280d00b00837c290eb83mr6179075ejc.2.1672331148659;
        Thu, 29 Dec 2022 08:25:48 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id d20-20020a170906305400b0084c9036a526sm867719ejd.20.2022.12.29.08.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:25:48 -0800 (PST)
Date:   Thu, 29 Dec 2022 17:25:46 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] staging: rtl8192e: Rename TSSI_13dBm, Pwr_Track and
 NumTotalRFPath
Message-ID: <c7d3be41602e656170de46ea649b5bdf1081d5cf.1672330343.git.philipp.g.hortmann@gmail.com>
References: <cover.1672330343.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1672330343.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable TSSI_13dBm to tssi_13dbm, Pwr_Track to pwr_track and
NumTotalRFPath to num_total_rf_path to avoid CamelCase which is not
accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
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
index 25fa7714df4e..c94c67643efb 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -371,7 +371,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 						   0xff00) >> 8;
 		else
 			priv->EEPROMThermalMeter = EEPROM_Default_ThermalMeter;
-		priv->TSSI_13dBm = priv->EEPROMThermalMeter * 100;
+		priv->tssi_13dbm = priv->EEPROMThermalMeter * 100;
 
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
index 93b3b75a063f..0e02add8b6be 100644
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
+	u16 tssi_13dbm;
+	u32 pwr_track;
 	u8 CCKPresentAttentuation_20Mdefault;
 	u8 CCKPresentAttentuation_40Mdefault;
 	s8 CCKPresentAttentuation_difference;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index a18393c8a833..c27d9fb7a7e6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -615,14 +615,14 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 	u8	RF_Type, tmp_report[5] = {0, 0, 0, 0, 0};
 	u32	Value;
 	u8	Pwr_Flag;
-	u16	Avg_TSSI_Meas, TSSI_13dBm, Avg_TSSI_Meas_from_driver = 0;
+	u16	Avg_TSSI_Meas, tssi_13dbm, Avg_TSSI_Meas_from_driver = 0;
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
+			tssi_13dbm = priv->tssi_13dbm;
 
-			if (Avg_TSSI_Meas_from_driver > TSSI_13dBm)
-				delta = Avg_TSSI_Meas_from_driver - TSSI_13dBm;
+			if (Avg_TSSI_Meas_from_driver > tssi_13dbm)
+				delta = Avg_TSSI_Meas_from_driver - tssi_13dbm;
 			else
-				delta = TSSI_13dBm - Avg_TSSI_Meas_from_driver;
+				delta = tssi_13dbm - Avg_TSSI_Meas_from_driver;
 
 			if (delta <= E_FOR_TX_POWER_TRACK) {
 				priv->rtllib->bdynamic_txpower_enable = true;
@@ -701,7 +701,7 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 				rtl92e_writeb(dev, FW_Busy_Flag, 0);
 				return;
 			}
-			if (Avg_TSSI_Meas_from_driver < TSSI_13dBm - E_FOR_TX_POWER_TRACK)
+			if (Avg_TSSI_Meas_from_driver < tssi_13dbm - E_FOR_TX_POWER_TRACK)
 				_rtl92e_dm_tx_update_tssi_weak_signal(dev,
 								      RF_Type);
 			else
-- 
2.39.0

