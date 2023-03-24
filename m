Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED876C7E39
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjCXMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjCXMn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:43:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ABE11653
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:43:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso957728wmo.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679661802;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jx+R4cSW7y9UURB+CoB+AwTATFZegUBRSyHGO9SfPWY=;
        b=R5ddpEtnFlirjXA+hO6SCY+EHbqcFdy7LtjLBs5y8AgnvedkqhyUpjkW2uZ57wF0vx
         +5OswKlSslDkE9EPuXl5ynZn+CAV8LTYSnsSmvML1o6RkDrl8/+pNyjlQp1uql4ovmiQ
         LONyQFkTeZJNAVeO9NEcYtgSJTjCrFWBwDZABUU4qwjrCeduH0m+5XlAUezL6SbuGVu9
         jm2ftNEcnRhNXerZzv2PByU+4l5iuBgINOyxzdb3oRW2oI++d2XY/e1HbNV/r6X/JIBg
         g1/JMLSl8Oo88LdtqLz646SRqfMSGMZWRg+bXDO9Y1rPQglMz2up7wTG1Bl5RrBKb7aK
         YvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679661802;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jx+R4cSW7y9UURB+CoB+AwTATFZegUBRSyHGO9SfPWY=;
        b=22p404D86/ZNbw0tfzw1t4Yl9fqBWScCKjrCgOYQGUr3FCkmH2tE+22CfFvTx/R9/8
         FvICFmyBevPVa6N7fOoVIJiFQTvHHaPLO2Nst1Y/MatrYzSYErTilVR+9FczTt7Rq+9Q
         Qg8hq6ucDAF5drYQhRPhRspvc5Z+mk3Uz/op5Bz3OO3fGRRXNbRZXo55h4sVPDU+GhQo
         1cQIc2AbUMucmT5EoH9dNGG6I2snUvgpzP9la6FzEaj46Xtmk94rsWG82cXQgd3ZArCY
         +gEcaUJ+Xa8goRsLdTIUryIdbpxGdRpGm8BmZRfWDsBLVuhaOD9YieiTHWaNeMfyH9ts
         tqZw==
X-Gm-Message-State: AO0yUKXIDBcvzfGoKxcR45ppCLpyySAIx5O4QYbtu7mN6WhRS+NouGIP
        XEy9gHjzKG9lP9A+cyvJpybaScvDA9bqXt2t
X-Google-Smtp-Source: AK7set+lJWlJuj0RAKZS/+SXz/+/CLrX36wfEkvCIoJIHg6J/OiWz6c60aIHEYZOHgJP6rmyuUam8Q==
X-Received: by 2002:a05:600c:280e:b0:3ed:551b:b78f with SMTP id m14-20020a05600c280e00b003ed551bb78fmr2299989wmb.4.1679661802192;
        Fri, 24 Mar 2023 05:43:22 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c204400b003ee4e99a8f6sm4771446wmg.33.2023.03.24.05.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 05:43:21 -0700 (PDT)
Date:   Fri, 24 Mar 2023 17:43:19 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging rtl8192u: fix block comments
Message-ID: <ZB2a5zwYpBZ/6qwU@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel coding style for block comments uses a column of '*' on the
left side and ends the comment with '*/' on a separate line.

Fix block comments by adding '*' on subsequent lines and moving '*/' at
the end of block comments on a separate line. These issues in block
comments are reported by checkpatch.pl script.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 162 ++++++++++++++-------------
 1 file changed, 86 insertions(+), 76 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 6a33ca02c3dc..a88686be3523 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -1,19 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0
 /*++
-Copyright-c Realtek Semiconductor Corp. All rights reserved.
-
-Module Name:
-	r8192U_dm.c
-
-Abstract:
-	HW dynamic mechanism.
-
-Major Change History:
-	When		Who				What
-	----------	--------------- -------------------------------
-	2008-05-14	amy                     create version 0 porting from windows code.
-
---*/
+ * Copyright-c Realtek Semiconductor Corp. All rights reserved.
+ *
+ * Module Name:
+ *	r8192U_dm.c
+ *
+ * Abstract:
+ *	HW dynamic mechanism.
+ *
+ * Major Change History:
+ *	When		Who				What
+ *	----------	--------------- -------------------------------
+ *	2008-05-14	amy                     create version 0 porting from windows code.
+ *
+ *--
+ */
 #include "r8192U.h"
 #include "r8192U_dm.h"
 #include "r8192U_hw.h"
@@ -147,20 +148,20 @@ void dm_CheckRxAggregation(struct net_device *dev)
 	unsigned long		curRxOkCnt = 0;
 
 /*
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
+ *	if (pHalData->bForcedUsbRxAggr) {
+ *		if (pHalData->ForcedUsbRxAggrInfo == 0) {
+ *			if (pHalData->bCurrentRxAggrEnable) {
+ *				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, FALSE);
+ *			}
+ *		} else {
+ *			if (!pHalData->bCurrentRxAggrEnable || (pHalData->ForcedUsbRxAggrInfo != pHalData->LastUsbRxAggrInfoSetting)) {
+ *				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, TRUE);
+ *			}
+ *		}
+ *		return;
+ *	}
+ *
+ */
 	curTxOkCnt = priv->stats.txbytesunicast - lastTxOkCnt;
 	curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
 
@@ -279,7 +280,8 @@ void init_rate_adaptive(struct net_device *dev)
  *	When		Who		Remark
  *	05/26/08	amy	Create version 0 porting from windows code.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void dm_check_rate_adaptive(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -377,8 +379,9 @@ static void dm_check_rate_adaptive(struct net_device *dev)
 					targetRATR = pra->ping_rssi_ratr;
 					ping_rssi_state = 1;
 				}
-				/*else
-					DbgPrint("TestRSSI is between the range.\n");*/
+				/* else
+				 *	DbgPrint("TestRSSI is between the range.\n");
+				 */
 			} else {
 				/*DbgPrint("TestRSSI Recover to 0x%x\n", targetRATR);*/
 				ping_rssi_state = 0;
@@ -719,9 +722,10 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(struct net_device *dev)
 		}
 		tmpCCK40Mindex = 0;
 	}
-	/*DbgPrint("%ddb, tmpOFDMindex = %d, tmpCCK20Mindex = %d, tmpCCK40Mindex = %d",
-		((u1Byte)tmpRegA - pHalData->ThermalMeter[0]),
-		tmpOFDMindex, tmpCCK20Mindex, tmpCCK40Mindex);*/
+	/* DbgPrint("%ddb, tmpOFDMindex = %d, tmpCCK20Mindex = %d, tmpCCK40Mindex = %d",
+	 *	((u1Byte)tmpRegA - pHalData->ThermalMeter[0]),
+	 *	tmpOFDMindex, tmpCCK20Mindex, tmpCCK40Mindex);
+	 */
 	if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20)	/* 40M */
 		tmpCCKindex = tmpCCK40Mindex;
 	else
@@ -1594,7 +1598,8 @@ static void dm_bb_initialgain_backup(struct net_device *dev)
  *	When		Who		Remark
  *	05/15/2008	amy		Create Version 0 porting from windows code.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void dm_dig_init(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -1638,7 +1643,8 @@ static void dm_dig_init(struct net_device *dev)
  * Revised History:
  *	When		Who		Remark
  *	05/27/2008	amy		Create Version 0 porting from windows code.
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void dm_ctrl_initgain_byrssi(struct net_device *dev)
 {
 	if (!dm_digtable.dig_enable_flag)
@@ -1680,8 +1686,9 @@ static void dm_ctrl_initgain_byrssi_by_driverrssi(
 	else
 		dm_digtable.cur_connect_state = DIG_DISCONNECT;
 
-	/*DbgPrint("DM_DigTable.PreConnectState = %d, DM_DigTable.CurConnectState = %d\n",
-		DM_DigTable.PreConnectState, DM_DigTable.CurConnectState);*/
+	/* DbgPrint("DM_DigTable.PreConnectState = %d, DM_DigTable.CurConnectState = %d\n",
+	 *	DM_DigTable.PreConnectState, DM_DigTable.CurConnectState);
+	 */
 
 	dm_digtable.rssi_val = priv->undecorated_smoothed_pwdb;
 	/*DbgPrint("DM_DigTable.Rssi_val = %d\n", DM_DigTable.Rssi_val);*/
@@ -1720,12 +1727,12 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 	    (priv->undecorated_smoothed_pwdb < dm_digtable.rssi_high_thresh))
 		return;
 
-	/*DbgPrint("Dig by Fw False Alarm\n");*/
-	/*if (DM_DigTable.Dig_State == DM_STA_DIG_OFF)*/
-	/*DbgPrint("DIG Check\n\r RSSI=%d LOW=%d HIGH=%d STATE=%d",
-	pHalData->UndecoratedSmoothedPWDB, DM_DigTable.RssiLowThresh,
-	DM_DigTable.RssiHighThresh, DM_DigTable.Dig_State);*/
-	/* 1. When RSSI decrease, We have to judge if it is smaller than a threshold
+	/* DbgPrint("Dig by Fw False Alarm\n");
+	 * if (DM_DigTable.Dig_State == DM_STA_DIG_OFF)
+	 * DbgPrint("DIG Check\n\r RSSI=%d LOW=%d HIGH=%d STATE=%d",
+	 * pHalData->UndecoratedSmoothedPWDB, DM_DigTable.RssiLowThresh,
+	 * DM_DigTable.RssiHighThresh, DM_DigTable.Dig_State);
+	 * 1. When RSSI decrease, We have to judge if it is smaller than a threshold
 	 * and then execute the step below.
 	 */
 	if (priv->undecorated_smoothed_pwdb <= dm_digtable.rssi_low_thresh) {
@@ -1757,12 +1764,12 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
 			 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 			 */
 			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x00);
-			/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-				write_nic_byte(pAdapter, rOFDM0_RxDetector1, 0x40);
-			else if (pAdapter->HardwareType == HARDWARE_TYPE_RTL8192E)
-			else
-				PlatformEFIOWrite1Byte(pAdapter, rOFDM0_RxDetector1, 0x40);
-			*/
+			/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
+			 *	write_nic_byte(pAdapter, rOFDM0_RxDetector1, 0x40);
+			 * else if (pAdapter->HardwareType == HARDWARE_TYPE_RTL8192E)
+			 * else
+			 *	PlatformEFIOWrite1Byte(pAdapter, rOFDM0_RxDetector1, 0x40);
+			 */
 		} else
 			write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
 
@@ -1814,13 +1821,12 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
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
+			/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
+			 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
+			 * else if (pAdapter->HardwareType == HARDWARE_TYPE_RTL8192E)
+			 * else
+			 *	PlatformEFIOWrite1Byte(pAdapter, rOFDM0_RxDetector1, 0x42);
+			 */
 		} else
 			write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
 
@@ -1855,7 +1861,8 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
  *	When		Who		Remark
  *	05/28/2008	amy		Create Version 0 porting from windows code.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void dm_ctrl_initgain_byrssi_highpwr(
 	struct net_device *dev)
 {
@@ -1882,9 +1889,9 @@ static void dm_ctrl_initgain_byrssi_highpwr(
 		if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
 			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x10);
 
-			/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-				write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
-			*/
+			/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
+			 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
+			 */
 
 		} else
 			write_nic_byte(dev, rOFDM0_RxDetector1, 0x43);
@@ -1899,9 +1906,9 @@ static void dm_ctrl_initgain_byrssi_highpwr(
 			/*  3.2 Recover PD_TH for OFDM for normal power region. */
 			if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
 				write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
-				/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-					write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
-				*/
+				/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
+				 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
+				 */
 
 			} else
 				write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
@@ -2020,9 +2027,9 @@ static void dm_pd_th(
 					 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 					 */
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x00);
-					/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-						write_nic_byte(dev, rOFDM0_RxDetector1, 0x40);
-					*/
+					/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
+					 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x40);
+					 */
 				} else
 					write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
 			} else if (dm_digtable.curpd_thstate == DIG_PD_AT_NORMAL_POWER) {
@@ -2032,18 +2039,18 @@ static void dm_pd_th(
 					 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 					 */
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
-					/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-						write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
-					*/
+					/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
+					 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
+					 */
 				} else
 					write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
 			} else if (dm_digtable.curpd_thstate == DIG_PD_AT_HIGH_POWER) {
 				/* Higher PD_TH for OFDM for high power state. */
 				if (priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) {
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x10);
-					/*else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
-						write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
-					*/
+					/* else if (priv->card_8192 == HARDWARE_TYPE_RTL8190P)
+					 *	write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
+					 */
 				} else
 					write_nic_byte(dev, rOFDM0_RxDetector1, 0x43);
 			}
@@ -2274,7 +2281,8 @@ static void dm_ctstoself(struct net_device *dev)
  *	When		Who		Remark
  *	05/28/2008	amy	Create Version 0 porting from windows code.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static	void	dm_check_pbc_gpio(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -2308,7 +2316,8 @@ static	void	dm_check_pbc_gpio(struct net_device *dev)
  *	When		Who		Remark
  *	01/30/2008	MHC		Create Version 0.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 void dm_rf_pathcheck_workitemcallback(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
@@ -2557,7 +2566,8 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
  *	When		Who		Remark
  *	05/28/2008	amy		Create Version 0 porting from windows code.
  *
- *---------------------------------------------------------------------------*/
+ *---------------------------------------------------------------------------
+ */
 static void dm_check_rx_path_selection(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
-- 
2.34.1

