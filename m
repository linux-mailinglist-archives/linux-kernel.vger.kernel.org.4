Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E65626DB8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 05:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiKMEhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 23:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiKMEgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 23:36:37 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AAC13CF3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:36:19 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so5544749wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2DKr7cwbkVgEdJvuHQ0DWRO4kJzVzO0mkTMPxDpfInI=;
        b=WWQniVj+v02JZBk+1TvKBaHKMDoGBi3MPb000u8U/EgiTH/T1TxTiJx1+iimQ5gQ3W
         ij9YE9TpbEOX7EmF9lr/gxbEe6+Vyls40Cf94NhB7ehQE9HUCalDAUnaJrAGNFNLMbZf
         8ufR80v/LwG+WOVPiE7xrfffM5QNzcMxl8MnE/CsblD8Xbj+lnm6L9OvqOI3ONjli+O/
         mdOtwLMF7tuMMArz25yUQTXs3qDSbY0Mg0U4WKNmod4fqYuio0vvzYBwh0IKzszOfmzA
         RTLvIBq0bet2gPsBLCsB3g8jI7ehL6Q6tZyJ9ZQYe0cBJZO6NtnTVn1+oGgHsxruTOoq
         kM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DKr7cwbkVgEdJvuHQ0DWRO4kJzVzO0mkTMPxDpfInI=;
        b=ALvhcXChShPF0I33g7bzDTM2BHv4oZCftKbQ9qgB1lkqieK3RzE+7GLxiIPD91lZI/
         ghO5OxHBSRuAoRs+hoiV5EcCjQByp6lg4giW+xL+pi/P5WWIVI4faUInwnw5285ulwI5
         Z6yTdxIeOHwNeWIC5vdP7Njw7tqwQpFJRAJfBVlczd0hvEz1R5g98V3hntojr42wVJDU
         BR4bXaWmnwh2CYWJ6GVwnVlh5DIL6Bwq5LtPNo7LZwiu2OEc43mw50sQOcArvjkLi5oU
         ssDv1uVy3xEqWnjsd7gCxe3UGZnwICNxZaNg5cYx2fPMFCfohnj/N9AqUPVWTaCBx+NY
         AT2g==
X-Gm-Message-State: ANoB5pmXpwyniA4RkRDs6d/ZUKV5QrwJXUxx2mbSi11IxAWxJoC9O2qU
        emWRm46PNdwQsqWtssuZltQ=
X-Google-Smtp-Source: AA0mqf7Fg/LaxV/0UzvOCF52HyDH0HCvbm0mKeC5DGhit675MLM1B+TxyttvEztwgVfEu9C7mtWW5A==
X-Received: by 2002:a05:600c:1c89:b0:3cf:a41d:8418 with SMTP id k9-20020a05600c1c8900b003cfa41d8418mr5219611wms.190.1668314177739;
        Sat, 12 Nov 2022 20:36:17 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0a4f00b003b3365b38f9sm8229677wmq.10.2022.11.12.20.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:36:17 -0800 (PST)
Date:   Sun, 13 Nov 2022 05:36:15 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] staging: rtl8192e: Rename pHTInfo
Message-ID: <88cdc0ef393c92cb2102a66893c5320e8c8606df.1668313325.git.philipp.g.hortmann@gmail.com>
References: <cover.1668313325.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668313325.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable pHTInfo to ht_info to avoid CamelCase which is not
accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  10 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   |   2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  12 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  50 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |   2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c     |  20 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 354 +++++++++---------
 drivers/staging/rtl8192e/rtl819x_TSProc.c     |   2 +-
 drivers/staging/rtl8192e/rtllib.h             |   4 +-
 drivers/staging/rtl8192e/rtllib_module.c      |   6 +-
 drivers/staging/rtl8192e/rtllib_rx.c          |  12 +-
 drivers/staging/rtl8192e/rtllib_softmac.c     |  78 ++--
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |   8 +-
 drivers/staging/rtl8192e/rtllib_tx.c          |  54 +--
 14 files changed, 307 insertions(+), 307 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index e530f917fd23..b9c846015d28 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1978,7 +1978,7 @@ void rtl92e_update_ratr_table(struct net_device *dev)
 		break;
 	case IEEE_N_24G:
 	case IEEE_N_5G:
-		if (ieee->pHTInfo->peer_mimo_ps == 0) {
+		if (ieee->ht_info->peer_mimo_ps == 0) {
 			ratr_value &= 0x0007F007;
 		} else {
 			if (priv->rf_type == RF_1T2R)
@@ -1991,11 +1991,11 @@ void rtl92e_update_ratr_table(struct net_device *dev)
 		break;
 	}
 	ratr_value &= 0x0FFFFFFF;
-	if (ieee->pHTInfo->cur_tx_bw40mhz &&
-	    ieee->pHTInfo->bCurShortGI40MHz)
+	if (ieee->ht_info->cur_tx_bw40mhz &&
+	    ieee->ht_info->bCurShortGI40MHz)
 		ratr_value |= 0x80000000;
-	else if (!ieee->pHTInfo->cur_tx_bw40mhz &&
-		  ieee->pHTInfo->bCurShortGI20MHz)
+	else if (!ieee->ht_info->cur_tx_bw40mhz &&
+		  ieee->ht_info->bCurShortGI20MHz)
 		ratr_value |= 0x80000000;
 	rtl92e_writel(dev, RATR0+rate_index*4, ratr_value);
 	rtl92e_writeb(dev, UFWP, 1);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index 9d8d4837e6b2..a4d65b4d99c2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -41,7 +41,7 @@ void rtl92e_enable_hw_security_config(struct net_device *dev)
 	}
 
 	ieee->hwsec_active = 1;
-	if ((ieee->pHTInfo->iot_action & HT_IOT_ACT_PURE_N_MODE) || !hwwep) {
+	if ((ieee->ht_info->iot_action & HT_IOT_ACT_PURE_N_MODE) || !hwwep) {
 		ieee->hwsec_active = 0;
 		SECR_value &= ~SCR_RxDecEnable;
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 43601ec8d903..399ee9783f99 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -307,7 +307,7 @@ static void _rtl92e_update_cap(struct net_device *dev, u16 cap)
 		u8	cur_slot_time = priv->slot_time;
 
 		if ((cap & WLAN_CAPABILITY_SHORT_SLOT_TIME) &&
-		   (!priv->rtllib->pHTInfo->current_rt2rt_long_slot_time)) {
+		   (!priv->rtllib->ht_info->current_rt2rt_long_slot_time)) {
 			if (cur_slot_time != SHORT_SLOT_TIME) {
 				slot_time_val = SHORT_SLOT_TIME;
 				priv->rtllib->SetHwRegHandler(dev,
@@ -339,10 +339,10 @@ static void _rtl92e_update_beacon(void *data)
 	struct rtllib_device *ieee = priv->rtllib;
 	struct rtllib_network *net = &ieee->current_network;
 
-	if (ieee->pHTInfo->bCurrentHTSupport)
+	if (ieee->ht_info->bCurrentHTSupport)
 		HT_update_self_and_peer_setting(ieee, net);
-	ieee->pHTInfo->current_rt2rt_long_slot_time = net->bssht.bd_rt2rt_long_slot_time;
-	ieee->pHTInfo->RT2RT_HT_Mode = net->bssht.rt2rt_ht_mode;
+	ieee->ht_info->current_rt2rt_long_slot_time = net->bssht.bd_rt2rt_long_slot_time;
+	ieee->ht_info->RT2RT_HT_Mode = net->bssht.rt2rt_ht_mode;
 	_rtl92e_update_cap(dev, net->capability);
 }
 
@@ -672,9 +672,9 @@ void rtl92e_set_wireless_mode(struct net_device *dev, u8 wireless_mode)
 
 	if ((wireless_mode == WIRELESS_MODE_N_24G) ||
 	    (wireless_mode == WIRELESS_MODE_N_5G)) {
-		priv->rtllib->pHTInfo->enable_ht = 1;
+		priv->rtllib->ht_info->enable_ht = 1;
 	} else {
-		priv->rtllib->pHTInfo->enable_ht = 0;
+		priv->rtllib->ht_info->enable_ht = 0;
 	}
 	_rtl92e_refresh_support_rate(priv);
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index e0f6f1405c17..a18393c8a833 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -321,7 +321,7 @@ void rtl92e_init_adaptive_rate(struct net_device *dev)
 static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_hi_throughput *pHTInfo = priv->rtllib->pHTInfo;
+	struct rt_hi_throughput *ht_info = priv->rtllib->ht_info;
 	struct rate_adaptive *pra = &priv->rate_adaptive;
 	u32 currentRATR, targetRATR = 0;
 	u32 LowRSSIThreshForRA = 0, HighRSSIThreshForRA = 0;
@@ -340,10 +340,10 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 
 	if (priv->rtllib->state == RTLLIB_LINKED) {
 
-		bshort_gi_enabled = (pHTInfo->cur_tx_bw40mhz &&
-				     pHTInfo->bCurShortGI40MHz) ||
-				    (!pHTInfo->cur_tx_bw40mhz &&
-				     pHTInfo->bCurShortGI20MHz);
+		bshort_gi_enabled = (ht_info->cur_tx_bw40mhz &&
+				     ht_info->bCurShortGI40MHz) ||
+				    (!ht_info->cur_tx_bw40mhz &&
+				     ht_info->bCurShortGI20MHz);
 
 		pra->upper_rssi_threshold_ratr =
 				(pra->upper_rssi_threshold_ratr & (~BIT31)) |
@@ -1532,7 +1532,7 @@ void rtl92e_dm_init_edca_turbo(struct net_device *dev)
 static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	struct rt_hi_throughput *pHTInfo = priv->rtllib->pHTInfo;
+	struct rt_hi_throughput *ht_info = priv->rtllib->ht_info;
 
 	static unsigned long lastTxOkCnt;
 	static unsigned long lastRxOkCnt;
@@ -1543,18 +1543,18 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 		goto dm_CheckEdcaTurbo_EXIT;
 	if (priv->rtllib->state != RTLLIB_LINKED)
 		goto dm_CheckEdcaTurbo_EXIT;
-	if (priv->rtllib->pHTInfo->iot_action & HT_IOT_ACT_DISABLE_EDCA_TURBO)
+	if (priv->rtllib->ht_info->iot_action & HT_IOT_ACT_DISABLE_EDCA_TURBO)
 		goto dm_CheckEdcaTurbo_EXIT;
 
 	if (!priv->rtllib->bis_any_nonbepkts) {
 		curTxOkCnt = priv->stats.txbytesunicast - lastTxOkCnt;
 		curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
-		if (pHTInfo->iot_action & HT_IOT_ACT_EDCA_BIAS_ON_RX) {
+		if (ht_info->iot_action & HT_IOT_ACT_EDCA_BIAS_ON_RX) {
 			if (curTxOkCnt > 4*curRxOkCnt) {
 				if (priv->bis_cur_rdlstate ||
 				    !priv->bcurrent_turbo_EDCA) {
 					rtl92e_writel(dev, EDCAPARA_BE,
-						      edca_setting_UL[pHTInfo->IOTPeer]);
+						      edca_setting_UL[ht_info->IOTPeer]);
 					priv->bis_cur_rdlstate = false;
 				}
 			} else {
@@ -1562,10 +1562,10 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 				    !priv->bcurrent_turbo_EDCA) {
 					if (priv->rtllib->mode == WIRELESS_MODE_G)
 						rtl92e_writel(dev, EDCAPARA_BE,
-							      edca_setting_DL_GMode[pHTInfo->IOTPeer]);
+							      edca_setting_DL_GMode[ht_info->IOTPeer]);
 					else
 						rtl92e_writel(dev, EDCAPARA_BE,
-							      edca_setting_DL[pHTInfo->IOTPeer]);
+							      edca_setting_DL[ht_info->IOTPeer]);
 					priv->bis_cur_rdlstate = true;
 				}
 			}
@@ -1576,17 +1576,17 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 				    !priv->bcurrent_turbo_EDCA) {
 					if (priv->rtllib->mode == WIRELESS_MODE_G)
 						rtl92e_writel(dev, EDCAPARA_BE,
-							      edca_setting_DL_GMode[pHTInfo->IOTPeer]);
+							      edca_setting_DL_GMode[ht_info->IOTPeer]);
 					else
 						rtl92e_writel(dev, EDCAPARA_BE,
-							      edca_setting_DL[pHTInfo->IOTPeer]);
+							      edca_setting_DL[ht_info->IOTPeer]);
 					priv->bis_cur_rdlstate = true;
 				}
 			} else {
 				if (priv->bis_cur_rdlstate ||
 				    !priv->bcurrent_turbo_EDCA) {
 					rtl92e_writel(dev, EDCAPARA_BE,
-						      edca_setting_UL[pHTInfo->IOTPeer]);
+						      edca_setting_UL[ht_info->IOTPeer]);
 					priv->bis_cur_rdlstate = false;
 				}
 
@@ -1621,23 +1621,23 @@ static void _rtl92e_dm_init_cts_to_self(struct net_device *dev)
 static void _rtl92e_dm_cts_to_self(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv((struct net_device *)dev);
-	struct rt_hi_throughput *pHTInfo = priv->rtllib->pHTInfo;
+	struct rt_hi_throughput *ht_info = priv->rtllib->ht_info;
 	static unsigned long lastTxOkCnt;
 	static unsigned long lastRxOkCnt;
 	unsigned long curTxOkCnt = 0;
 	unsigned long curRxOkCnt = 0;
 
 	if (!priv->rtllib->bCTSToSelfEnable) {
-		pHTInfo->iot_action &= ~HT_IOT_ACT_FORCED_CTS2SELF;
+		ht_info->iot_action &= ~HT_IOT_ACT_FORCED_CTS2SELF;
 		return;
 	}
-	if (pHTInfo->IOTPeer == HT_IOT_PEER_BROADCOM) {
+	if (ht_info->IOTPeer == HT_IOT_PEER_BROADCOM) {
 		curTxOkCnt = priv->stats.txbytesunicast - lastTxOkCnt;
 		curRxOkCnt = priv->stats.rxbytesunicast - lastRxOkCnt;
 		if (curRxOkCnt > 4*curTxOkCnt)
-			pHTInfo->iot_action &= ~HT_IOT_ACT_FORCED_CTS2SELF;
+			ht_info->iot_action &= ~HT_IOT_ACT_FORCED_CTS2SELF;
 		else
-			pHTInfo->iot_action |= HT_IOT_ACT_FORCED_CTS2SELF;
+			ht_info->iot_action |= HT_IOT_ACT_FORCED_CTS2SELF;
 
 		lastTxOkCnt = priv->stats.txbytesunicast;
 		lastRxOkCnt = priv->stats.rxbytesunicast;
@@ -1648,10 +1648,10 @@ static void _rtl92e_dm_cts_to_self(struct net_device *dev)
 static void _rtl92e_dm_init_wa_broadcom_iot(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv((struct net_device *)dev);
-	struct rt_hi_throughput *pHTInfo = priv->rtllib->pHTInfo;
+	struct rt_hi_throughput *ht_info = priv->rtllib->ht_info;
 
-	pHTInfo->bWAIotBroadcom = false;
-	pHTInfo->WAIotTH = WAIotTHVal;
+	ht_info->bWAIotBroadcom = false;
+	ht_info->WAIotTH = WAIotTHVal;
 }
 
 static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
@@ -1992,7 +1992,7 @@ static void _rtl92e_dm_fsync_timer_callback(struct timer_list *t)
 
 	if (priv->rtllib->state == RTLLIB_LINKED &&
 	    priv->rtllib->bfsync_enable &&
-	    (priv->rtllib->pHTInfo->iot_action & HT_IOT_ACT_CDD_FSYNC)) {
+	    (priv->rtllib->ht_info->iot_action & HT_IOT_ACT_CDD_FSYNC)) {
 		u32 rate_bitmap;
 
 		for (rate_index = 0; rate_index <= 27; rate_index++) {
@@ -2163,7 +2163,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 	static u32 reset_cnt;
 
 	if (priv->rtllib->state == RTLLIB_LINKED &&
-	    priv->rtllib->pHTInfo->IOTPeer == HT_IOT_PEER_BROADCOM) {
+	    priv->rtllib->ht_info->IOTPeer == HT_IOT_PEER_BROADCOM) {
 		if (priv->rtllib->bfsync_enable == 0) {
 			switch (priv->rtllib->fsync_state) {
 			case Default_Fsync:
@@ -2288,7 +2288,7 @@ static void _rtl92e_dm_dynamic_tx_power(struct net_device *dev)
 		priv->bDynamicTxLowPower = false;
 		return;
 	}
-	if ((priv->rtllib->pHTInfo->IOTPeer == HT_IOT_PEER_ATHEROS) &&
+	if ((priv->rtllib->ht_info->IOTPeer == HT_IOT_PEER_ATHEROS) &&
 	    (priv->rtllib->mode == IEEE_G)) {
 		txhipower_threshold = TX_POWER_ATHEROAP_THRESH_HIGH;
 		txlowpower_threshold = TX_POWER_ATHEROAP_THRESH_LOW;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 7ff14aa9f476..bf0030144e5d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -915,7 +915,7 @@ static int _rtl92e_wx_set_encode_ext(struct net_device *dev,
 					 key, 0);
 		} else {
 			if ((ieee->pairwise_key_type == KEY_TYPE_CCMP) &&
-			     ieee->pHTInfo->bCurrentHTSupport)
+			     ieee->ht_info->bCurrentHTSupport)
 				rtl92e_writeb(dev, 0x173, 1);
 			rtl92e_set_key(dev, 4, idx, alg,
 				       (u8 *)ieee->ap_mac_addr, 0, key);
diff --git a/drivers/staging/rtl8192e/rtl819x_BAProc.c b/drivers/staging/rtl8192e/rtl819x_BAProc.c
index 7c0369319f97..acc19514bca6 100644
--- a/drivers/staging/rtl8192e/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_BAProc.c
@@ -244,13 +244,13 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	pBaStartSeqCtrl = (union sequence_control *)(req + 7);
 
 	if (!ieee->current_network.qos_data.active ||
-	    !ieee->pHTInfo->bCurrentHTSupport ||
-	    (ieee->pHTInfo->iot_action & HT_IOT_ACT_REJECT_ADDBA_REQ)) {
+	    !ieee->ht_info->bCurrentHTSupport ||
+	    (ieee->ht_info->iot_action & HT_IOT_ACT_REJECT_ADDBA_REQ)) {
 		rc = ADDBA_STATUS_REFUSED;
 		netdev_warn(ieee->dev,
 			    "Failed to reply on ADDBA_REQ as some capability is not ready(%d, %d)\n",
 			    ieee->current_network.qos_data.active,
-			    ieee->pHTInfo->bCurrentHTSupport);
+			    ieee->ht_info->bCurrentHTSupport);
 		goto OnADDBAReq_Fail;
 	}
 	if (!GetTs(ieee, (struct ts_common_info **)&pTS, dst,
@@ -277,7 +277,7 @@ int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb)
 	pBA->ba_start_seq_ctrl = *pBaStartSeqCtrl;
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev) ||
-	   (ieee->pHTInfo->iot_action & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
+	   (ieee->ht_info->iot_action & HT_IOT_ACT_ALLOW_PEER_AGG_ONE_PKT))
 		pBA->ba_param_set.field.buffer_size = 1;
 	else
 		pBA->ba_param_set.field.buffer_size = 32;
@@ -326,13 +326,13 @@ int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb)
 	pBaTimeoutVal = (u16 *)(tag + 7);
 
 	if (!ieee->current_network.qos_data.active ||
-	    !ieee->pHTInfo->bCurrentHTSupport ||
-	    !ieee->pHTInfo->bCurrentAMPDUEnable) {
+	    !ieee->ht_info->bCurrentHTSupport ||
+	    !ieee->ht_info->bCurrentAMPDUEnable) {
 		netdev_warn(ieee->dev,
 			    "reject to ADDBA_RSP as some capability is not ready(%d, %d, %d)\n",
 			    ieee->current_network.qos_data.active,
-			    ieee->pHTInfo->bCurrentHTSupport,
-			    ieee->pHTInfo->bCurrentAMPDUEnable);
+			    ieee->ht_info->bCurrentHTSupport,
+			    ieee->ht_info->bCurrentAMPDUEnable);
 		ReasonCode = DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
 	}
@@ -413,11 +413,11 @@ int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb)
 	}
 
 	if (!ieee->current_network.qos_data.active ||
-	    !ieee->pHTInfo->bCurrentHTSupport) {
+	    !ieee->ht_info->bCurrentHTSupport) {
 		netdev_warn(ieee->dev,
 			    "received DELBA while QOS or HT is not supported(%d, %d)\n",
 			    ieee->current_network. qos_data.active,
-			    ieee->pHTInfo->bCurrentHTSupport);
+			    ieee->ht_info->bCurrentHTSupport);
 		return -1;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 2c4c1cb4cbed..fe30a291e64c 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -69,48 +69,48 @@ static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
 
 void HTUpdateDefaultSetting(struct rtllib_device *ieee)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	pHTInfo->bRegShortGI20MHz = 1;
-	pHTInfo->bRegShortGI40MHz = 1;
+	ht_info->bRegShortGI20MHz = 1;
+	ht_info->bRegShortGI40MHz = 1;
 
-	pHTInfo->bRegBW40MHz = 1;
+	ht_info->bRegBW40MHz = 1;
 
-	if (pHTInfo->bRegBW40MHz)
-		pHTInfo->bRegSuppCCK = 1;
+	if (ht_info->bRegBW40MHz)
+		ht_info->bRegSuppCCK = 1;
 	else
-		pHTInfo->bRegSuppCCK = true;
+		ht_info->bRegSuppCCK = true;
 
-	pHTInfo->nAMSDU_MaxSize = 7935UL;
-	pHTInfo->bAMSDU_Support = 0;
+	ht_info->nAMSDU_MaxSize = 7935UL;
+	ht_info->bAMSDU_Support = 0;
 
-	pHTInfo->bAMPDUEnable = 1;
-	pHTInfo->AMPDU_Factor = 2;
-	pHTInfo->MPDU_Density = 0;
+	ht_info->bAMPDUEnable = 1;
+	ht_info->AMPDU_Factor = 2;
+	ht_info->MPDU_Density = 0;
 
-	pHTInfo->self_mimo_ps = 3;
-	if (pHTInfo->self_mimo_ps == 2)
-		pHTInfo->self_mimo_ps = 3;
+	ht_info->self_mimo_ps = 3;
+	if (ht_info->self_mimo_ps == 2)
+		ht_info->self_mimo_ps = 3;
 	ieee->tx_dis_rate_fallback = 0;
 	ieee->tx_use_drv_assinged_rate = 0;
 
 	ieee->bTxEnableFwCalcDur = 1;
 
-	pHTInfo->reg_rt2rt_aggregation = 1;
+	ht_info->reg_rt2rt_aggregation = 1;
 
-	pHTInfo->reg_rx_reorder_enable = 1;
-	pHTInfo->rx_reorder_win_size = 64;
-	pHTInfo->rx_reorder_pending_time = 30;
+	ht_info->reg_rx_reorder_enable = 1;
+	ht_info->rx_reorder_win_size = 64;
+	ht_info->rx_reorder_pending_time = 30;
 }
 
 static u16 HTMcsToDataRate(struct rtllib_device *ieee, u8 nMcsRate)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	u8	is40MHz = (pHTInfo->bCurBW40MHz) ? 1 : 0;
-	u8	isShortGI = (pHTInfo->bCurBW40MHz) ?
-			    ((pHTInfo->bCurShortGI40MHz) ? 1 : 0) :
-			    ((pHTInfo->bCurShortGI20MHz) ? 1 : 0);
+	u8	is40MHz = (ht_info->bCurBW40MHz) ? 1 : 0;
+	u8	isShortGI = (ht_info->bCurBW40MHz) ?
+			    ((ht_info->bCurShortGI40MHz) ? 1 : 0) :
+			    ((ht_info->bCurShortGI20MHz) ? 1 : 0);
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
 }
 
@@ -166,45 +166,45 @@ bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
 
 static void HTIOTPeerDetermine(struct rtllib_device *ieee)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct rtllib_network *net = &ieee->current_network;
 
 	if (net->bssht.bd_rt2rt_aggregation) {
-		pHTInfo->IOTPeer = HT_IOT_PEER_REALTEK;
+		ht_info->IOTPeer = HT_IOT_PEER_REALTEK;
 		if (net->bssht.rt2rt_ht_mode & RT_HT_CAP_USE_92SE)
-			pHTInfo->IOTPeer = HT_IOT_PEER_REALTEK_92SE;
+			ht_info->IOTPeer = HT_IOT_PEER_REALTEK_92SE;
 		if (net->bssht.rt2rt_ht_mode & RT_HT_CAP_USE_SOFTAP)
-			pHTInfo->IOTPeer = HT_IOT_PEER_92U_SOFTAP;
+			ht_info->IOTPeer = HT_IOT_PEER_92U_SOFTAP;
 	} else if (net->broadcom_cap_exist) {
-		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
+		ht_info->IOTPeer = HT_IOT_PEER_BROADCOM;
 	} else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
 		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
 		 !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)) {
-		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
+		ht_info->IOTPeer = HT_IOT_PEER_BROADCOM;
 	} else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
 		 (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
 		 (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
 		 (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
 		 (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
 		  net->ralink_cap_exist) {
-		pHTInfo->IOTPeer = HT_IOT_PEER_RALINK;
+		ht_info->IOTPeer = HT_IOT_PEER_RALINK;
 	} else if ((net->atheros_cap_exist) ||
 		(memcmp(net->bssid, DLINK_ATHEROS_1, 3) == 0) ||
 		(memcmp(net->bssid, DLINK_ATHEROS_2, 3) == 0)) {
-		pHTInfo->IOTPeer = HT_IOT_PEER_ATHEROS;
+		ht_info->IOTPeer = HT_IOT_PEER_ATHEROS;
 	} else if ((memcmp(net->bssid, CISCO_BROADCOM, 3) == 0) ||
 		  net->cisco_cap_exist) {
-		pHTInfo->IOTPeer = HT_IOT_PEER_CISCO;
+		ht_info->IOTPeer = HT_IOT_PEER_CISCO;
 	} else if ((memcmp(net->bssid, LINKSYS_MARVELL_4400N, 3) == 0) ||
 		  net->marvell_cap_exist) {
-		pHTInfo->IOTPeer = HT_IOT_PEER_MARVELL;
+		ht_info->IOTPeer = HT_IOT_PEER_MARVELL;
 	} else if (net->airgo_cap_exist) {
-		pHTInfo->IOTPeer = HT_IOT_PEER_AIRGO;
+		ht_info->IOTPeer = HT_IOT_PEER_AIRGO;
 	} else {
-		pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
+		ht_info->IOTPeer = HT_IOT_PEER_UNKNOWN;
 	}
 
-	netdev_dbg(ieee->dev, "IOTPEER: %x\n", pHTInfo->IOTPeer);
+	netdev_dbg(ieee->dev, "IOTPEER: %x\n", ht_info->IOTPeer);
 }
 
 static u8 HTIOTActIsDisableMCS14(struct rtllib_device *ieee, u8 *PeerMacAddr)
@@ -233,7 +233,7 @@ static u8 HTIOTActIsMgntUseCCK6M(struct rtllib_device *ieee,
 {
 	u8	retValue = 0;
 
-	if (ieee->pHTInfo->IOTPeer == HT_IOT_PEER_BROADCOM)
+	if (ieee->ht_info->IOTPeer == HT_IOT_PEER_BROADCOM)
 		retValue = 1;
 
 	return retValue;
@@ -243,40 +243,40 @@ static u8 HTIOTActIsCCDFsync(struct rtllib_device *ieee)
 {
 	u8	retValue = 0;
 
-	if (ieee->pHTInfo->IOTPeer == HT_IOT_PEER_BROADCOM)
+	if (ieee->ht_info->IOTPeer == HT_IOT_PEER_BROADCOM)
 		retValue = 1;
 	return retValue;
 }
 
 static void HTIOTActDetermineRaFunc(struct rtllib_device *ieee, bool bPeerRx2ss)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	pHTInfo->iot_ra_func &= HT_IOT_RAFUNC_DISABLE_ALL;
+	ht_info->iot_ra_func &= HT_IOT_RAFUNC_DISABLE_ALL;
 
-	if (pHTInfo->IOTPeer == HT_IOT_PEER_RALINK && !bPeerRx2ss)
-		pHTInfo->iot_ra_func |= HT_IOT_RAFUNC_PEER_1R;
+	if (ht_info->IOTPeer == HT_IOT_PEER_RALINK && !bPeerRx2ss)
+		ht_info->iot_ra_func |= HT_IOT_RAFUNC_PEER_1R;
 
-	if (pHTInfo->iot_action & HT_IOT_ACT_AMSDU_ENABLE)
-		pHTInfo->iot_ra_func |= HT_IOT_RAFUNC_TX_AMSDU;
+	if (ht_info->iot_action & HT_IOT_ACT_AMSDU_ENABLE)
+		ht_info->iot_ra_func |= HT_IOT_RAFUNC_TX_AMSDU;
 }
 
-void HTResetIOTSetting(struct rt_hi_throughput *pHTInfo)
+void HTResetIOTSetting(struct rt_hi_throughput *ht_info)
 {
-	pHTInfo->iot_action = 0;
-	pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
-	pHTInfo->iot_ra_func = 0;
+	ht_info->iot_action = 0;
+	ht_info->IOTPeer = HT_IOT_PEER_UNKNOWN;
+	ht_info->iot_ra_func = 0;
 }
 
 void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 				  u8 *len, u8 IsEncrypt, bool bAssoc)
 {
-	struct rt_hi_throughput *pHT = ieee->pHTInfo;
+	struct rt_hi_throughput *pHT = ieee->ht_info;
 	struct ht_capab_ele *pCapELE = NULL;
 
 	if (!posHTCap || !pHT) {
 		netdev_warn(ieee->dev,
-			    "%s(): posHTCap and pHTInfo are null\n", __func__);
+			    "%s(): posHTCap and ht_info are null\n", __func__);
 		return;
 	}
 	memset(posHTCap, 0, *len);
@@ -352,7 +352,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 void HTConstructInfoElement(struct rtllib_device *ieee, u8 *posHTInfo,
 			    u8 *len, u8 IsEncrypt)
 {
-	struct rt_hi_throughput *pHT = ieee->pHTInfo;
+	struct rt_hi_throughput *pHT = ieee->ht_info;
 	struct ht_info_ele *pHTInfoEle = (struct ht_info_ele *)posHTInfo;
 
 	if (!posHTInfo || !pHTInfoEle) {
@@ -509,7 +509,7 @@ void HTSetConnectBwMode(struct rtllib_device *ieee,
 
 void HTOnAssocRsp(struct rtllib_device *ieee)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct ht_capab_ele *pPeerHTCap = NULL;
 	struct ht_info_ele *pPeerHTInfo = NULL;
 	u16 nMaxAMSDUSize = 0;
@@ -518,22 +518,22 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	static const u8 EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
 	static const u8 EWC11NHTInfo[] = { 0x00, 0x90, 0x4c, 0x34 };
 
-	if (!pHTInfo->bCurrentHTSupport) {
+	if (!ht_info->bCurrentHTSupport) {
 		netdev_warn(ieee->dev, "%s(): HT_DISABLE\n", __func__);
 		return;
 	}
 	netdev_dbg(ieee->dev, "%s(): HT_ENABLE\n", __func__);
 
-	if (!memcmp(pHTInfo->PeerHTCapBuf, EWC11NHTCap, sizeof(EWC11NHTCap)))
-		pPeerHTCap = (struct ht_capab_ele *)(&pHTInfo->PeerHTCapBuf[4]);
+	if (!memcmp(ht_info->PeerHTCapBuf, EWC11NHTCap, sizeof(EWC11NHTCap)))
+		pPeerHTCap = (struct ht_capab_ele *)(&ht_info->PeerHTCapBuf[4]);
 	else
-		pPeerHTCap = (struct ht_capab_ele *)(pHTInfo->PeerHTCapBuf);
+		pPeerHTCap = (struct ht_capab_ele *)(ht_info->PeerHTCapBuf);
 
-	if (!memcmp(pHTInfo->PeerHTInfoBuf, EWC11NHTInfo, sizeof(EWC11NHTInfo)))
+	if (!memcmp(ht_info->PeerHTInfoBuf, EWC11NHTInfo, sizeof(EWC11NHTInfo)))
 		pPeerHTInfo = (struct ht_info_ele *)
-			     (&pHTInfo->PeerHTInfoBuf[4]);
+			     (&ht_info->PeerHTInfoBuf[4]);
 	else
-		pPeerHTInfo = (struct ht_info_ele *)(pHTInfo->PeerHTInfoBuf);
+		pPeerHTInfo = (struct ht_info_ele *)(ht_info->PeerHTInfoBuf);
 
 #ifdef VERBOSE_DEBUG
 	print_hex_dump_bytes("%s: ", __func__, DUMP_PREFIX_NONE,
@@ -541,63 +541,63 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 #endif
 	HTSetConnectBwMode(ieee, (enum ht_channel_width)(pPeerHTCap->ChlWidth),
 			   (enum ht_extchnl_offset)(pPeerHTInfo->ExtChlOffset));
-	pHTInfo->cur_tx_bw40mhz = ((pPeerHTInfo->RecommemdedTxWidth == 1) ?
+	ht_info->cur_tx_bw40mhz = ((pPeerHTInfo->RecommemdedTxWidth == 1) ?
 				 true : false);
 
-	pHTInfo->bCurShortGI20MHz = ((pHTInfo->bRegShortGI20MHz) ?
+	ht_info->bCurShortGI20MHz = ((ht_info->bRegShortGI20MHz) ?
 				    ((pPeerHTCap->ShortGI20Mhz == 1) ?
 				    true : false) : false);
-	pHTInfo->bCurShortGI40MHz = ((pHTInfo->bRegShortGI40MHz) ?
+	ht_info->bCurShortGI40MHz = ((ht_info->bRegShortGI40MHz) ?
 				     ((pPeerHTCap->ShortGI40Mhz == 1) ?
 				     true : false) : false);
 
-	pHTInfo->bCurSuppCCK = ((pHTInfo->bRegSuppCCK) ?
+	ht_info->bCurSuppCCK = ((ht_info->bRegSuppCCK) ?
 			       ((pPeerHTCap->DssCCk == 1) ? true :
 			       false) : false);
 
-	pHTInfo->bCurrent_AMSDU_Support = pHTInfo->bAMSDU_Support;
+	ht_info->bCurrent_AMSDU_Support = ht_info->bAMSDU_Support;
 
 	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
 
-	if (pHTInfo->nAMSDU_MaxSize > nMaxAMSDUSize)
-		pHTInfo->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
+	if (ht_info->nAMSDU_MaxSize > nMaxAMSDUSize)
+		ht_info->nCurrent_AMSDU_MaxSize = nMaxAMSDUSize;
 	else
-		pHTInfo->nCurrent_AMSDU_MaxSize = pHTInfo->nAMSDU_MaxSize;
+		ht_info->nCurrent_AMSDU_MaxSize = ht_info->nAMSDU_MaxSize;
 
-	pHTInfo->bCurrentAMPDUEnable = pHTInfo->bAMPDUEnable;
+	ht_info->bCurrentAMPDUEnable = ht_info->bAMPDUEnable;
 	if (ieee->rtllib_ap_sec_type &&
 	    (ieee->rtllib_ap_sec_type(ieee) & (SEC_ALG_WEP | SEC_ALG_TKIP))) {
-		if ((pHTInfo->IOTPeer == HT_IOT_PEER_ATHEROS) ||
-		    (pHTInfo->IOTPeer == HT_IOT_PEER_UNKNOWN))
-			pHTInfo->bCurrentAMPDUEnable = false;
+		if ((ht_info->IOTPeer == HT_IOT_PEER_ATHEROS) ||
+		    (ht_info->IOTPeer == HT_IOT_PEER_UNKNOWN))
+			ht_info->bCurrentAMPDUEnable = false;
 	}
 
-	if (!pHTInfo->reg_rt2rt_aggregation) {
-		if (pHTInfo->AMPDU_Factor > pPeerHTCap->MaxRxAMPDUFactor)
-			pHTInfo->CurrentAMPDUFactor =
+	if (!ht_info->reg_rt2rt_aggregation) {
+		if (ht_info->AMPDU_Factor > pPeerHTCap->MaxRxAMPDUFactor)
+			ht_info->CurrentAMPDUFactor =
 						 pPeerHTCap->MaxRxAMPDUFactor;
 		else
-			pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
+			ht_info->CurrentAMPDUFactor = ht_info->AMPDU_Factor;
 
 	} else {
 		if (ieee->current_network.bssht.bd_rt2rt_aggregation) {
 			if (ieee->pairwise_key_type != KEY_TYPE_NA)
-				pHTInfo->CurrentAMPDUFactor =
+				ht_info->CurrentAMPDUFactor =
 						 pPeerHTCap->MaxRxAMPDUFactor;
 			else
-				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
+				ht_info->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
 		} else {
-			pHTInfo->CurrentAMPDUFactor = min_t(u32, pPeerHTCap->MaxRxAMPDUFactor,
+			ht_info->CurrentAMPDUFactor = min_t(u32, pPeerHTCap->MaxRxAMPDUFactor,
 							    HT_AGG_SIZE_32K);
 		}
 	}
-	pHTInfo->current_mpdu_density = max_t(u8, pHTInfo->MPDU_Density,
+	ht_info->current_mpdu_density = max_t(u8, ht_info->MPDU_Density,
 					      pPeerHTCap->MPDUDensity);
-	if (pHTInfo->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
-		pHTInfo->bCurrentAMPDUEnable = false;
-		pHTInfo->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
+	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
+		ht_info->bCurrentAMPDUEnable = false;
+		ht_info->ForcedAMSDUMode = HT_AGG_FORCE_ENABLE;
 	}
-	pHTInfo->cur_rx_reorder_enable = pHTInfo->reg_rx_reorder_enable;
+	ht_info->cur_rx_reorder_enable = ht_info->reg_rx_reorder_enable;
 
 	if (pPeerHTCap->MCS[0] == 0)
 		pPeerHTCap->MCS[0] = 0xff;
@@ -606,8 +606,8 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 
 	HTFilterMCSRate(ieee, pPeerHTCap->MCS, ieee->dot11ht_oper_rate_set);
 
-	pHTInfo->peer_mimo_ps = pPeerHTCap->MimoPwrSave;
-	if (pHTInfo->peer_mimo_ps == MIMO_PS_STATIC)
+	ht_info->peer_mimo_ps = pPeerHTCap->MimoPwrSave;
+	if (ht_info->peer_mimo_ps == MIMO_PS_STATIC)
 		pMcsFilter = MCS_FILTER_1SS;
 	else
 		pMcsFilter = MCS_FILTER_ALL;
@@ -616,49 +616,49 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 						       pMcsFilter);
 	ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
 
-	pHTInfo->current_op_mode = pPeerHTInfo->OptMode;
+	ht_info->current_op_mode = pPeerHTInfo->OptMode;
 }
 
 void HTInitializeHTInfo(struct rtllib_device *ieee)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	pHTInfo->bCurrentHTSupport = false;
+	ht_info->bCurrentHTSupport = false;
 
-	pHTInfo->bCurBW40MHz = false;
-	pHTInfo->cur_tx_bw40mhz = false;
+	ht_info->bCurBW40MHz = false;
+	ht_info->cur_tx_bw40mhz = false;
 
-	pHTInfo->bCurShortGI20MHz = false;
-	pHTInfo->bCurShortGI40MHz = false;
-	pHTInfo->forced_short_gi = false;
+	ht_info->bCurShortGI20MHz = false;
+	ht_info->bCurShortGI40MHz = false;
+	ht_info->forced_short_gi = false;
 
-	pHTInfo->bCurSuppCCK = true;
+	ht_info->bCurSuppCCK = true;
 
-	pHTInfo->bCurrent_AMSDU_Support = false;
-	pHTInfo->nCurrent_AMSDU_MaxSize = pHTInfo->nAMSDU_MaxSize;
-	pHTInfo->current_mpdu_density = pHTInfo->MPDU_Density;
-	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
+	ht_info->bCurrent_AMSDU_Support = false;
+	ht_info->nCurrent_AMSDU_MaxSize = ht_info->nAMSDU_MaxSize;
+	ht_info->current_mpdu_density = ht_info->MPDU_Density;
+	ht_info->CurrentAMPDUFactor = ht_info->AMPDU_Factor;
 
-	memset((void *)(&pHTInfo->SelfHTCap), 0,
-	       sizeof(pHTInfo->SelfHTCap));
-	memset((void *)(&pHTInfo->SelfHTInfo), 0,
-	       sizeof(pHTInfo->SelfHTInfo));
-	memset((void *)(&pHTInfo->PeerHTCapBuf), 0,
-	       sizeof(pHTInfo->PeerHTCapBuf));
-	memset((void *)(&pHTInfo->PeerHTInfoBuf), 0,
-	       sizeof(pHTInfo->PeerHTInfoBuf));
+	memset((void *)(&ht_info->SelfHTCap), 0,
+	       sizeof(ht_info->SelfHTCap));
+	memset((void *)(&ht_info->SelfHTInfo), 0,
+	       sizeof(ht_info->SelfHTInfo));
+	memset((void *)(&ht_info->PeerHTCapBuf), 0,
+	       sizeof(ht_info->PeerHTCapBuf));
+	memset((void *)(&ht_info->PeerHTInfoBuf), 0,
+	       sizeof(ht_info->PeerHTInfoBuf));
 
-	pHTInfo->sw_bw_in_progress = false;
+	ht_info->sw_bw_in_progress = false;
 
-	pHTInfo->ePeerHTSpecVer = HT_SPEC_VER_IEEE;
+	ht_info->ePeerHTSpecVer = HT_SPEC_VER_IEEE;
 
-	pHTInfo->current_rt2rt_aggregation = false;
-	pHTInfo->current_rt2rt_long_slot_time = false;
-	pHTInfo->RT2RT_HT_Mode = (enum rt_ht_capability)0;
+	ht_info->current_rt2rt_aggregation = false;
+	ht_info->current_rt2rt_long_slot_time = false;
+	ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 
-	pHTInfo->IOTPeer = 0;
-	pHTInfo->iot_action = 0;
-	pHTInfo->iot_ra_func = 0;
+	ht_info->IOTPeer = 0;
+	ht_info->iot_action = 0;
+	ht_info->iot_ra_func = 0;
 
 	{
 		u8 *RegHTSuppRateSets = &ieee->reg_ht_supp_rate_set[0];
@@ -687,114 +687,114 @@ void HTInitializeBssDesc(struct bss_ht *pBssHT)
 void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 				   struct rtllib_network *pNetwork)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	u8	bIOTAction = 0;
 
 	/* unmark enable_ht flag here is the same reason why unmarked in
 	 * function rtllib_softmac_new_net. WB 2008.09.10
 	 */
 	if (pNetwork->bssht.bd_support_ht) {
-		pHTInfo->bCurrentHTSupport = true;
-		pHTInfo->ePeerHTSpecVer = pNetwork->bssht.bd_ht_spec_ver;
+		ht_info->bCurrentHTSupport = true;
+		ht_info->ePeerHTSpecVer = pNetwork->bssht.bd_ht_spec_ver;
 
 		if (pNetwork->bssht.bd_ht_cap_len > 0 &&
-		    pNetwork->bssht.bd_ht_cap_len <= sizeof(pHTInfo->PeerHTCapBuf))
-			memcpy(pHTInfo->PeerHTCapBuf,
+		    pNetwork->bssht.bd_ht_cap_len <= sizeof(ht_info->PeerHTCapBuf))
+			memcpy(ht_info->PeerHTCapBuf,
 			       pNetwork->bssht.bd_ht_cap_buf,
 			       pNetwork->bssht.bd_ht_cap_len);
 
 		if (pNetwork->bssht.bd_ht_info_len > 0 &&
 		    pNetwork->bssht.bd_ht_info_len <=
-		    sizeof(pHTInfo->PeerHTInfoBuf))
-			memcpy(pHTInfo->PeerHTInfoBuf,
+		    sizeof(ht_info->PeerHTInfoBuf))
+			memcpy(ht_info->PeerHTInfoBuf,
 			       pNetwork->bssht.bd_ht_info_buf,
 			       pNetwork->bssht.bd_ht_info_len);
 
-		if (pHTInfo->reg_rt2rt_aggregation) {
-			pHTInfo->current_rt2rt_aggregation =
+		if (ht_info->reg_rt2rt_aggregation) {
+			ht_info->current_rt2rt_aggregation =
 				 pNetwork->bssht.bd_rt2rt_aggregation;
-			pHTInfo->current_rt2rt_long_slot_time =
+			ht_info->current_rt2rt_long_slot_time =
 				 pNetwork->bssht.bd_rt2rt_long_slot_time;
-			pHTInfo->RT2RT_HT_Mode = pNetwork->bssht.rt2rt_ht_mode;
+			ht_info->RT2RT_HT_Mode = pNetwork->bssht.rt2rt_ht_mode;
 		} else {
-			pHTInfo->current_rt2rt_aggregation = false;
-			pHTInfo->current_rt2rt_long_slot_time = false;
-			pHTInfo->RT2RT_HT_Mode = (enum rt_ht_capability)0;
+			ht_info->current_rt2rt_aggregation = false;
+			ht_info->current_rt2rt_long_slot_time = false;
+			ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 		}
 
 		HTIOTPeerDetermine(ieee);
 
-		pHTInfo->iot_action = 0;
+		ht_info->iot_action = 0;
 		bIOTAction = HTIOTActIsDisableMCS14(ieee, pNetwork->bssid);
 		if (bIOTAction)
-			pHTInfo->iot_action |= HT_IOT_ACT_DISABLE_MCS14;
+			ht_info->iot_action |= HT_IOT_ACT_DISABLE_MCS14;
 
 		bIOTAction = HTIOTActIsDisableMCS15(ieee);
 		if (bIOTAction)
-			pHTInfo->iot_action |= HT_IOT_ACT_DISABLE_MCS15;
+			ht_info->iot_action |= HT_IOT_ACT_DISABLE_MCS15;
 
 		bIOTAction = HTIOTActIsDisableMCSTwoSpatialStream(ieee);
 		if (bIOTAction)
-			pHTInfo->iot_action |= HT_IOT_ACT_DISABLE_ALL_2SS;
+			ht_info->iot_action |= HT_IOT_ACT_DISABLE_ALL_2SS;
 
 		bIOTAction = HTIOTActIsDisableEDCATurbo(ieee, pNetwork->bssid);
 		if (bIOTAction)
-			pHTInfo->iot_action |= HT_IOT_ACT_DISABLE_EDCA_TURBO;
+			ht_info->iot_action |= HT_IOT_ACT_DISABLE_EDCA_TURBO;
 
 		bIOTAction = HTIOTActIsMgntUseCCK6M(ieee, pNetwork);
 		if (bIOTAction)
-			pHTInfo->iot_action |= HT_IOT_ACT_MGNT_USE_CCK_6M;
+			ht_info->iot_action |= HT_IOT_ACT_MGNT_USE_CCK_6M;
 		bIOTAction = HTIOTActIsCCDFsync(ieee);
 		if (bIOTAction)
-			pHTInfo->iot_action |= HT_IOT_ACT_CDD_FSYNC;
+			ht_info->iot_action |= HT_IOT_ACT_CDD_FSYNC;
 	} else {
-		pHTInfo->bCurrentHTSupport = false;
-		pHTInfo->current_rt2rt_aggregation = false;
-		pHTInfo->current_rt2rt_long_slot_time = false;
-		pHTInfo->RT2RT_HT_Mode = (enum rt_ht_capability)0;
+		ht_info->bCurrentHTSupport = false;
+		ht_info->current_rt2rt_aggregation = false;
+		ht_info->current_rt2rt_long_slot_time = false;
+		ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 
-		pHTInfo->iot_action = 0;
-		pHTInfo->iot_ra_func = 0;
+		ht_info->iot_action = 0;
+		ht_info->iot_ra_func = 0;
 	}
 }
 
 void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 				     struct rtllib_network *pNetwork)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct ht_info_ele *pPeerHTInfo =
 		 (struct ht_info_ele *)pNetwork->bssht.bd_ht_info_buf;
 
-	if (pHTInfo->bCurrentHTSupport) {
+	if (ht_info->bCurrentHTSupport) {
 		if (pNetwork->bssht.bd_ht_info_len != 0)
-			pHTInfo->current_op_mode = pPeerHTInfo->OptMode;
+			ht_info->current_op_mode = pPeerHTInfo->OptMode;
 	}
 }
 EXPORT_SYMBOL(HT_update_self_and_peer_setting);
 
 void HTUseDefaultSetting(struct rtllib_device *ieee)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	if (pHTInfo->enable_ht) {
-		pHTInfo->bCurrentHTSupport = true;
-		pHTInfo->bCurSuppCCK = pHTInfo->bRegSuppCCK;
+	if (ht_info->enable_ht) {
+		ht_info->bCurrentHTSupport = true;
+		ht_info->bCurSuppCCK = ht_info->bRegSuppCCK;
 
-		pHTInfo->bCurBW40MHz = pHTInfo->bRegBW40MHz;
-		pHTInfo->bCurShortGI20MHz = pHTInfo->bRegShortGI20MHz;
+		ht_info->bCurBW40MHz = ht_info->bRegBW40MHz;
+		ht_info->bCurShortGI20MHz = ht_info->bRegShortGI20MHz;
 
-		pHTInfo->bCurShortGI40MHz = pHTInfo->bRegShortGI40MHz;
+		ht_info->bCurShortGI40MHz = ht_info->bRegShortGI40MHz;
 
 		if (ieee->iw_mode == IW_MODE_ADHOC)
 			ieee->current_network.qos_data.active =
 				 ieee->current_network.qos_data.supported;
-		pHTInfo->bCurrent_AMSDU_Support = pHTInfo->bAMSDU_Support;
-		pHTInfo->nCurrent_AMSDU_MaxSize = pHTInfo->nAMSDU_MaxSize;
+		ht_info->bCurrent_AMSDU_Support = ht_info->bAMSDU_Support;
+		ht_info->nCurrent_AMSDU_MaxSize = ht_info->nAMSDU_MaxSize;
 
-		pHTInfo->bCurrentAMPDUEnable = pHTInfo->bAMPDUEnable;
-		pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
+		ht_info->bCurrentAMPDUEnable = ht_info->bAMPDUEnable;
+		ht_info->CurrentAMPDUFactor = ht_info->AMPDU_Factor;
 
-		pHTInfo->current_mpdu_density = pHTInfo->current_mpdu_density;
+		ht_info->current_mpdu_density = ht_info->current_mpdu_density;
 
 		HTFilterMCSRate(ieee, ieee->reg_dot11tx_ht_oper_rate_set,
 				ieee->dot11ht_oper_rate_set);
@@ -804,13 +804,13 @@ void HTUseDefaultSetting(struct rtllib_device *ieee)
 		ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
 
 	} else {
-		pHTInfo->bCurrentHTSupport = false;
+		ht_info->bCurrentHTSupport = false;
 	}
 }
 
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame)
 {
-	if (ieee->pHTInfo->bCurrentHTSupport) {
+	if (ieee->ht_info->bCurrentHTSupport) {
 		if ((IsQoSDataFrame(pFrame) && Frame_Order(pFrame)) == 1) {
 			netdev_dbg(ieee->dev, "HT CONTROL FILED EXIST!!\n");
 			return true;
@@ -821,13 +821,13 @@ u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame)
 
 static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	if (pHTInfo->bCurBW40MHz) {
-		if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
+	if (ht_info->bCurBW40MHz) {
+		if (ht_info->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel + 2);
-		else if (pHTInfo->CurSTAExtChnlOffset ==
+		else if (ht_info->CurSTAExtChnlOffset ==
 			 HT_EXTCHNL_OFFSET_LOWER)
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel - 2);
@@ -836,29 +836,29 @@ static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
 				       ieee->current_network.channel);
 
 		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20_40,
-				       pHTInfo->CurSTAExtChnlOffset);
+				       ht_info->CurSTAExtChnlOffset);
 	} else {
 		ieee->set_chan(ieee->dev, ieee->current_network.channel);
 		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20,
 				       HT_EXTCHNL_OFFSET_NO_EXT);
 	}
 
-	pHTInfo->sw_bw_in_progress = false;
+	ht_info->sw_bw_in_progress = false;
 }
 
 void HTSetConnectBwMode(struct rtllib_device *ieee,
 			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	if (!pHTInfo->bRegBW40MHz)
+	if (!ht_info->bRegBW40MHz)
 		return;
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		bandwidth = HT_CHANNEL_WIDTH_20;
 
-	if (pHTInfo->sw_bw_in_progress) {
+	if (ht_info->sw_bw_in_progress) {
 		pr_info("%s: sw_bw_in_progress!!\n", __func__);
 		return;
 	}
@@ -868,21 +868,21 @@ void HTSetConnectBwMode(struct rtllib_device *ieee,
 			Offset = HT_EXTCHNL_OFFSET_NO_EXT;
 		if (Offset == HT_EXTCHNL_OFFSET_UPPER ||
 		    Offset == HT_EXTCHNL_OFFSET_LOWER) {
-			pHTInfo->bCurBW40MHz = true;
-			pHTInfo->CurSTAExtChnlOffset = Offset;
+			ht_info->bCurBW40MHz = true;
+			ht_info->CurSTAExtChnlOffset = Offset;
 		} else {
-			pHTInfo->bCurBW40MHz = false;
-			pHTInfo->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
+			ht_info->bCurBW40MHz = false;
+			ht_info->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
 		}
 	} else {
-		pHTInfo->bCurBW40MHz = false;
-		pHTInfo->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
+		ht_info->bCurBW40MHz = false;
+		ht_info->CurSTAExtChnlOffset = HT_EXTCHNL_OFFSET_NO_EXT;
 	}
 
-	netdev_dbg(ieee->dev, "%s():pHTInfo->bCurBW40MHz:%x\n", __func__,
-		   pHTInfo->bCurBW40MHz);
+	netdev_dbg(ieee->dev, "%s():ht_info->bCurBW40MHz:%x\n", __func__,
+		   ht_info->bCurBW40MHz);
 
-	pHTInfo->sw_bw_in_progress = true;
+	ht_info->sw_bw_in_progress = true;
 
 	HTSetConnectBwModeCallback(ieee);
 }
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 05c7e822f372..68c131afc2ba 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -83,7 +83,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	if (bPktInBuf && (pRxTs->rx_timeout_indicate_seq == 0xffff)) {
 		pRxTs->rx_timeout_indicate_seq = pRxTs->rx_indicate_seq;
 		mod_timer(&pRxTs->rx_pkt_pending_timer,  jiffies +
-			  msecs_to_jiffies(ieee->pHTInfo->rx_reorder_pending_time)
+			  msecs_to_jiffies(ieee->ht_info->rx_reorder_pending_time)
 			  );
 	}
 	spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 9c81ca38f4b1..7119c9c5e1fe 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1432,7 +1432,7 @@ struct rtllib_device {
 	RT_RF_CHANGE_SOURCE rf_off_reason;
 	bool is_set_key;
 	bool wx_set_enc;
-	struct rt_hi_throughput *pHTInfo;
+	struct rt_hi_throughput *ht_info;
 
 	spinlock_t reorder_spinlock;
 	u8	reg_dot11ht_oper_rate_set[16];
@@ -2089,7 +2089,7 @@ u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
-void HTResetIOTSetting(struct rt_hi_throughput *pHTInfo);
+void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
 bool IsHTHalfNmodeAPs(struct rtllib_device *ieee);
 u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate);
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index ce8b73f437a3..d6a4d6b4ec57 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -125,8 +125,8 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 	if (err)
 		goto free_crypt_info;
 
-	ieee->pHTInfo = kzalloc(sizeof(struct rt_hi_throughput), GFP_KERNEL);
-	if (!ieee->pHTInfo)
+	ieee->ht_info = kzalloc(sizeof(struct rt_hi_throughput), GFP_KERNEL);
+	if (!ieee->ht_info)
 		goto free_softmac;
 
 	HTUpdateDefaultSetting(ieee);
@@ -160,7 +160,7 @@ void free_rtllib(struct net_device *dev)
 	struct rtllib_device *ieee = (struct rtllib_device *)
 				      netdev_priv_rsl(dev);
 
-	kfree(ieee->pHTInfo);
+	kfree(ieee->ht_info);
 	rtllib_softmac_free(ieee);
 
 	lib80211_crypt_info_free(&ieee->crypt_info);
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 75190c389ccf..6a0f5bbb99ef 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -567,9 +567,9 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 				    struct rtllib_rxb *prxb,
 				    struct rx_ts_record *pTS, u16 SeqNum)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct rx_reorder_entry *pReorderEntry = NULL;
-	u8 WinSize = pHTInfo->rx_reorder_win_size;
+	u8 WinSize = ht_info->rx_reorder_win_size;
 	u16 WinEnd = 0;
 	u8 index = 0;
 	bool bMatchWinStart = false, bPktInBuf = false;
@@ -591,7 +591,7 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 		netdev_dbg(ieee->dev,
 			   "Packet Drop! IndicateSeq: %d, NewSeq: %d\n",
 			   pTS->rx_indicate_seq, SeqNum);
-		pHTInfo->rx_reorder_drop_counter++;
+		ht_info->rx_reorder_drop_counter++;
 		{
 			int i;
 
@@ -755,7 +755,7 @@ static void RxReorderIndicatePacket(struct rtllib_device *ieee,
 		netdev_dbg(ieee->dev, "%s(): SET rx timeout timer\n", __func__);
 		pTS->rx_timeout_indicate_seq = pTS->rx_indicate_seq;
 		mod_timer(&pTS->rx_pkt_pending_timer, jiffies +
-			  msecs_to_jiffies(pHTInfo->rx_reorder_pending_time));
+			  msecs_to_jiffies(ht_info->rx_reorder_pending_time));
 	}
 	spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
 }
@@ -924,7 +924,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
 	sc = le16_to_cpu(hdr->seq_ctl);
 	frag = WLAN_GET_SEQ_FRAG(sc);
 
-	if (!ieee->pHTInfo->cur_rx_reorder_enable ||
+	if (!ieee->ht_info->cur_rx_reorder_enable ||
 		!ieee->current_network.qos_data.active ||
 		!IsDataFrame(skb->data) ||
 		IsLegacyDataFrame(skb->data)) {
@@ -1442,7 +1442,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	}
 
 	/* Indicate packets to upper layer or Rx Reorder */
-	if (!ieee->pHTInfo->cur_rx_reorder_enable || pTS == NULL || bToOtherSTA)
+	if (!ieee->ht_info->cur_rx_reorder_enable || pTS == NULL || bToOtherSTA)
 		rtllib_rx_indicate_pkt_legacy(ieee, rx_stats, rxb, dst, src);
 	else
 		RxReorderIndicatePacket(ieee, rxb, pTS, SeqNum);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 8b1d88061125..2552aa089700 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -176,10 +176,10 @@ u8 MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee)
 
 static u8 MgntQuery_MgntFrameTxRate(struct rtllib_device *ieee)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	u8 rate;
 
-	if (pHTInfo->iot_action & HT_IOT_ACT_MGNT_USE_CCK_6M)
+	if (ht_info->iot_action & HT_IOT_ACT_MGNT_USE_CCK_6M)
 		rate = 0x0c;
 	else
 		rate = ieee->basic_rate & 0x7f;
@@ -187,7 +187,7 @@ static u8 MgntQuery_MgntFrameTxRate(struct rtllib_device *ieee)
 	if (rate == 0) {
 		if (ieee->mode == IEEE_A ||
 		   ieee->mode == IEEE_N_5G ||
-		   (ieee->mode == IEEE_N_24G && !pHTInfo->bCurSuppCCK))
+		   (ieee->mode == IEEE_N_24G && !ht_info->bCurSuppCCK))
 			rate = 0x0c;
 		else
 			rate = 0x02;
@@ -829,7 +829,7 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	u8 tmp_ht_cap_len = 0;
 	u8 *tmp_ht_info_buf = NULL;
 	u8 tmp_ht_info_len = 0;
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	u8 *tmp_generic_ie_buf = NULL;
 	u8 tmp_generic_ie_len = 0;
 
@@ -843,7 +843,7 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 
 	if ((ieee->current_network.mode == IEEE_G) ||
 	   (ieee->current_network.mode == IEEE_N_24G &&
-	   ieee->pHTInfo->bCurSuppCCK)) {
+	   ieee->ht_info->bCurSuppCCK)) {
 		erp_len = 3;
 		erpinfo_content = 0;
 		if (ieee->current_network.buseprotection)
@@ -854,20 +854,20 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
 	encrypt = ieee->host_encrypt && crypt && crypt->ops &&
 		((strcmp(crypt->ops->name, "R-WEP") == 0 || wpa_ie_len));
-	if (ieee->pHTInfo->bCurrentHTSupport) {
-		tmp_ht_cap_buf = (u8 *)&(ieee->pHTInfo->SelfHTCap);
-		tmp_ht_cap_len = sizeof(ieee->pHTInfo->SelfHTCap);
-		tmp_ht_info_buf = (u8 *)&(ieee->pHTInfo->SelfHTInfo);
-		tmp_ht_info_len = sizeof(ieee->pHTInfo->SelfHTInfo);
+	if (ieee->ht_info->bCurrentHTSupport) {
+		tmp_ht_cap_buf = (u8 *)&(ieee->ht_info->SelfHTCap);
+		tmp_ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
+		tmp_ht_info_buf = (u8 *)&(ieee->ht_info->SelfHTInfo);
+		tmp_ht_info_len = sizeof(ieee->ht_info->SelfHTInfo);
 		HTConstructCapabilityElement(ieee, tmp_ht_cap_buf,
 					     &tmp_ht_cap_len, encrypt, false);
 		HTConstructInfoElement(ieee, tmp_ht_info_buf, &tmp_ht_info_len,
 				       encrypt);
 
-		if (pHTInfo->reg_rt2rt_aggregation) {
-			tmp_generic_ie_buf = ieee->pHTInfo->sz_rt2rt_agg_buf;
+		if (ht_info->reg_rt2rt_aggregation) {
+			tmp_generic_ie_buf = ieee->ht_info->sz_rt2rt_agg_buf;
 			tmp_generic_ie_len =
-				 sizeof(ieee->pHTInfo->sz_rt2rt_agg_buf);
+				 sizeof(ieee->ht_info->sz_rt2rt_agg_buf);
 			HTConstructRT2RTAggElement(ieee, tmp_generic_ie_buf,
 						   &tmp_generic_ie_len);
 		}
@@ -1179,19 +1179,19 @@ rtllib_association_req(struct rtllib_network *beacon,
 	if ((ieee->rtllib_ap_sec_type &&
 	    (ieee->rtllib_ap_sec_type(ieee) & SEC_ALG_TKIP)) ||
 	    ieee->bForcedBgMode) {
-		ieee->pHTInfo->enable_ht = 0;
+		ieee->ht_info->enable_ht = 0;
 		ieee->mode = WIRELESS_MODE_G;
 	}
 
-	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->enable_ht) {
-		ht_cap_buf = (u8 *)&(ieee->pHTInfo->SelfHTCap);
-		ht_cap_len = sizeof(ieee->pHTInfo->SelfHTCap);
+	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
+		ht_cap_buf = (u8 *)&(ieee->ht_info->SelfHTCap);
+		ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
 		HTConstructCapabilityElement(ieee, ht_cap_buf, &ht_cap_len,
 					     encrypt, true);
-		if (ieee->pHTInfo->current_rt2rt_aggregation) {
-			realtek_ie_buf = ieee->pHTInfo->sz_rt2rt_agg_buf;
+		if (ieee->ht_info->current_rt2rt_aggregation) {
+			realtek_ie_buf = ieee->ht_info->sz_rt2rt_agg_buf;
 			realtek_ie_len =
-				 sizeof(ieee->pHTInfo->sz_rt2rt_agg_buf);
+				 sizeof(ieee->ht_info->sz_rt2rt_agg_buf);
 			HTConstructRT2RTAggElement(ieee, realtek_ie_buf,
 						   &realtek_ie_len);
 		}
@@ -1324,8 +1324,8 @@ rtllib_association_req(struct rtllib_network *beacon,
 		memcpy(tag, osCcxVerNum.Octet, osCcxVerNum.Length);
 		tag += osCcxVerNum.Length;
 	}
-	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->enable_ht) {
-		if (ieee->pHTInfo->ePeerHTSpecVer != HT_SPEC_VER_EWC) {
+	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
+		if (ieee->ht_info->ePeerHTSpecVer != HT_SPEC_VER_EWC) {
 			tag = skb_put(skb, ht_cap_len);
 			*tag++ = MFIE_TYPE_HT_CAP;
 			*tag++ = ht_cap_len - 2;
@@ -1358,8 +1358,8 @@ rtllib_association_req(struct rtllib_network *beacon,
 		rtllib_TURBO_Info(ieee, &tag);
 	}
 
-	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->enable_ht) {
-		if (ieee->pHTInfo->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
+	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
+		if (ieee->ht_info->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
 			tag = skb_put(skb, ht_cap_len);
 			*tag++ = MFIE_TYPE_GENERIC;
 			*tag++ = ht_cap_len - 2;
@@ -1367,7 +1367,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 			tag += ht_cap_len - 2;
 		}
 
-		if (ieee->pHTInfo->current_rt2rt_aggregation) {
+		if (ieee->ht_info->current_rt2rt_aggregation) {
 			tag = skb_put(skb, realtek_ie_len);
 			*tag++ = MFIE_TYPE_GENERIC;
 			*tag++ = realtek_ie_len - 2;
@@ -1524,14 +1524,14 @@ static void rtllib_associate_complete_wq(void *data)
 		ieee->SetWirelessMode(ieee->dev, IEEE_B);
 		netdev_info(ieee->dev, "Using B rates:%d\n", ieee->rate);
 	}
-	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->enable_ht) {
+	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht) {
 		netdev_info(ieee->dev, "Successfully associated, ht enabled\n");
 		HTOnAssocRsp(ieee);
 	} else {
 		netdev_info(ieee->dev,
 			    "Successfully associated, ht not enabled(%d, %d)\n",
-			    ieee->pHTInfo->bCurrentHTSupport,
-			    ieee->pHTInfo->enable_ht);
+			    ieee->ht_info->bCurrentHTSupport,
+			    ieee->ht_info->enable_ht);
 		memset(ieee->dot11ht_oper_rate_set, 0, 16);
 	}
 	ieee->link_detect_info.SlotNum = 2 * (1 +
@@ -1684,7 +1684,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				    ieee->current_network.ssid,
 				    ieee->current_network.channel,
 				    ieee->current_network.qos_data.supported,
-				    ieee->pHTInfo->enable_ht,
+				    ieee->ht_info->enable_ht,
 				    ieee->current_network.bssht.bd_support_ht,
 				    ieee->current_network.mode,
 				    ieee->current_network.flags);
@@ -1693,7 +1693,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 			   !(ieee->softmac_features & IEEE_SOFTMAC_SCAN))
 				rtllib_stop_scan_syncro(ieee);
 
-			HTResetIOTSetting(ieee->pHTInfo);
+			HTResetIOTSetting(ieee->ht_info);
 			ieee->wmm_acm = 0;
 			if (ieee->iw_mode == IW_MODE_INFRA) {
 				/* Join the network for the first time */
@@ -1703,7 +1703,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 					HTResetSelfAndSavePeerSetting(ieee,
 						 &(ieee->current_network));
 				else
-					ieee->pHTInfo->bCurrentHTSupport =
+					ieee->ht_info->bCurrentHTSupport =
 								 false;
 
 				ieee->state = RTLLIB_ASSOCIATING;
@@ -1893,7 +1893,7 @@ static inline u16 assoc_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 	   ((ieee->mode == IEEE_G) &&
 	   (ieee->current_network.mode == IEEE_N_24G) &&
 	   (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT-1)))) {
-		ieee->pHTInfo->iot_action |= HT_IOT_ACT_PURE_N_MODE;
+		ieee->ht_info->iot_action |= HT_IOT_ACT_PURE_N_MODE;
 	} else {
 		ieee->AsocRetryCount = 0;
 	}
@@ -2100,7 +2100,7 @@ static void rtllib_sta_wakeup(struct rtllib_device *ieee, short nl)
 {
 	if (ieee->sta_sleep == LPS_IS_WAKE) {
 		if (nl) {
-			if (ieee->pHTInfo->iot_action &
+			if (ieee->ht_info->iot_action &
 			    HT_IOT_ACT_NULL_DATA_POWER_SAVING) {
 				ieee->ack_tx_to_ieee = 1;
 				rtllib_sta_ps_send_null_frame(ieee, 0);
@@ -2116,7 +2116,7 @@ static void rtllib_sta_wakeup(struct rtllib_device *ieee, short nl)
 	if (ieee->sta_sleep == LPS_IS_SLEEP)
 		ieee->sta_wake_up(ieee->dev);
 	if (nl) {
-		if (ieee->pHTInfo->iot_action &
+		if (ieee->ht_info->iot_action &
 		    HT_IOT_ACT_NULL_DATA_POWER_SAVING) {
 			ieee->ack_tx_to_ieee = 1;
 			rtllib_sta_ps_send_null_frame(ieee, 0);
@@ -2151,7 +2151,7 @@ void rtllib_ps_tx_ack(struct rtllib_device *ieee, short success)
 
 		if ((ieee->sta_sleep == LPS_IS_WAKE) && !success) {
 			spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
-			if (ieee->pHTInfo->iot_action &
+			if (ieee->ht_info->iot_action &
 			    HT_IOT_ACT_NULL_DATA_POWER_SAVING)
 				rtllib_sta_ps_send_null_frame(ieee, 0);
 			else
@@ -2235,10 +2235,10 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 					kfree(network);
 					return 1;
 				}
-				memcpy(ieee->pHTInfo->PeerHTCapBuf,
+				memcpy(ieee->ht_info->PeerHTCapBuf,
 				       network->bssht.bd_ht_cap_buf,
 				       network->bssht.bd_ht_cap_len);
-				memcpy(ieee->pHTInfo->PeerHTInfoBuf,
+				memcpy(ieee->ht_info->PeerHTInfoBuf,
 				       network->bssht.bd_ht_info_buf,
 				       network->bssht.bd_ht_info_len);
 				if (ieee->handle_assoc_response != NULL)
@@ -2295,7 +2295,7 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 	if (ieee->open_wep || !challenge) {
 		ieee->state = RTLLIB_ASSOCIATING_AUTHENTICATED;
 		ieee->softmac_stats.rx_auth_rs_ok++;
-		if (!(ieee->pHTInfo->iot_action & HT_IOT_ACT_PURE_N_MODE)) {
+		if (!(ieee->ht_info->iot_action & HT_IOT_ACT_PURE_N_MODE)) {
 			if (!ieee->GetNmodeSupportBySecCfg(ieee->dev)) {
 				if (IsHTHalfNmodeAPs(ieee)) {
 					bSupportNmode = true;
@@ -2669,7 +2669,7 @@ static void rtllib_start_ibss_wq(void *data)
 	if ((ieee->mode == IEEE_N_24G) || (ieee->mode == IEEE_N_5G))
 		HTUseDefaultSetting(ieee);
 	else
-		ieee->pHTInfo->bCurrentHTSupport = false;
+		ieee->ht_info->bCurrentHTSupport = false;
 
 	ieee->SetHwRegHandler(ieee->dev, HW_VAR_MEDIA_STATUS,
 			      (u8 *)(&ieee->state));
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index e02e7d9566b2..63edf68c0b49 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -359,11 +359,11 @@ void rtllib_wx_sync_scan_wq(void *data)
 	if (ieee->ScanOperationBackupHandler)
 		ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_BACKUP);
 
-	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->enable_ht &&
-	    ieee->pHTInfo->bCurBW40MHz) {
+	if (ieee->ht_info->bCurrentHTSupport && ieee->ht_info->enable_ht &&
+	    ieee->ht_info->bCurBW40MHz) {
 		b40M = 1;
-		chan_offset = ieee->pHTInfo->CurSTAExtChnlOffset;
-		bandwidth = (enum ht_channel_width)ieee->pHTInfo->bCurBW40MHz;
+		chan_offset = ieee->ht_info->CurSTAExtChnlOffset;
+		bandwidth = (enum ht_channel_width)ieee->ht_info->bCurBW40MHz;
 		ieee->SetBWModeHandler(ieee->dev, HT_CHANNEL_WIDTH_20,
 				       HT_EXTCHNL_OFFSET_NO_EXT);
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 8b01cfe03381..9ab8ee46ef66 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -266,14 +266,14 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 				    struct sk_buff *skb,
 				    struct cb_desc *tcb_desc)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct tx_ts_record *pTxTs = NULL;
 	struct rtllib_hdr_1addr *hdr = (struct rtllib_hdr_1addr *)skb->data;
 
 	if (rtllib_act_scanning(ieee, false))
 		return;
 
-	if (!pHTInfo->bCurrentHTSupport || !pHTInfo->enable_ht)
+	if (!ht_info->bCurrentHTSupport || !ht_info->enable_ht)
 		return;
 	if (!IsQoSDataFrame(skb->data))
 		return;
@@ -283,12 +283,12 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 	if (tcb_desc->bdhcp || ieee->CntAfterLink < 2)
 		return;
 
-	if (pHTInfo->iot_action & HT_IOT_ACT_TX_NO_AGGREGATION)
+	if (ht_info->iot_action & HT_IOT_ACT_TX_NO_AGGREGATION)
 		return;
 
 	if (!ieee->GetNmodeSupportBySecCfg(ieee->dev))
 		return;
-	if (pHTInfo->bCurrentAMPDUEnable) {
+	if (ht_info->bCurrentAMPDUEnable) {
 		if (!GetTs(ieee, (struct ts_common_info **)(&pTxTs), hdr->addr1,
 			   skb->priority, TX_DIR, true)) {
 			netdev_info(ieee->dev, "%s: can't get TS\n", __func__);
@@ -313,19 +313,19 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
 		}
 		if (ieee->iw_mode == IW_MODE_INFRA) {
 			tcb_desc->bAMPDUEnable = true;
-			tcb_desc->ampdu_factor = pHTInfo->CurrentAMPDUFactor;
-			tcb_desc->ampdu_density = pHTInfo->current_mpdu_density;
+			tcb_desc->ampdu_factor = ht_info->CurrentAMPDUFactor;
+			tcb_desc->ampdu_density = ht_info->current_mpdu_density;
 		}
 	}
 FORCED_AGG_SETTING:
-	switch (pHTInfo->ForcedAMPDUMode) {
+	switch (ht_info->ForcedAMPDUMode) {
 	case HT_AGG_AUTO:
 		break;
 
 	case HT_AGG_FORCE_ENABLE:
 		tcb_desc->bAMPDUEnable = true;
-		tcb_desc->ampdu_density = pHTInfo->forced_mpdu_density;
-		tcb_desc->ampdu_factor = pHTInfo->forced_ampdu_factor;
+		tcb_desc->ampdu_density = ht_info->forced_mpdu_density;
+		tcb_desc->ampdu_factor = ht_info->forced_ampdu_factor;
 		break;
 
 	case HT_AGG_FORCE_DISABLE:
@@ -350,32 +350,32 @@ static void rtllib_query_ShortPreambleMode(struct rtllib_device *ieee,
 static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
 				      struct cb_desc *tcb_desc)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
 	tcb_desc->bUseShortGI		= false;
 
-	if (!pHTInfo->bCurrentHTSupport || !pHTInfo->enable_ht)
+	if (!ht_info->bCurrentHTSupport || !ht_info->enable_ht)
 		return;
 
-	if (pHTInfo->forced_short_gi) {
+	if (ht_info->forced_short_gi) {
 		tcb_desc->bUseShortGI = true;
 		return;
 	}
 
-	if (pHTInfo->bCurBW40MHz && pHTInfo->bCurShortGI40MHz)
+	if (ht_info->bCurBW40MHz && ht_info->bCurShortGI40MHz)
 		tcb_desc->bUseShortGI = true;
-	else if (!pHTInfo->bCurBW40MHz && pHTInfo->bCurShortGI20MHz)
+	else if (!ht_info->bCurBW40MHz && ht_info->bCurShortGI20MHz)
 		tcb_desc->bUseShortGI = true;
 }
 
 static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
 				       struct cb_desc *tcb_desc)
 {
-	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
+	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
 	tcb_desc->bPacketBW = false;
 
-	if (!pHTInfo->bCurrentHTSupport || !pHTInfo->enable_ht)
+	if (!ht_info->bCurrentHTSupport || !ht_info->enable_ht)
 		return;
 
 	if (tcb_desc->bMulticast || tcb_desc->bBroadcast)
@@ -383,7 +383,7 @@ static void rtllib_query_BandwidthMode(struct rtllib_device *ieee,
 
 	if ((tcb_desc->data_rate & 0x80) == 0)
 		return;
-	if (pHTInfo->bCurBW40MHz && pHTInfo->cur_tx_bw40mhz &&
+	if (ht_info->bCurBW40MHz && ht_info->cur_tx_bw40mhz &&
 	    !ieee->bandwidth_auto_switch.bforced_tx20Mhz)
 		tcb_desc->bPacketBW = true;
 }
@@ -392,7 +392,7 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 					struct cb_desc *tcb_desc,
 					struct sk_buff *skb)
 {
-	struct rt_hi_throughput *pHTInfo;
+	struct rt_hi_throughput *ht_info;
 
 	tcb_desc->bRTSSTBC			= false;
 	tcb_desc->bRTSUseShortGI		= false;
@@ -418,15 +418,15 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 		return;
 	}
 
-	pHTInfo = ieee->pHTInfo;
+	ht_info = ieee->ht_info;
 
 	while (true) {
-		if (pHTInfo->iot_action & HT_IOT_ACT_FORCED_CTS2SELF) {
+		if (ht_info->iot_action & HT_IOT_ACT_FORCED_CTS2SELF) {
 			tcb_desc->bCTSEnable	= true;
 			tcb_desc->rts_rate  =	MGN_24M;
 			tcb_desc->bRTSEnable = true;
 			break;
-		} else if (pHTInfo->iot_action & (HT_IOT_ACT_FORCED_RTS |
+		} else if (ht_info->iot_action & (HT_IOT_ACT_FORCED_RTS |
 			   HT_IOT_ACT_PURE_N_MODE)) {
 			tcb_desc->bRTSEnable = true;
 			tcb_desc->rts_rate  =	MGN_24M;
@@ -438,12 +438,12 @@ static void rtllib_query_protectionmode(struct rtllib_device *ieee,
 			tcb_desc->rts_rate = MGN_24M;
 			break;
 		}
-		if (pHTInfo->bCurrentHTSupport  && pHTInfo->enable_ht) {
-			u8 HTOpMode = pHTInfo->current_op_mode;
+		if (ht_info->bCurrentHTSupport  && ht_info->enable_ht) {
+			u8 HTOpMode = ht_info->current_op_mode;
 
-			if ((pHTInfo->bCurBW40MHz && (HTOpMode == 2 ||
+			if ((ht_info->bCurBW40MHz && (HTOpMode == 2 ||
 						      HTOpMode == 3)) ||
-			     (!pHTInfo->bCurBW40MHz && HTOpMode == 3)) {
+			     (!ht_info->bCurBW40MHz && HTOpMode == 3)) {
 				tcb_desc->rts_rate = MGN_24M;
 				tcb_desc->bRTSEnable = true;
 				break;
@@ -882,7 +882,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 		tcb_desc->priority = skb->priority;
 
 		if (ether_type == ETH_P_PAE) {
-			if (ieee->pHTInfo->iot_action &
+			if (ieee->ht_info->iot_action &
 			    HT_IOT_ACT_WA_IOT_Broadcom) {
 				tcb_desc->data_rate =
 					 MgntQuery_TxRateExcludeCCKRates(ieee);
@@ -906,7 +906,7 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				tcb_desc->data_rate = rtllib_current_rate(ieee);
 
 			if (bdhcp) {
-				if (ieee->pHTInfo->iot_action &
+				if (ieee->ht_info->iot_action &
 				    HT_IOT_ACT_WA_IOT_Broadcom) {
 					tcb_desc->data_rate =
 					   MgntQuery_TxRateExcludeCCKRates(ieee);
-- 
2.37.3

