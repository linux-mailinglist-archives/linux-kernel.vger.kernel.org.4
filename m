Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095916C8DEA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjCYMNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjCYMNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:13:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0AB149BF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:13:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d17so4174510wrb.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679746407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5oy3VJZuBYm1Q7Kk4EuG/BMUp2ot7lsf61RT8hT8/Y=;
        b=JE0NVlH3vczW8zoSkwP3ZDFaL9GQm3snWR1z+4+7c50lH18qbAG1EkTAy5WbGLmUa7
         OS/cAl1AFIFIA+e3hxacjyVvCFo3bjCtVFFoo6E6PhdksZK3pq97uDwjrssmdcfhSjPJ
         gGMR2j0u6dD1MbJcfvy0fl2Eqo1I5C7GhJDeSmZwAZH8dY/oLlJCaoI5bL1/kUKAryh2
         57EOY8x4kihTya1W54bAJMvAz5tDAmDeUk5sreXGAXCERa8YOtN4b2CQ2vSzMLzM5sQD
         bxr7hvzwMFH9AA7/X8XAoP0XcBCAdnba0y7WWdxW30OiyhQKwYgptVcJjubPO905UMrY
         xMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679746407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5oy3VJZuBYm1Q7Kk4EuG/BMUp2ot7lsf61RT8hT8/Y=;
        b=5Jt4BhldsLlLX4g9KUuK9P0IfJxcS92cH0Hz5KDktSErRxMLy+HJDhh88a3wepN+tj
         RJhm6wlqCvKuL3iPwisXjV2OneXDSJ1PMpoXzqsF2VEO2C+kG42InMqAY8giVJSEAOxg
         +/KF68M++CP1mPiR4AgLJNJbHBotXCpJYZ4Dg4vZuFQ4nBiBuboEoiWxfPXOwKF3JwY3
         cntUmgcfkqBpOtSsK3DYLOxxa1x82+kgFruru72UGrr6zBQHaRJqfwGMcZj4fdpiEbp7
         QoHsc7MxjoDMZZK3ti3ulcEXE+JwQHHm93I5Vd9TtuJSvD5Byl6IikdBizys0YY5aF8r
         2SUQ==
X-Gm-Message-State: AAQBX9fIDEV8x5XU0FtE00l9YFxm0QYExDV1Tvn+Kd8gJNmJF68EQl7O
        njVxWBqXRI4un50WY7vMfTM=
X-Google-Smtp-Source: AKy350abZwQ9htaVD9xvi6eGsv8Ihh2WqUCQztgK3mcM1aezMGADp8jG6cN/3qzZQ62QWttOd4UWUw==
X-Received: by 2002:a5d:5411:0:b0:2c7:a9ec:3 with SMTP id g17-20020a5d5411000000b002c7a9ec0003mr4943221wrv.65.1679746406959;
        Sat, 25 Mar 2023 05:13:26 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b002c70c99db74sm20504791wrr.86.2023.03.25.05.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 05:13:26 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: rtl8192u: remove code from comments
Date:   Sat, 25 Mar 2023 17:13:18 +0500
Message-Id: <70aacb99144b4c776f8efa4c47a8423c58a9454f.1679744684.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679744684.git.kamrankhadijadj@gmail.com>
References: <cover.1679744684.git.kamrankhadijadj@gmail.com>
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

Writing code in comments is generally not considered a good coding
practice.
Remove all the code comments from the file.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 127 +--------------------------
 1 file changed, 2 insertions(+), 125 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 885c5966342f..f210ede8b1c7 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -50,11 +50,9 @@ static	void	dm_init_bandwidth_autoswitch(struct net_device *dev);
 static	void	dm_bandwidth_autoswitch(struct net_device *dev);
 
 /* DM --> TX power control */
-/*static	void	dm_initialize_txpower_tracking(struct net_device *dev);*/
 
 static	void	dm_check_txpower_tracking(struct net_device *dev);
 
-/*static	void	dm_txpower_reset_recovery(struct net_device *dev);*/
 
 /* DM --> Dynamic Init Gain by RSSI */
 static	void	dm_dig_init(struct net_device *dev);
@@ -70,7 +68,6 @@ static	void dm_init_ctstoself(struct net_device *dev);
 /* DM --> EDCA turbo mode control */
 static	void	dm_check_edca_turbo(struct net_device *dev);
 
-/*static	void	dm_gpio_change_rf(struct net_device *dev);*/
 /* DM --> Check PBC */
 static	void dm_check_pbc_gpio(struct net_device *dev);
 
@@ -117,7 +114,6 @@ void init_hal_dm(struct net_device *dev)
 	/* Initial TX Power Control for near/far range , add by amy 2008/05/15, porting from windows code. */
 	dm_init_dynamic_txpower(dev);
 	init_rate_adaptive(dev);
-	/*dm_initialize_txpower_tracking(dev);*/
 	dm_dig_init(dev);
 	dm_init_edca_turbo(dev);
 	dm_init_bandwidth_autoswitch(dev);
@@ -142,21 +138,6 @@ void dm_CheckRxAggregation(struct net_device *dev)
 	unsigned long		curTxOkCnt = 0;
 	unsigned long		curRxOkCnt = 0;
 
-/*
- *	if (pHalData->bForcedUsbRxAggr) {
- *		if (pHalData->ForcedUsbRxAggrInfo == 0) {
- *			if (pHalData->bCurrentRxAggrEnable) {
- *				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, FALSE);
- *			}
- *		} else {
- *			if (!pHalData->bCurrentRxAggrEnable || (pHalData->ForcedUsbRxAggrInfo != pHalData->LastUsbRxAggrInfoSetting)) {
- *				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, TRUE);
- *			}
- *		}
- *		return;
- *	}
- *
- */
 	curTxOkCnt = priv->stats.txbytesunicast - lastTxOkCnt;
 	curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
 
@@ -190,10 +171,6 @@ void dm_CheckRxAggregation(struct net_device *dev)
 
 void hal_dm_watchdog(struct net_device *dev)
 {
-	/*struct r8192_priv *priv = ieee80211_priv(dev);*/
-
-	/*static u8	previous_bssid[6] ={0};*/
-
 	/*Add by amy 2008/05/15 ,porting from windows code.*/
 	dm_check_rate_adaptive(dev);
 	dm_dynamic_txpower(dev);
@@ -297,7 +274,6 @@ static void dm_check_rate_adaptive(struct net_device *dev)
 		return;
 
 	if (priv->ieee80211->state == IEEE80211_LINKED) {
-		/*RT_TRACE(COMP_RATE, "dm_CheckRateAdaptive(): \t");*/
 
 		/* Check whether Short GI is enabled */
 		bshort_gi_enabled = (pHTInfo->bCurTxBW40MHz && pHTInfo->bCurShortGI40MHz) ||
@@ -344,37 +320,27 @@ static void dm_check_rate_adaptive(struct net_device *dev)
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
-				/* else
-				 *	DbgPrint("TestRSSI is between the range.\n");
-				 */
 			} else {
-				/*DbgPrint("TestRSSI Recover to 0x%x\n", targetRATR);*/
 				ping_rssi_state = 0;
 			}
 		}
@@ -496,7 +462,6 @@ static void dm_TXPowerTrackingCallback_TSSI(struct net_device *dev)
 	u32						Value;
 	u8						Pwr_Flag;
 	u16						Avg_TSSI_Meas, TSSI_13dBm, Avg_TSSI_Meas_from_driver = 0;
-	/*RT_STATUS				rtStatus = RT_STATUS_SUCCESS;*/
 	bool rtStatus = true;
 	u32						delta = 0;
 
@@ -518,7 +483,6 @@ static void dm_TXPowerTrackingCallback_TSSI(struct net_device *dev)
 		if (rtStatus == RT_STATUS_FAILURE)
 			RT_TRACE(COMP_POWER_TRACKING, "Set configuration with tx cmd queue fail!\n");
 		usleep_range(1000, 2000);
-		/*DbgPrint("hi, vivi, strange\n");*/
 		for (i = 0; i <= 30; i++) {
 			read_nic_byte(dev, 0x1ba, &Pwr_Flag);
 
@@ -564,7 +528,6 @@ static void dm_TXPowerTrackingCallback_TSSI(struct net_device *dev)
 			TSSI_13dBm = priv->TSSI_13dBm;
 			RT_TRACE(COMP_POWER_TRACKING, "TSSI_13dBm = %d\n", TSSI_13dBm);
 
-			/*if (abs(Avg_TSSI_Meas_from_driver - TSSI_13dBm) <= E_FOR_TX_POWER_TRACK)*/
 			/* For MacOS-compatible */
 			if (Avg_TSSI_Meas_from_driver > TSSI_13dBm)
 				delta = Avg_TSSI_Meas_from_driver - TSSI_13dBm;
@@ -669,7 +632,7 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 			}
 		}
 		priv->btxpower_trackingInit = true;
-		/*pHalData->TXPowercount = 0;*/
+
 		return;
 	}
 
@@ -713,10 +676,6 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 		}
 		tmpCCK40Mindex = 0;
 	}
-	/* DbgPrint("%ddb, tmpOFDMindex = %d, tmpCCK20Mindex = %d, tmpCCK40Mindex = %d",
-	 *	((u1Byte)tmpRegA - pHalData->ThermalMeter[0]),
-	 *	tmpOFDMindex, tmpCCK20Mindex, tmpCCK40Mindex);
-	 */
 	if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20)	/* 40M */
 		tmpCCKindex = tmpCCK40Mindex;
 	else
@@ -736,7 +695,6 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 	}
 
 	if (CCKSwingNeedUpdate) {
-		/*DbgPrint("Update CCK Swing, CCK_index = %d\n", pHalData->CCK_index);*/
 		dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
 	}
 	if (priv->OFDM_index != tmpOFDMindex) {
@@ -1307,7 +1265,6 @@ static void dm_CheckTXPowerTracking_ThermalMeter(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	static u8	TM_Trigger;
-	/*DbgPrint("dm_CheckTXPowerTracking()\n");*/
 	if (!priv->btxpower_tracking)
 		return;
 	if (priv->txpower_count  <= 2) {
@@ -1318,7 +1275,6 @@ static void dm_CheckTXPowerTracking_ThermalMeter(struct net_device *dev)
 	if (!TM_Trigger) {
 		/* Attention!! You have to write all 12bits of data to RF, or it may cause RF to crash
 		 * actually write reg0x02 bit1=0, then bit1=1.
-		 * DbgPrint("Trigger ThermalMeter, write RF reg0x2 = 0x4d to 0x4f\n");
 		 */
 		rtl8192_phy_SetRFReg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4d);
 		rtl8192_phy_SetRFReg(dev, RF90_PATH_A, 0x02, bMask12Bits, 0x4f);
@@ -1327,7 +1283,6 @@ static void dm_CheckTXPowerTracking_ThermalMeter(struct net_device *dev)
 		TM_Trigger = 1;
 		return;
 	}
-	/*DbgPrint("Schedule TxPowerTrackingWorkItem\n");*/
 	queue_delayed_work(priv->priv_wq, &priv->txpower_tracking_wq, 0);
 	TM_Trigger = 0;
 }
@@ -1335,7 +1290,6 @@ static void dm_CheckTXPowerTracking_ThermalMeter(struct net_device *dev)
 static void dm_check_txpower_tracking(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
-	/*static u32 tx_power_track_counter = 0;*/
 
 #ifdef RTL8190P
 	dm_CheckTXPowerTracking_TSSI(dev);
@@ -1420,7 +1374,6 @@ static void dm_CCKTxPowerAdjust_ThermalMeter(struct net_device *dev, bool  bInCH
 		RT_TRACE(COMP_POWER_TRACKING, "CCK not chnl 14, reg 0x%x = 0x%x\n",
 			rCCK0_DebugPort, TempVal);
 	} else {
-		/*priv->CCKTxPowerAdjustCntNotCh14++;	cosa add for debug.*/
 		/* Write 0xa22 0xa23 */
 		TempVal =	CCKSwingTable_Ch14[priv->CCK_index][0] +
 					(CCKSwingTable_Ch14[priv->CCK_index][1]<<8);
@@ -1503,10 +1456,7 @@ void dm_restore_dynamic_mechanism_state(struct net_device *dev)
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
@@ -1528,7 +1478,6 @@ static void dm_bb_initialgain_restore(struct net_device *dev)
 		return;
 
 	/* Disable Initial Gain */
-	/*PHY_SetBBReg(Adapter, UFWP, bMaskLWord, 0x800);*/
 	rtl8192_setBBreg(dev, UFWP, bMaskByte1, 0x8);	/* Only clear byte 1 and rewrite. */
 	rtl8192_setBBreg(dev, rOFDM0_XAAGCCore1, bit_mask, (u32)priv->initgain_backup.xaagccore1);
 	rtl8192_setBBreg(dev, rOFDM0_XBAGCCore1, bit_mask, (u32)priv->initgain_backup.xbagccore1);
@@ -1543,7 +1492,6 @@ static void dm_bb_initialgain_restore(struct net_device *dev)
 	RT_TRACE(COMP_DIG, "dm_BBInitialGainRestore 0xc68 is %x\n", priv->initgain_backup.xdagccore1);
 	RT_TRACE(COMP_DIG, "dm_BBInitialGainRestore 0xa0a is %x\n", priv->initgain_backup.cca);
 	/* Enable Initial Gain */
-	/*PHY_SetBBReg(Adapter, UFWP, bMaskLWord, 0x100);*/
 	rtl8192_setBBreg(dev, UFWP, bMaskByte1, 0x1);	/* Only clear byte 1 and rewrite. */
 
 }	/* dm_BBInitialGainRestore */
@@ -1556,7 +1504,6 @@ static void dm_bb_initialgain_backup(struct net_device *dev)
 	if (dm_digtable.dig_algorithm == DIG_ALGO_BY_RSSI)
 		return;
 
-	/*PHY_SetBBReg(Adapter, UFWP, bMaskLWord, 0x800);*/
 	rtl8192_setBBreg(dev, UFWP, bMaskByte1, 0x8);	/* Only clear byte 1 and rewrite. */
 	priv->initgain_backup.xaagccore1 = (u8)rtl8192_QueryBBReg(dev, rOFDM0_XAAGCCore1, bit_mask);
 	priv->initgain_backup.xbagccore1 = (u8)rtl8192_QueryBBReg(dev, rOFDM0_XBAGCCore1, bit_mask);
@@ -1638,7 +1585,6 @@ static void dm_ctrl_initgain_byrssi(struct net_device *dev)
 		dm_ctrl_initgain_byrssi_by_fwfalse_alarm(dev);
 	else if (dm_digtable.dig_algorithm == DIG_ALGO_BY_RSSI)
 		dm_ctrl_initgain_byrssi_by_driverrssi(dev);
-	/* ; */
 	else
 		return;
 }
@@ -1653,7 +1599,6 @@ static void dm_ctrl_initgain_byrssi_by_driverrssi(
 	if (!dm_digtable.dig_enable_flag)
 		return;
 
-	/*DbgPrint("Dig by Sw Rssi\n");*/
 	if (dm_digtable.dig_algorithm_switch)	/* if switched algorithm, we have to disable FW Dig. */
 		fw_dig = 0;
 
@@ -1670,12 +1615,7 @@ static void dm_ctrl_initgain_byrssi_by_driverrssi(
 	else
 		dm_digtable.cur_connect_state = DIG_DISCONNECT;
 
-	/* DbgPrint("DM_DigTable.PreConnectState = %d, DM_DigTable.CurConnectState = %d\n",
-	 *	DM_DigTable.PreConnectState, DM_DigTable.CurConnectState);
-	 */
-
 	dm_digtable.rssi_val = priv->undecorated_smoothed_pwdb;
-	/*DbgPrint("DM_DigTable.Rssi_val = %d\n", DM_DigTable.Rssi_val);*/
 	dm_initial_gain(dev);
 	dm_pd_th(dev);
 	dm_cs_ratio(dev);
@@ -1711,12 +1651,7 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 	    (priv->undecorated_smoothed_pwdb < dm_digtable.rssi_high_thresh))
 		return;
 
-	/* DbgPrint("Dig by Fw False Alarm\n");
-	 * if (DM_DigTable.Dig_State == DM_STA_DIG_OFF)
-	 * DbgPrint("DIG Check\n\r RSSI=%d LOW=%d HIGH=%d STATE=%d",
-	 * pHalData->UndecoratedSmoothedPWDB, DM_DigTable.RssiLowThresh,
-	 * DM_DigTable.RssiHighThresh, DM_DigTable.Dig_State);
-	 * 1. When RSSI decrease, We have to judge if it is smaller than a threshold
+	/* 1. When RSSI decrease, We have to judge if it is smaller than a threshold
 	 * and then execute the step below.
 	 */
 	if (priv->undecorated_smoothed_pwdb <= dm_digtable.rssi_low_thresh) {
@@ -1748,12 +1683,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 			 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 			 */
 			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x00);
-			/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-			 *	write_nic_byte(pAdapter, rOFDM0_RxDetector1, 0x40);
-			 * else if (pAdapter->HardwareType == HARDWARE_TYPE_RTL8192E)
-			 * else
-			 *	PlatformEFIOWrite1Byte(pAdapter, rOFDM0_RxDetector1, 0x40);
-			 */
 		} else
 			write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
 
@@ -1761,7 +1690,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 		write_nic_byte(dev, 0xa0a, 0x08);
 
 		/* 1.5 Higher EDCCA. */
-		/*PlatformEFIOWrite4Byte(pAdapter, rOFDM0_ECCAThreshold, 0x325);*/
 		return;
 	}
 
@@ -1782,7 +1710,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 		reset_cnt = priv->reset_count;
 
 		dm_digtable.dig_state = DM_STA_DIG_ON;
-		/*DbgPrint("DIG ON\n\r");*/
 
 		/* 2.1 Set initial gain.
 		 * 2008/02/26 MH SD3-Jerry suggest to prevent dirty environment.
@@ -1805,12 +1732,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 			 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 			 */
 			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
-			/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-			 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
-			 * else if (pAdapter->HardwareType == HARDWARE_TYPE_RTL8192E)
-			 * else
-			 *	PlatformEFIOWrite1Byte(pAdapter, rOFDM0_RxDetector1, 0x42);
-			 */
 		} else
 			write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
 
@@ -1820,7 +1741,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 		/* 2.4 Lower EDCCA.
 		 * 2008/01/11 MH 90/92 series are the same.
 		 */
-		/*PlatformEFIOWrite4Byte(pAdapter, rOFDM0_ECCAThreshold, 0x346);*/
 
 		/* 2.5 DIG On. */
 		rtl8192_setBBreg(dev, UFWP, bMaskByte1, 0x1);	/*  Only clear byte 1 and rewrite. */
@@ -1868,11 +1788,6 @@ static void dm_ctrl_initgain_byrssi_highpwr(
 		/* 3.1 Higher PD_TH for OFDM for high power state. */
 		if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
 			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x10);
-
-			/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-			 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
-			 */
-
 		} else
 			write_nic_byte(dev, rOFDM0_RxDetector1, 0x43);
 	} else {
@@ -1886,10 +1801,6 @@ static void dm_ctrl_initgain_byrssi_highpwr(
 			/*  3.2 Recover PD_TH for OFDM for normal power region. */
 			if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
 				write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
-				/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-				 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
-				 */
-
 			} else
 				write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
 		}
@@ -1931,7 +1842,6 @@ static void dm_initial_gain(
 		dm_digtable.cur_ig_value = priv->DefaultInitialGain[0];
 		dm_digtable.pre_ig_value = 0;
 	}
-	/*DbgPrint("DM_DigTable.CurIGValue = 0x%x, DM_DigTable.PreIGValue = 0x%x\n", DM_DigTable.CurIGValue, DM_DigTable.PreIGValue);*/
 
 	/* if silent reset happened, we should rewrite the values back */
 	if (priv->reset_count != reset_cnt) {
@@ -1947,7 +1857,6 @@ static void dm_initial_gain(
 		if ((dm_digtable.pre_ig_value != dm_digtable.cur_ig_value)
 			|| !initialized || force_write) {
 			initial_gain = (u8)dm_digtable.cur_ig_value;
-			/*DbgPrint("Write initial gain = 0x%x\n", initial_gain);*/
 			/*  Set initial gain. */
 			write_nic_byte(dev, rOFDM0_XAAGCCore1, initial_gain);
 			write_nic_byte(dev, rOFDM0_XBAGCCore1, initial_gain);
@@ -1999,7 +1908,6 @@ static void dm_pd_th(
 	{
 		if ((dm_digtable.prepd_thstate != dm_digtable.curpd_thstate) ||
 		    (initialized <= 3) || force_write) {
-			/*DbgPrint("Write PD_TH state = %d\n", DM_DigTable.CurPD_THState);*/
 			if (dm_digtable.curpd_thstate == DIG_PD_AT_LOW_POWER) {
 				/*  Lower PD_TH for OFDM. */
 				if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
@@ -2007,9 +1915,6 @@ static void dm_pd_th(
 					 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 					 */
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x00);
-					/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-					 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x40);
-					 */
 				} else
 					write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
 			} else if (dm_digtable.curpd_thstate == DIG_PD_AT_NORMAL_POWER) {
@@ -2019,18 +1924,12 @@ static void dm_pd_th(
 					 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 					 */
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
-					/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-					 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
-					 */
 				} else
 					write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
 			} else if (dm_digtable.curpd_thstate == DIG_PD_AT_HIGH_POWER) {
 				/* Higher PD_TH for OFDM for high power state. */
 				if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x10);
-					/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-					 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
-					 */
 				} else
 					write_nic_byte(dev, rOFDM0_RxDetector1, 0x43);
 			}
@@ -2077,7 +1976,6 @@ static	void dm_cs_ratio(
 	{
 		if ((dm_digtable.precs_ratio_state != dm_digtable.curcs_ratio_state) ||
 		    !initialized || force_write) {
-			/*DbgPrint("Write CS_ratio state = %d\n", DM_DigTable.CurCS_ratioState);*/
 			if (dm_digtable.curcs_ratio_state == DIG_CS_RATIO_LOWER) {
 				/*  Lower CS ratio for CCK. */
 				write_nic_byte(dev, 0xa0a, 0x08);
@@ -2106,7 +2004,6 @@ static void dm_check_edca_turbo(
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	PRT_HIGH_THROUGHPUT	pHTInfo = priv->ieee80211->pHTInfo;
-	/*PSTA_QOS			pStaQos = pMgntInfo->pStaQos;*/
 
 	/* Keep past Tx/Rx packet count for RT-to-RT EDCA turbo. */
 	static unsigned long			lastTxOkCnt;
@@ -2123,20 +2020,17 @@ static void dm_check_edca_turbo(
 	if (priv->ieee80211->pHTInfo->IOTAction & HT_IOT_ACT_DISABLE_EDCA_TURBO)
 		goto dm_CheckEdcaTurbo_EXIT;
 
-	/*printk("========>%s():bis_any_nonbepkts is %d\n", __func__, priv->bis_any_nonbepkts);*/
 	/* Check the status for current condition. */
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
@@ -2236,7 +2130,6 @@ static void dm_ctstoself(struct net_device *dev)
 		curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
 		if (curRxOkCnt > 4*curTxOkCnt) { /* downlink, disable CTS to self */
 			pHTInfo->IOTAction &= ~HT_IOT_ACT_FORCED_CTS2SELF;
-			/*DbgPrint("dm_CTSToSelf() ==> CTS to self disabled -- downlink\n");*/
 		} else { /* uplink */
 			pHTInfo->IOTAction |= HT_IOT_ACT_FORCED_CTS2SELF;
 		}
@@ -2295,7 +2188,6 @@ void dm_rf_pathcheck_workitemcallback(struct work_struct *work)
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct r8192_priv *priv = container_of(dwork, struct r8192_priv, rfpath_check_wq);
 	struct net_device *dev = priv->ieee80211->dev;
-	/*bool bactually_set = false;*/
 	u8 rfpath = 0, i;
 
 	/* 2008/01/30 MH After discussing with SD3 Jerry, 0xc04/0xd04 register will
@@ -2359,7 +2251,6 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 
 	if (priv->ieee80211->mode == WIRELESS_MODE_B) {
 		DM_RxPathSelTable.cck_method = CCK_RX_VERSION_2;	/* pure B mode, fixed cck version2 */
-		/*DbgPrint("Pure B mode, use cck rx version2\n");*/
 	}
 
 	/* decide max/sec/min rssi index */
@@ -2512,7 +2403,6 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 			if ((DM_RxPathSelTable.disabled_rf >> i) & 0x1) {	/* disabled rf */
 				if (tmp_max_rssi >= DM_RxPathSelTable.rf_enable_rssi_th[i]) {
 					/* enable the BB Rx path */
-					/*DbgPrint("RF-%d is enabled.\n", 0x1<<i);*/
 					rtl8192_setBBreg(dev, rOFDM0_TRxPathEnable, 0x1<<i, 0x1);	/* 0xc04[3:0] */
 					rtl8192_setBBreg(dev, rOFDM1_TRxPathEnable, 0x1<<i, 0x1);	/* 0xd04[3:0] */
 					DM_RxPathSelTable.rf_enable_rssi_th[i] = 100;
@@ -2734,7 +2624,6 @@ void dm_check_fsync(struct net_device *dev)
 #define	RegC38_NonFsync_Other_AP		1
 #define	RegC38_Fsync_AP_BCM			2
 	struct r8192_priv *priv = ieee80211_priv(dev);
-	/*u32			framesyncC34;*/
 	static u8		reg_c38_State = RegC38_Default;
 	static u32	reset_cnt;
 
@@ -2809,14 +2698,12 @@ void dm_check_fsync(struct net_device *dev)
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
@@ -2826,13 +2713,11 @@ void dm_check_fsync(struct net_device *dev)
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
@@ -2875,7 +2760,6 @@ static void dm_dynamic_txpower(struct net_device *dev)
 		priv->bDynamicTxLowPower = false;
 		return;
 	}
-	/*printk("priv->ieee80211->current_network.unknown_cap_exist is %d , priv->ieee80211->current_network.broadcom_cap_exist is %d\n", priv->ieee80211->current_network.unknown_cap_exist, priv->ieee80211->current_network.broadcom_cap_exist);*/
 	if ((priv->ieee80211->current_network.atheros_cap_exist) && (priv->ieee80211->mode == IEEE_G)) {
 		txhipower_threshold = TX_POWER_ATHEROAP_THRESH_HIGH;
 		txlowpower_threshold = TX_POWER_ATHEROAP_THRESH_LOW;
@@ -2884,7 +2768,6 @@ static void dm_dynamic_txpower(struct net_device *dev)
 		txlowpower_threshold = TX_POWER_NEAR_FIELD_THRESH_LOW;
 	}
 
-	/*printk("=======>%s(): txhipower_threshold is %d, txlowpower_threshold is %d\n", __func__, txhipower_threshold, txlowpower_threshold);*/
 	RT_TRACE(COMP_TXAGC, "priv->undecorated_smoothed_pwdb = %ld\n", priv->undecorated_smoothed_pwdb);
 
 	if (priv->ieee80211->state == IEEE80211_LINKED) {
@@ -2903,7 +2786,6 @@ static void dm_dynamic_txpower(struct net_device *dev)
 				priv->bDynamicTxLowPower = false;
 		}
 	} else {
-		/*pHalData->bTXPowerCtrlforNearFarRange = !pHalData->bTXPowerCtrlforNearFarRange;*/
 		priv->bDynamicTxHighPower = false;
 		priv->bDynamicTxLowPower = false;
 	}
@@ -2917,7 +2799,6 @@ static void dm_dynamic_txpower(struct net_device *dev)
 #endif
 
 		rtl8192_phy_setTxPower(dev, priv->ieee80211->current_network.channel);
-		/*pHalData->bStartTxCtrlByTPCNFR = FALSE;    Clear th flag of Set TX Power from Sitesurvey*/
 	}
 	priv->bLastDTPFlag_High = priv->bDynamicTxHighPower;
 	priv->bLastDTPFlag_Low = priv->bDynamicTxLowPower;
@@ -2930,14 +2811,10 @@ static void dm_check_txrateandretrycount(struct net_device *dev)
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

