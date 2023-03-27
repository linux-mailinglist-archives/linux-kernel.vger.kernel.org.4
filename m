Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F316CAF24
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjC0Ttg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjC0Ttb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:49:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D37630D8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:49:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l8-20020a05600c1d0800b003ef6708bbf6so4003976wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679946557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBqoyIg2s4G+6qTIVouHyZXfEx2G2/CvGDdlltVjXl8=;
        b=eUYUdmhuTWZxvqlHRicLeShNEJW4CCxGugtbglhQnY2fzSpMRMMRWJQfj8tqGfdLXg
         X5/FlLmD8o/q+0LlI+uhFXm2X3jX7+u1ulnlgblgEtt1pF5OZ0Gzs4vez5YJziN2hJWM
         rPjJDJYkJxTEBgfSKgBQCtwAHgTnJYlP4pU+15ASgeRw6pbsvI1kJKHyLXh+I3gJ4wwv
         zEBvjTN2MEQfZzWsw0ZCTrfOpgMV6zA0ziAQG0RLEngc8ogfeuXoy5pGhMOE8i5Di7Bj
         KwSRMObiqNuDZKRH5vyhQB9yrbbiH87ga4CAzYvOoxJuwc6O0ILiIO4kdEdhJKnmU7g4
         z/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679946557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBqoyIg2s4G+6qTIVouHyZXfEx2G2/CvGDdlltVjXl8=;
        b=qGroP9pnR4rVISaDZJW72qh8JoRUzx3+9EVTr6zOlU7GNkFtHo7IxopcXzFIa09Aq3
         w3MDF+1JVdimg40pFxJKAngqeP82NUkX1r7/bdpZGTkaULCShL7d91K9ANmZtc3qDYZA
         XQF/apItppq1eEo9MnmJQFrXeguYVK2uiUx6oWyns0qpQd4yCewrrvRzT32x4XX/radD
         wqbQi86lvlyBWubKmF67w8EYcNbcyz0BFcHnliVcoFEVFTLooz0qEUhjgSppV3A6CQBH
         uNs5cQIi05h/+jqBNRz3vDIvspXE+8hNLdzOvFqZlOyaxa+BZ8oTcK4wCU6S9iYfK3o5
         ADEA==
X-Gm-Message-State: AO0yUKWxuT4zPpX7SnnFRVtvG7FT7ZAq/1AmK07acmGpD6xrFOz73I4R
        MzACw7CswqXLcjDzKcw5MXBhPOkfC/XTCc7Q
X-Google-Smtp-Source: AK7set+ZWzKk/4sY8suyU/gB2jdUS/eovrbW+ikGAwehhfKylhZfEyAhZ//GivWQE8WmIALmBV2yPw==
X-Received: by 2002:a7b:c853:0:b0:3ed:ca62:418e with SMTP id c19-20020a7bc853000000b003edca62418emr10044475wml.9.1679946556445;
        Mon, 27 Mar 2023 12:49:16 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id c13-20020a05600c0acd00b003ee42696acesm14661366wmr.16.2023.03.27.12.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:49:16 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] staging: rtl8192u: remove commented out code
Date:   Tue, 28 Mar 2023 00:49:07 +0500
Message-Id: <e5e2fabde70d497cc8b683ff444854299180812b.1679945728.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679945728.git.kamrankhadijadj@gmail.com>
References: <cover.1679945728.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all of the commented out code lines as they are not being used
and can be brought back in the future if they are ever needed again.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 123 ---------------------------
 1 file changed, 123 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index b1ebb776fc42..e5c0bece4bb4 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -48,12 +48,8 @@ static	void	dm_init_bandwidth_autoswitch(struct net_device *dev);
 static	void	dm_bandwidth_autoswitch(struct net_device *dev);
 
 /* DM --> TX power control */
-/*static	void	dm_initialize_txpower_tracking(struct net_device *dev);*/
-
 static	void	dm_check_txpower_tracking(struct net_device *dev);
 
-/*static	void	dm_txpower_reset_recovery(struct net_device *dev);*/
-
 /* DM --> Dynamic Init Gain by RSSI */
 static	void	dm_dig_init(struct net_device *dev);
 static	void	dm_ctrl_initgain_byrssi(struct net_device *dev);
@@ -68,7 +64,6 @@ static	void dm_init_ctstoself(struct net_device *dev);
 /* DM --> EDCA turbo mode control */
 static	void	dm_check_edca_turbo(struct net_device *dev);
 
-/*static	void	dm_gpio_change_rf(struct net_device *dev);*/
 /* DM --> Check PBC */
 static	void dm_check_pbc_gpio(struct net_device *dev);
 
@@ -115,7 +110,6 @@ void init_hal_dm(struct net_device *dev)
 	/* Initial TX Power Control for near/far range , add by amy 2008/05/15, porting from windows code. */
 	dm_init_dynamic_txpower(dev);
 	init_rate_adaptive(dev);
-	/*dm_initialize_txpower_tracking(dev);*/
 	dm_dig_init(dev);
 	dm_init_edca_turbo(dev);
 	dm_init_bandwidth_autoswitch(dev);
@@ -140,21 +134,6 @@ void dm_CheckRxAggregation(struct net_device *dev)
 	unsigned long		curTxOkCnt = 0;
 	unsigned long		curRxOkCnt = 0;
 
-/*
-	if (pHalData->bForcedUsbRxAggr) {
-		if (pHalData->ForcedUsbRxAggrInfo == 0) {
-			if (pHalData->bCurrentRxAggrEnable) {
-				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, FALSE);
-			}
-		} else {
-			if (!pHalData->bCurrentRxAggrEnable || (pHalData->ForcedUsbRxAggrInfo != pHalData->LastUsbRxAggrInfoSetting)) {
-				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, TRUE);
-			}
-		}
-		return;
-	}
-
-*/
 	curTxOkCnt = priv->stats.txbytesunicast - lastTxOkCnt;
 	curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
 
@@ -188,10 +167,6 @@ void dm_CheckRxAggregation(struct net_device *dev)
 
 void hal_dm_watchdog(struct net_device *dev)
 {
-	/*struct r8192_priv *priv = ieee80211_priv(dev);*/
-
-	/*static u8	previous_bssid[6] ={0};*/
-
 	/*Add by amy 2008/05/15 ,porting from windows code.*/
 	dm_check_rate_adaptive(dev);
 	dm_dynamic_txpower(dev);
@@ -293,7 +268,6 @@ static void dm_check_rate_adaptive(struct net_device *dev)
 		return;
 
 	if (priv->ieee80211->state == IEEE80211_LINKED) {
-		/*RT_TRACE(COMP_RATE, "dm_CheckRateAdaptive(): \t");*/
 
 		/* Check whether Short GI is enabled */
 		bshort_gi_enabled = (pHTInfo->bCurTxBW40MHz && pHTInfo->bCurShortGI40MHz) ||
@@ -340,36 +314,27 @@ static void dm_check_rate_adaptive(struct net_device *dev)
 					(pra->low_rssi_thresh_for_ra40M):(pra->low_rssi_thresh_for_ra20M);
 		}
 
-		/*DbgPrint("[DM] THresh H/L=%d/%d\n\r", RATR.HighRSSIThreshForRA, RATR.LowRSSIThreshForRA);*/
 		if (priv->undecorated_smoothed_pwdb >= (long)HighRSSIThreshForRA) {
-			/*DbgPrint("[DM] RSSI=%d STA=HIGH\n\r", pHalData->UndecoratedSmoothedPWDB);*/
 			pra->ratr_state = DM_RATR_STA_HIGH;
 			targetRATR = pra->upper_rssi_threshold_ratr;
 		} else if (priv->undecorated_smoothed_pwdb >= (long)LowRSSIThreshForRA) {
-			/*DbgPrint("[DM] RSSI=%d STA=Middle\n\r", pHalData->UndecoratedSmoothedPWDB);*/
 			pra->ratr_state = DM_RATR_STA_MIDDLE;
 			targetRATR = pra->middle_rssi_threshold_ratr;
 		} else {
-			/*DbgPrint("[DM] RSSI=%d STA=LOW\n\r", pHalData->UndecoratedSmoothedPWDB);*/
 			pra->ratr_state = DM_RATR_STA_LOW;
 			targetRATR = pra->low_rssi_threshold_ratr;
 		}
 
 		/* cosa add for test */
 		if (pra->ping_rssi_enable) {
-			/*pHalData->UndecoratedSmoothedPWDB = 19;*/
 			if (priv->undecorated_smoothed_pwdb < (long)(pra->ping_rssi_thresh_for_ra+5)) {
 				if ((priv->undecorated_smoothed_pwdb < (long)pra->ping_rssi_thresh_for_ra) ||
 					ping_rssi_state) {
-					/*DbgPrint("TestRSSI = %d, set RATR to 0x%x\n", pHalData->UndecoratedSmoothedPWDB, pRA->TestRSSIRATR);*/
 					pra->ratr_state = DM_RATR_STA_LOW;
 					targetRATR = pra->ping_rssi_ratr;
 					ping_rssi_state = 1;
 				}
-				/*else
-					DbgPrint("TestRSSI is between the range.\n");*/
 			} else {
-				/*DbgPrint("TestRSSI Recover to 0x%x\n", targetRATR);*/
 				ping_rssi_state = 0;
 			}
 		}
@@ -491,7 +456,6 @@ static void dm_TXPowerTrackingCallback_TSSI(struct net_device *dev)
 	u32						Value;
 	u8						Pwr_Flag;
 	u16						Avg_TSSI_Meas, TSSI_13dBm, Avg_TSSI_Meas_from_driver = 0;
-	/*RT_STATUS				rtStatus = RT_STATUS_SUCCESS;*/
 	bool rtStatus = true;
 	u32						delta = 0;
 
@@ -513,7 +477,6 @@ static void dm_TXPowerTrackingCallback_TSSI(struct net_device *dev)
 		if (rtStatus == RT_STATUS_FAILURE)
 			RT_TRACE(COMP_POWER_TRACKING, "Set configuration with tx cmd queue fail!\n");
 		usleep_range(1000, 2000);
-		/*DbgPrint("hi, vivi, strange\n");*/
 		for (i = 0; i <= 30; i++) {
 			read_nic_byte(dev, 0x1ba, &Pwr_Flag);
 
@@ -559,8 +522,6 @@ static void dm_TXPowerTrackingCallback_TSSI(struct net_device *dev)
 			TSSI_13dBm = priv->TSSI_13dBm;
 			RT_TRACE(COMP_POWER_TRACKING, "TSSI_13dBm = %d\n", TSSI_13dBm);
 
-			/*if (abs(Avg_TSSI_Meas_from_driver - TSSI_13dBm) <= E_FOR_TX_POWER_TRACK)*/
-			/* For MacOS-compatible */
 			if (Avg_TSSI_Meas_from_driver > TSSI_13dBm)
 				delta = Avg_TSSI_Meas_from_driver - TSSI_13dBm;
 			else
@@ -664,7 +625,6 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 			}
 		}
 		priv->btxpower_trackingInit = true;
-		/*pHalData->TXPowercount = 0;*/
 		return;
 	}
 
@@ -708,9 +668,6 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 		}
 		tmpCCK40Mindex = 0;
 	}
-	/*DbgPrint("%ddb, tmpOFDMindex = %d, tmpCCK20Mindex = %d, tmpCCK40Mindex = %d",
-		((u1Byte)tmpRegA - pHalData->ThermalMeter[0]),
-		tmpOFDMindex, tmpCCK20Mindex, tmpCCK40Mindex);*/
 	if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20)	/* 40M */
 		tmpCCKindex = tmpCCK40Mindex;
 	else
@@ -730,7 +687,6 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 	}
 
 	if (CCKSwingNeedUpdate) {
-		/*DbgPrint("Update CCK Swing, CCK_index = %d\n", pHalData->CCK_index);*/
 		dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
 	}
 	if (priv->OFDM_index != tmpOFDMindex) {
@@ -1301,7 +1257,6 @@ static void dm_CheckTXPowerTracking_ThermalMeter(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	static u8	TM_Trigger;
-	/*DbgPrint("dm_CheckTXPowerTracking()\n");*/
 	if (!priv->btxpower_tracking)
 		return;
 	if (priv->txpower_count  <= 2) {
@@ -1321,7 +1276,6 @@ static void dm_CheckTXPowerTracking_ThermalMeter(struct net_device *dev)
 		TM_Trigger = 1;
 		return;
 	}
-	/*DbgPrint("Schedule TxPowerTrackingWorkItem\n");*/
 	queue_delayed_work(priv->priv_wq, &priv->txpower_tracking_wq, 0);
 	TM_Trigger = 0;
 }
@@ -1329,7 +1283,6 @@ static void dm_CheckTXPowerTracking_ThermalMeter(struct net_device *dev)
 static void dm_check_txpower_tracking(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
-	/*static u32 tx_power_track_counter = 0;*/
 
 #ifdef RTL8190P
 	dm_CheckTXPowerTracking_TSSI(dev);
@@ -1414,7 +1367,6 @@ static void dm_CCKTxPowerAdjust_ThermalMeter(struct net_device *dev, bool  bInCH
 		RT_TRACE(COMP_POWER_TRACKING, "CCK not chnl 14, reg 0x%x = 0x%x\n",
 			rCCK0_DebugPort, TempVal);
 	} else {
-		/*priv->CCKTxPowerAdjustCntNotCh14++;	cosa add for debug.*/
 		/* Write 0xa22 0xa23 */
 		TempVal =	CCKSwingTable_Ch14[priv->CCK_index][0] +
 					(CCKSwingTable_Ch14[priv->CCK_index][1]<<8);
@@ -1497,10 +1449,7 @@ void dm_restore_dynamic_mechanism_state(struct net_device *dev)
 			ratr_value = reg_ratr;
 			if (priv->rf_type == RF_1T2R) {	/* 1T2R, Spatial Stream 2 should be disabled */
 				ratr_value &= ~(RATE_ALL_OFDM_2SS);
-				/*DbgPrint("HW_VAR_TATR_0 from 0x%x ==> 0x%x\n", ((pu4Byte)(val))[0], ratr_value);*/
 			}
-			/*DbgPrint("set HW_VAR_TATR_0 = 0x%x\n", ratr_value);*/
-			/*cosa PlatformEFIOWrite4Byte(Adapter, RATR0, ((pu4Byte)(val))[0]);*/
 			write_nic_dword(dev, RATR0, ratr_value);
 			write_nic_byte(dev, UFWP, 1);
 	}
@@ -1522,7 +1471,6 @@ static void dm_bb_initialgain_restore(struct net_device *dev)
 		return;
 
 	/* Disable Initial Gain */
-	/*PHY_SetBBReg(Adapter, UFWP, bMaskLWord, 0x800);*/
 	rtl8192_setBBreg(dev, UFWP, bMaskByte1, 0x8);	/* Only clear byte 1 and rewrite. */
 	rtl8192_setBBreg(dev, rOFDM0_XAAGCCore1, bit_mask, (u32)priv->initgain_backup.xaagccore1);
 	rtl8192_setBBreg(dev, rOFDM0_XBAGCCore1, bit_mask, (u32)priv->initgain_backup.xbagccore1);
@@ -1537,7 +1485,6 @@ static void dm_bb_initialgain_restore(struct net_device *dev)
 	RT_TRACE(COMP_DIG, "dm_BBInitialGainRestore 0xc68 is %x\n", priv->initgain_backup.xdagccore1);
 	RT_TRACE(COMP_DIG, "dm_BBInitialGainRestore 0xa0a is %x\n", priv->initgain_backup.cca);
 	/* Enable Initial Gain */
-	/*PHY_SetBBReg(Adapter, UFWP, bMaskLWord, 0x100);*/
 	rtl8192_setBBreg(dev, UFWP, bMaskByte1, 0x1);	/* Only clear byte 1 and rewrite. */
 
 }	/* dm_BBInitialGainRestore */
@@ -1550,7 +1497,6 @@ static void dm_bb_initialgain_backup(struct net_device *dev)
 	if (dm_digtable.dig_algorithm == DIG_ALGO_BY_RSSI)
 		return;
 
-	/*PHY_SetBBReg(Adapter, UFWP, bMaskLWord, 0x800);*/
 	rtl8192_setBBreg(dev, UFWP, bMaskByte1, 0x8);	/* Only clear byte 1 and rewrite. */
 	priv->initgain_backup.xaagccore1 = (u8)rtl8192_QueryBBReg(dev, rOFDM0_XAAGCCore1, bit_mask);
 	priv->initgain_backup.xbagccore1 = (u8)rtl8192_QueryBBReg(dev, rOFDM0_XBAGCCore1, bit_mask);
@@ -1643,7 +1589,6 @@ static void dm_ctrl_initgain_byrssi_by_driverrssi(
 	if (!dm_digtable.dig_enable_flag)
 		return;
 
-	/*DbgPrint("Dig by Sw Rssi\n");*/
 	if (dm_digtable.dig_algorithm_switch)	/* if switched algorithm, we have to disable FW Dig. */
 		fw_dig = 0;
 
@@ -1660,11 +1605,7 @@ static void dm_ctrl_initgain_byrssi_by_driverrssi(
 	else
 		dm_digtable.cur_connect_state = DIG_DISCONNECT;
 
-	/*DbgPrint("DM_DigTable.PreConnectState = %d, DM_DigTable.CurConnectState = %d\n",
-		DM_DigTable.PreConnectState, DM_DigTable.CurConnectState);*/
-
 	dm_digtable.rssi_val = priv->undecorated_smoothed_pwdb;
-	/*DbgPrint("DM_DigTable.Rssi_val = %d\n", DM_DigTable.Rssi_val);*/
 	dm_initial_gain(dev);
 	dm_pd_th(dev);
 	dm_cs_ratio(dev);
@@ -1700,11 +1641,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 	    (priv->undecorated_smoothed_pwdb < dm_digtable.rssi_high_thresh))
 		return;
 
-	/*DbgPrint("Dig by Fw False Alarm\n");*/
-	/*if (DM_DigTable.Dig_State == DM_STA_DIG_OFF)*/
-	/*DbgPrint("DIG Check\n\r RSSI=%d LOW=%d HIGH=%d STATE=%d",
-	pHalData->UndecoratedSmoothedPWDB, DM_DigTable.RssiLowThresh,
-	DM_DigTable.RssiHighThresh, DM_DigTable.Dig_State);*/
 	/* 1. When RSSI decrease, We have to judge if it is smaller than a threshold
 	 * and then execute the step below.
 	 */
@@ -1737,12 +1673,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 			 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 			 */
 			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x00);
-			/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-				write_nic_byte(pAdapter, rOFDM0_RxDetector1, 0x40);
-			else if (pAdapter->HardwareType == HARDWARE_TYPE_RTL8192E)
-			else
-				PlatformEFIOWrite1Byte(pAdapter, rOFDM0_RxDetector1, 0x40);
-			*/
 		} else
 			write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
 
@@ -1750,7 +1680,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 		write_nic_byte(dev, 0xa0a, 0x08);
 
 		/* 1.5 Higher EDCCA. */
-		/*PlatformEFIOWrite4Byte(pAdapter, rOFDM0_ECCAThreshold, 0x325);*/
 		return;
 	}
 
@@ -1771,7 +1700,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 		reset_cnt = priv->reset_count;
 
 		dm_digtable.dig_state = DM_STA_DIG_ON;
-		/*DbgPrint("DIG ON\n\r");*/
 
 		/* 2.1 Set initial gain.
 		 * 2008/02/26 MH SD3-Jerry suggest to prevent dirty environment.
@@ -1794,13 +1722,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 			 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 			 */
 			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
-			/*
-			else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-				write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
-			else if (pAdapter->HardwareType == HARDWARE_TYPE_RTL8192E)
-			else
-				PlatformEFIOWrite1Byte(pAdapter, rOFDM0_RxDetector1, 0x42);
-			*/
 		} else
 			write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
 
@@ -1810,7 +1731,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 		/* 2.4 Lower EDCCA.
 		 * 2008/01/11 MH 90/92 series are the same.
 		 */
-		/*PlatformEFIOWrite4Byte(pAdapter, rOFDM0_ECCAThreshold, 0x346);*/
 
 		/* 2.5 DIG On. */
 		rtl8192_setBBreg(dev, UFWP, bMaskByte1, 0x1);	/*  Only clear byte 1 and rewrite. */
@@ -1856,11 +1776,6 @@ static void dm_ctrl_initgain_byrssi_highpwr(
 		/* 3.1 Higher PD_TH for OFDM for high power state. */
 		if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
 			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x10);
-
-			/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-				write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
-			*/
-
 		} else
 			write_nic_byte(dev, rOFDM0_RxDetector1, 0x43);
 	} else {
@@ -1874,10 +1789,6 @@ static void dm_ctrl_initgain_byrssi_highpwr(
 			/*  3.2 Recover PD_TH for OFDM for normal power region. */
 			if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
 				write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
-				/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-					write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
-				*/
-
 			} else
 				write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
 		}
@@ -1919,7 +1830,6 @@ static void dm_initial_gain(
 		dm_digtable.cur_ig_value = priv->DefaultInitialGain[0];
 		dm_digtable.pre_ig_value = 0;
 	}
-	/*DbgPrint("DM_DigTable.CurIGValue = 0x%x, DM_DigTable.PreIGValue = 0x%x\n", DM_DigTable.CurIGValue, DM_DigTable.PreIGValue);*/
 
 	/* if silent reset happened, we should rewrite the values back */
 	if (priv->reset_count != reset_cnt) {
@@ -1935,7 +1845,6 @@ static void dm_initial_gain(
 		if ((dm_digtable.pre_ig_value != dm_digtable.cur_ig_value)
 			|| !initialized || force_write) {
 			initial_gain = (u8)dm_digtable.cur_ig_value;
-			/*DbgPrint("Write initial gain = 0x%x\n", initial_gain);*/
 			/*  Set initial gain. */
 			write_nic_byte(dev, rOFDM0_XAAGCCore1, initial_gain);
 			write_nic_byte(dev, rOFDM0_XBAGCCore1, initial_gain);
@@ -1987,7 +1896,6 @@ static void dm_pd_th(
 	{
 		if ((dm_digtable.prepd_thstate != dm_digtable.curpd_thstate) ||
 		    (initialized <= 3) || force_write) {
-			/*DbgPrint("Write PD_TH state = %d\n", DM_DigTable.CurPD_THState);*/
 			if (dm_digtable.curpd_thstate == DIG_PD_AT_LOW_POWER) {
 				/*  Lower PD_TH for OFDM. */
 				if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
@@ -1995,9 +1903,6 @@ static void dm_pd_th(
 					 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 					 */
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x00);
-					/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-						write_nic_byte(dev, rOFDM0_RxDetector1, 0x40);
-					*/
 				} else
 					write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
 			} else if (dm_digtable.curpd_thstate == DIG_PD_AT_NORMAL_POWER) {
@@ -2007,18 +1912,12 @@ static void dm_pd_th(
 					 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 					 */
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
-					/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-						write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
-					*/
 				} else
 					write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
 			} else if (dm_digtable.curpd_thstate == DIG_PD_AT_HIGH_POWER) {
 				/* Higher PD_TH for OFDM for high power state. */
 				if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x10);
-					/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-						write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
-					*/
 				} else
 					write_nic_byte(dev, rOFDM0_RxDetector1, 0x43);
 			}
@@ -2065,7 +1964,6 @@ static	void dm_cs_ratio(
 	{
 		if ((dm_digtable.precs_ratio_state != dm_digtable.curcs_ratio_state) ||
 		    !initialized || force_write) {
-			/*DbgPrint("Write CS_ratio state = %d\n", DM_DigTable.CurCS_ratioState);*/
 			if (dm_digtable.curcs_ratio_state == DIG_CS_RATIO_LOWER) {
 				/*  Lower CS ratio for CCK. */
 				write_nic_byte(dev, 0xa0a, 0x08);
@@ -2094,7 +1992,6 @@ static void dm_check_edca_turbo(
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	PRT_HIGH_THROUGHPUT	pHTInfo = priv->ieee80211->pHTInfo;
-	/*PSTA_QOS			pStaQos = pMgntInfo->pStaQos;*/
 
 	/* Keep past Tx/Rx packet count for RT-to-RT EDCA turbo. */
 	static unsigned long			lastTxOkCnt;
@@ -2111,20 +2008,16 @@ static void dm_check_edca_turbo(
 	if (priv->ieee80211->pHTInfo->IOTAction & HT_IOT_ACT_DISABLE_EDCA_TURBO)
 		goto dm_CheckEdcaTurbo_EXIT;
 
-	/*printk("========>%s():bis_any_nonbepkts is %d\n", __func__, priv->bis_any_nonbepkts);*/
-	/* Check the status for current condition. */
 	if (!priv->ieee80211->bis_any_nonbepkts) {
 		curTxOkCnt = priv->stats.txbytesunicast - lastTxOkCnt;
 		curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
 		/* For RT-AP, we needs to turn it on when Rx>Tx */
 		if (curRxOkCnt > 4*curTxOkCnt) {
-			/*printk("%s():curRxOkCnt > 4*curTxOkCnt\n");*/
 			if (!priv->bis_cur_rdlstate || !priv->bcurrent_turbo_EDCA) {
 				write_nic_dword(dev, EDCAPARA_BE, edca_setting_DL[pHTInfo->IOTPeer]);
 				priv->bis_cur_rdlstate = true;
 			}
 		} else {
-			/*printk("%s():curRxOkCnt < 4*curTxOkCnt\n");*/
 			if (priv->bis_cur_rdlstate || !priv->bcurrent_turbo_EDCA) {
 				write_nic_dword(dev, EDCAPARA_BE, edca_setting_UL[pHTInfo->IOTPeer]);
 				priv->bis_cur_rdlstate = false;
@@ -2224,7 +2117,6 @@ static void dm_ctstoself(struct net_device *dev)
 		curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
 		if (curRxOkCnt > 4*curTxOkCnt) { /* downlink, disable CTS to self */
 			pHTInfo->IOTAction &= ~HT_IOT_ACT_FORCED_CTS2SELF;
-			/*DbgPrint("dm_CTSToSelf() ==> CTS to self disabled -- downlink\n");*/
 		} else { /* uplink */
 			pHTInfo->IOTAction |= HT_IOT_ACT_FORCED_CTS2SELF;
 		}
@@ -2279,7 +2171,6 @@ void dm_rf_pathcheck_workitemcallback(struct work_struct *work)
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct r8192_priv *priv = container_of(dwork, struct r8192_priv, rfpath_check_wq);
 	struct net_device *dev = priv->ieee80211->dev;
-	/*bool bactually_set = false;*/
 	u8 rfpath = 0, i;
 
 	/* 2008/01/30 MH After discussing with SD3 Jerry, 0xc04/0xd04 register will
@@ -2343,7 +2234,6 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 
 	if (priv->ieee80211->mode == WIRELESS_MODE_B) {
 		DM_RxPathSelTable.cck_method = CCK_RX_VERSION_2;	/* pure B mode, fixed cck version2 */
-		/*DbgPrint("Pure B mode, use cck rx version2\n");*/
 	}
 
 	/* decide max/sec/min rssi index */
@@ -2496,7 +2386,6 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 			if ((DM_RxPathSelTable.disabled_rf >> i) & 0x1) {	/* disabled rf */
 				if (tmp_max_rssi >= DM_RxPathSelTable.rf_enable_rssi_th[i]) {
 					/* enable the BB Rx path */
-					/*DbgPrint("RF-%d is enabled.\n", 0x1<<i);*/
 					rtl8192_setBBreg(dev, rOFDM0_TRxPathEnable, 0x1<<i, 0x1);	/* 0xc04[3:0] */
 					rtl8192_setBBreg(dev, rOFDM1_TRxPathEnable, 0x1<<i, 0x1);	/* 0xd04[3:0] */
 					DM_RxPathSelTable.rf_enable_rssi_th[i] = 100;
@@ -2716,7 +2605,6 @@ void dm_check_fsync(struct net_device *dev)
 #define	RegC38_NonFsync_Other_AP		1
 #define	RegC38_Fsync_AP_BCM			2
 	struct r8192_priv *priv = ieee80211_priv(dev);
-	/*u32			framesyncC34;*/
 	static u8		reg_c38_State = RegC38_Default;
 	static u32	reset_cnt;
 
@@ -2791,14 +2679,12 @@ void dm_check_fsync(struct net_device *dev)
 					if (reg_c38_State) {
 						write_nic_byte(dev, rOFDM0_RxDetector3, priv->framesync);
 						reg_c38_State = RegC38_Default;
-						/*DbgPrint("Fsync is idle, rssi>=40, write 0xc38 = 0x%x\n", pHalData->framesync);*/
 					}
 				}
 			} else {
 				if (reg_c38_State) {
 					write_nic_byte(dev, rOFDM0_RxDetector3, priv->framesync);
 					reg_c38_State = RegC38_Default;
-					/*DbgPrint("Fsync is idle, not connected, write 0xc38 = 0x%x\n", pHalData->framesync);*/
 				}
 			}
 		}
@@ -2808,13 +2694,11 @@ void dm_check_fsync(struct net_device *dev)
 			write_nic_byte(dev, rOFDM0_RxDetector3, priv->framesync);
 			reg_c38_State = RegC38_Default;
 			reset_cnt = priv->reset_count;
-			/*DbgPrint("reg_c38_State = 0 for silent reset.\n");*/
 		}
 	} else {
 		if (reg_c38_State) {
 			write_nic_byte(dev, rOFDM0_RxDetector3, priv->framesync);
 			reg_c38_State = RegC38_Default;
-			/*DbgPrint("framesync no monitor, write 0xc38 = 0x%x\n", pHalData->framesync);*/
 		}
 	}
 }
@@ -2856,7 +2740,6 @@ static void dm_dynamic_txpower(struct net_device *dev)
 		priv->bDynamicTxLowPower = false;
 		return;
 	}
-	/*printk("priv->ieee80211->current_network.unknown_cap_exist is %d , priv->ieee80211->current_network.broadcom_cap_exist is %d\n", priv->ieee80211->current_network.unknown_cap_exist, priv->ieee80211->current_network.broadcom_cap_exist);*/
 	if ((priv->ieee80211->current_network.atheros_cap_exist) && (priv->ieee80211->mode == IEEE_G)) {
 		txhipower_threshold = TX_POWER_ATHEROAP_THRESH_HIGH;
 		txlowpower_threshold = TX_POWER_ATHEROAP_THRESH_LOW;
@@ -2865,7 +2748,6 @@ static void dm_dynamic_txpower(struct net_device *dev)
 		txlowpower_threshold = TX_POWER_NEAR_FIELD_THRESH_LOW;
 	}
 
-	/*printk("=======>%s(): txhipower_threshold is %d, txlowpower_threshold is %d\n", __func__, txhipower_threshold, txlowpower_threshold);*/
 	RT_TRACE(COMP_TXAGC, "priv->undecorated_smoothed_pwdb = %ld\n", priv->undecorated_smoothed_pwdb);
 
 	if (priv->ieee80211->state == IEEE80211_LINKED) {
@@ -2884,7 +2766,6 @@ static void dm_dynamic_txpower(struct net_device *dev)
 				priv->bDynamicTxLowPower = false;
 		}
 	} else {
-		/*pHalData->bTXPowerCtrlforNearFarRange = !pHalData->bTXPowerCtrlforNearFarRange;*/
 		priv->bDynamicTxHighPower = false;
 		priv->bDynamicTxLowPower = false;
 	}
@@ -2911,14 +2792,10 @@ static void dm_check_txrateandretrycount(struct net_device *dev)
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	struct ieee80211_device *ieee = priv->ieee80211;
 	/* for 11n tx rate */
-	/*priv->stats.CurrentShowTxate = read_nic_byte(dev, CURRENT_TX_RATE_REG);*/
 	read_nic_byte(dev, CURRENT_TX_RATE_REG, &ieee->softmac_stats.CurrentShowTxate);
-	/*printk("=============>tx_rate_reg:%x\n", ieee->softmac_stats.CurrentShowTxate);*/
 	/* for initial tx rate */
-	/*priv->stats.last_packet_rate = read_nic_byte(dev, INITIAL_TX_RATE_REG);*/
 	read_nic_byte(dev, INITIAL_TX_RATE_REG, &ieee->softmac_stats.last_packet_rate);
 	/* for tx retry count */
-	/*priv->stats.txretrycount = read_nic_dword(dev, TX_RETRY_COUNT_REG);*/
 	read_nic_dword(dev, TX_RETRY_COUNT_REG, &ieee->softmac_stats.txretrycount);
 }
 
-- 
2.34.1

