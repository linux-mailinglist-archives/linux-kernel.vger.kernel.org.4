Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B7626DB6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 05:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiKMEhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 23:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiKMEg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 23:36:28 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2133213FB7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:36:06 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id y16so11599523wrt.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0CokBU8cM6zI23zkNc1rZIn7Gnc44VkzGzRrbVO49/Q=;
        b=U3y1e8ofpG+p/2Fof4nkCA84Kmk8Txxo7ss37NzUscGzy4tDhsZyTkITx17JbkDMp1
         rQyupLV99RKeSq/2ZE3PkQExgHDp9/qpAe9C7sdAbzT3ANamC0HSC/GQZ4VdRvCYS/PT
         uerTCxNlq7yDCs8pNjqQufxP4r/igz6lPACweEJGkfcXgcF3Rhly9pCWUIgyocRAO4ih
         wNzIyzY5YTeCJ136iEbXYVXBzYaXV3jWJaD6bAmNYBiWfu2o4VzUQzfNElxHnol7hYF+
         YMwxidL/tdZu9+PhciPz9WO4btuWvHxlF7VQ2WV/526AhivUwLNTfGAWEy5DmqeYOxzX
         jAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CokBU8cM6zI23zkNc1rZIn7Gnc44VkzGzRrbVO49/Q=;
        b=6EWbaALRZexX+OHJOkKlCgzVgCBbM7hyp+foF14X7063in3POWI5DtSP+e3UpqOnHC
         t12WIgy83SU11MmcpyQIIW9y+fslAvd2J/zdF+xOBOZm0p8FAiWQhNy8t+IV0pL2Z/n4
         3U3hafzu54qntaQYkTktkRbNnA0o/R5g2vdxFPckA0K+B9hRJ5muXA1siWeUA4OjC2PF
         L/17mCYgDZF2jRA4b122UjcQuWrQXnvXMnYJqIiH6+AhNjHyrRa2BE+nnLApgXw8IG5C
         7WapVQZSsz/titUlEUV/BHa/I+bbU/l1cuVw24DZZOywuj//2L8NbdwT+QDPnyj2yt+G
         UAhQ==
X-Gm-Message-State: ANoB5pm8qS5Jzy5t17IiPvFPLQzi69WK/yfDtjm2hGGXvwBPoOY02Yef
        PJTf0vOXeCJ+wBtUVc2ImFzC/l4E4yo=
X-Google-Smtp-Source: AA0mqf7Wb6/YTEZwuift2xUZSLB3DsxioGINWXNBzLhaF8M5t4rnJEimZSpREiOz3EwHfOXuu+LXng==
X-Received: by 2002:adf:efc3:0:b0:23a:2311:b35 with SMTP id i3-20020adfefc3000000b0023a23110b35mr4395814wrp.183.1668314164584;
        Sat, 12 Nov 2022 20:36:04 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b003c6d21a19a0sm9121807wms.29.2022.11.12.20.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:36:04 -0800 (PST)
Date:   Sun, 13 Nov 2022 05:36:02 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] staging: rtl8192e: Rename bFilterSour..,
 CCKPresentAt.. and ResetProg..
Message-ID: <25ab52350a4a3249a1f76b28eea10c44e2f9552d.1668313325.git.philipp.g.hortmann@gmail.com>
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

Rename variable bFilterSourceStationFrame to fltr_src_sta_frame,
CCKPresentAttentuation to cck_present_attn and ResetProgress to
rst_progress to avoid CamelCase which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 12 +++++------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 20 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 14 ++++++-------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 20 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    | 12 +++++------
 drivers/staging/rtl8192e/rtllib.h             |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c          |  2 +-
 8 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 2ccd1e0542c2..0eeb9b2daefc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -617,7 +617,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 start:
 	rtl92e_reset_desc_ring(dev);
 	priv->Rf_Mode = RF_OP_By_SW_3wire;
-	if (priv->ResetProgress == RESET_TYPE_NORESET) {
+	if (priv->rst_progress == RESET_TYPE_NORESET) {
 		rtl92e_writeb(dev, ANAPAR, 0x37);
 		mdelay(500);
 	}
@@ -650,7 +650,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	}
 
 	priv->LoopbackMode = RTL819X_NO_LOOPBACK;
-	if (priv->ResetProgress == RESET_TYPE_NORESET) {
+	if (priv->rst_progress == RESET_TYPE_NORESET) {
 		ulRegRead = rtl92e_readl(dev, CPU_GEN);
 		if (priv->LoopbackMode == RTL819X_NO_LOOPBACK)
 			ulRegRead = (ulRegRead & CPU_GEN_NO_LOOPBACK_MSK) |
@@ -699,7 +699,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 
 	rtl92e_writeb(dev, ACK_TIMEOUT, 0x30);
 
-	if (priv->ResetProgress == RESET_TYPE_NORESET)
+	if (priv->rst_progress == RESET_TYPE_NORESET)
 		rtl92e_set_wireless_mode(dev, priv->rtllib->mode);
 	rtl92e_cam_reset(dev);
 	{
@@ -739,7 +739,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 		}
 	}
 
-	if (priv->ResetProgress == RESET_TYPE_NORESET) {
+	if (priv->rst_progress == RESET_TYPE_NORESET) {
 		rtStatus = rtl92e_config_phy(dev);
 		if (!rtStatus) {
 			netdev_info(dev, "RF Config failed\n");
@@ -766,7 +766,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	else
 		priv->Rf_Mode = RF_OP_By_SW_3wire;
 
-	if (priv->ResetProgress == RESET_TYPE_NORESET) {
+	if (priv->rst_progress == RESET_TYPE_NORESET) {
 		rtl92e_dm_init_txpower_tracking(dev);
 
 		if (priv->IC_Cut >= IC_VersionCut_D) {
@@ -795,7 +795,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 			}
 			priv->CCKPresentAttentuation_40Mdefault = 0;
 			priv->CCKPresentAttentuation_difference = 0;
-			priv->CCKPresentAttentuation =
+			priv->cck_present_attn =
 				  priv->CCKPresentAttentuation_20Mdefault;
 			priv->btxpower_tracking = false;
 		}
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index c357adf95a3d..ac3c7f047ca2 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1008,16 +1008,16 @@ static void _rtl92e_cck_tx_power_track_bw_switch_tssi(struct net_device *dev)
 
 	switch (priv->CurrentChannelBW) {
 	case HT_CHANNEL_WIDTH_20:
-		priv->CCKPresentAttentuation =
+		priv->cck_present_attn =
 			priv->CCKPresentAttentuation_20Mdefault +
 			    priv->CCKPresentAttentuation_difference;
 
-		if (priv->CCKPresentAttentuation >
+		if (priv->cck_present_attn >
 		    (CCKTxBBGainTableLength-1))
-			priv->CCKPresentAttentuation =
+			priv->cck_present_attn =
 					 CCKTxBBGainTableLength-1;
-		if (priv->CCKPresentAttentuation < 0)
-			priv->CCKPresentAttentuation = 0;
+		if (priv->cck_present_attn < 0)
+			priv->cck_present_attn = 0;
 
 		if (priv->rtllib->current_network.channel == 14 &&
 		    !priv->bcck_in_ch14) {
@@ -1033,16 +1033,16 @@ static void _rtl92e_cck_tx_power_track_bw_switch_tssi(struct net_device *dev)
 		break;
 
 	case HT_CHANNEL_WIDTH_20_40:
-		priv->CCKPresentAttentuation =
+		priv->cck_present_attn =
 			priv->CCKPresentAttentuation_40Mdefault +
 			priv->CCKPresentAttentuation_difference;
 
-		if (priv->CCKPresentAttentuation >
+		if (priv->cck_present_attn >
 		    (CCKTxBBGainTableLength - 1))
-			priv->CCKPresentAttentuation =
+			priv->cck_present_attn =
 					 CCKTxBBGainTableLength-1;
-		if (priv->CCKPresentAttentuation < 0)
-			priv->CCKPresentAttentuation = 0;
+		if (priv->cck_present_attn < 0)
+			priv->cck_present_attn = 0;
 
 		if (priv->rtllib->current_network.channel == 14 &&
 		    !priv->bcck_in_ch14) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 94b8ed2e3489..1c4985dcc5eb 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -850,7 +850,7 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rtllib->iw_mode = IW_MODE_INFRA;
 	priv->rtllib->net_promiscuous_md = false;
 	priv->rtllib->intel_promiscuous_md_info.promiscuous_on = false;
-	priv->rtllib->intel_promiscuous_md_info.bFilterSourceStationFrame =
+	priv->rtllib->intel_promiscuous_md_info.fltr_src_sta_frame =
 								 false;
 	priv->rtllib->ieee_up = 0;
 	priv->retry_rts = DEFAULT_RETRY_RTS;
@@ -861,11 +861,11 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->promisc = (dev->flags & IFF_PROMISC) ? 1 : 0;
 	priv->bcck_in_ch14 = false;
 	priv->bfsync_processing  = false;
-	priv->CCKPresentAttentuation = 0;
+	priv->cck_present_attn = 0;
 	priv->rfa_txpowertrackingindex = 0;
 	priv->rfc_txpowertrackingindex = 0;
 	priv->CckPwEnl = 6;
-	priv->ResetProgress = RESET_TYPE_NORESET;
+	priv->rst_progress = RESET_TYPE_NORESET;
 	priv->force_reset = false;
 	memset(priv->rtllib->swcamtable, 0, sizeof(struct sw_cam_table) * 32);
 
@@ -1135,8 +1135,8 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 	struct rtllib_device *ieee = priv->rtllib;
 	unsigned long flag;
 
-	if (priv->ResetProgress == RESET_TYPE_NORESET) {
-		priv->ResetProgress = RESET_TYPE_SILENT;
+	if (priv->rst_progress == RESET_TYPE_NORESET) {
+		priv->rst_progress = RESET_TYPE_SILENT;
 
 		spin_lock_irqsave(&priv->rf_ps_lock, flag);
 		if (priv->rf_change_in_progress) {
@@ -1233,7 +1233,7 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 		rtl92e_cam_restore(dev);
 		rtl92e_dm_restore_state(dev);
 END:
-		priv->ResetProgress = RESET_TYPE_NORESET;
+		priv->rst_progress = RESET_TYPE_NORESET;
 		priv->reset_count++;
 		priv->bResetInProgress = false;
 
@@ -1396,7 +1396,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	spin_unlock_irqrestore(&priv->tx_lock, flags);
 
 	if (ResetType == RESET_TYPE_NORMAL) {
-		priv->ResetProgress = RESET_TYPE_NORMAL;
+		priv->rst_progress = RESET_TYPE_NORMAL;
 		return;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 98c750730f87..dfbc9fbcc129 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -483,7 +483,7 @@ struct r8192_priv {
 	u8 CCKPresentAttentuation_20Mdefault;
 	u8 CCKPresentAttentuation_40Mdefault;
 	s8 CCKPresentAttentuation_difference;
-	s8 CCKPresentAttentuation;
+	s8 cck_present_attn;
 	long undecorated_smoothed_pwdb;
 
 	u32 MCSTxPowerLevelOriginalOffset[6];
@@ -536,7 +536,7 @@ struct r8192_priv {
 
 	u32		reset_count;
 
-	enum reset_type ResetProgress;
+	enum reset_type rst_progress;
 	u16		TxCounter;
 	u16		RxCounter;
 	bool		bResetInProgress;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 767c746fc73d..234e85a25d45 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -267,7 +267,7 @@ static void _rtl92e_dm_check_ac_dc_power(struct net_device *dev)
 			"PATH=/usr/bin:/bin",
 			 NULL};
 
-	if (priv->ResetProgress == RESET_TYPE_SILENT)
+	if (priv->rst_progress == RESET_TYPE_SILENT)
 		return;
 	if (priv->rtllib->state != RTLLIB_LINKED)
 		return;
@@ -716,21 +716,21 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 			}
 
 			if (priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20)
-				priv->CCKPresentAttentuation =
+				priv->cck_present_attn =
 					 priv->CCKPresentAttentuation_20Mdefault +
 					 priv->CCKPresentAttentuation_difference;
 			else
-				priv->CCKPresentAttentuation =
+				priv->cck_present_attn =
 					 priv->CCKPresentAttentuation_40Mdefault +
 					 priv->CCKPresentAttentuation_difference;
 
-			if (priv->CCKPresentAttentuation > (CCKTxBBGainTableLength-1))
-				priv->CCKPresentAttentuation = CCKTxBBGainTableLength-1;
-			if (priv->CCKPresentAttentuation < 0)
-				priv->CCKPresentAttentuation = 0;
+			if (priv->cck_present_attn > (CCKTxBBGainTableLength-1))
+				priv->cck_present_attn = CCKTxBBGainTableLength-1;
+			if (priv->cck_present_attn < 0)
+				priv->cck_present_attn = 0;
 
-			if (priv->CCKPresentAttentuation > -1 &&
-			    priv->CCKPresentAttentuation < CCKTxBBGainTableLength) {
+			if (priv->cck_present_attn > -1 &&
+			    priv->cck_present_attn < CCKTxBBGainTableLength) {
 				if (priv->rtllib->current_network.channel == 14 &&
 				    !priv->bcck_in_ch14) {
 					priv->bcck_in_ch14 = true;
@@ -963,7 +963,7 @@ static void _rtl92e_dm_cck_tx_power_adjust_tssi(struct net_device *dev,
 {
 	u32 TempVal;
 	struct r8192_priv *priv = rtllib_priv(dev);
-	u8 attenuation = priv->CCKPresentAttentuation;
+	u8 attenuation = priv->cck_present_attn;
 
 	TempVal = 0;
 	if (!bInCH14) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index c31e5b572e9e..7ff14aa9f476 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -1015,20 +1015,20 @@ static int _rtl92e_wx_set_promisc_mode(struct net_device *dev,
 
 	u32 oid;
 	u32 promiscuous_on;
-	u32 bFilterSourceStationFrame;
+	u32 fltr_src_sta_frame;
 
 	if (copy_from_user(info_buf, wrqu->data.pointer, sizeof(info_buf)))
 		return -EFAULT;
 
 	oid = info_buf[0];
 	promiscuous_on = info_buf[1];
-	bFilterSourceStationFrame = info_buf[2];
+	fltr_src_sta_frame = info_buf[2];
 
 	if (oid == OID_RT_INTEL_PROMISCUOUS_MODE) {
 		ieee->intel_promiscuous_md_info.promiscuous_on =
 					(promiscuous_on) ? (true) : (false);
-		ieee->intel_promiscuous_md_info.bFilterSourceStationFrame =
-			(bFilterSourceStationFrame) ? (true) : (false);
+		ieee->intel_promiscuous_md_info.fltr_src_sta_frame =
+			(fltr_src_sta_frame) ? (true) : (false);
 		(promiscuous_on) ?
 		(rtllib_EnableIntelPromiscuousMode(dev, false)) :
 		(rtllib_DisableIntelPromiscuousMode(dev, false));
@@ -1036,7 +1036,7 @@ static int _rtl92e_wx_set_promisc_mode(struct net_device *dev,
 		netdev_info(dev,
 			    "=======>%s(), on = %d, filter src sta = %d\n",
 			    __func__, promiscuous_on,
-			    bFilterSourceStationFrame);
+			    fltr_src_sta_frame);
 	} else {
 		return -1;
 	}
@@ -1055,7 +1055,7 @@ static int _rtl92e_wx_get_promisc_mode(struct net_device *dev,
 
 	snprintf(extra, 45, "PromiscuousMode:%d, FilterSrcSTAFrame:%d",
 		 ieee->intel_promiscuous_md_info.promiscuous_on,
-		 ieee->intel_promiscuous_md_info.bFilterSourceStationFrame);
+		 ieee->intel_promiscuous_md_info.fltr_src_sta_frame);
 	wrqu->data.length = strlen(extra) + 1;
 
 	mutex_unlock(&priv->wx_mutex);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 493759cc6ccf..9c81ca38f4b1 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1385,7 +1385,7 @@ struct rt_pmkid_list {
 
 struct rt_intel_promisc_mode {
 	bool promiscuous_on;
-	bool bFilterSourceStationFrame;
+	bool fltr_src_sta_frame;
 };
 
 
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index ccb61d8decd3..75190c389ccf 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1000,7 +1000,7 @@ static int rtllib_rx_data_filter(struct rtllib_device *ieee, u16 fc,
 
 	/* Filter packets sent by an STA that will be forwarded by AP */
 	if (ieee->intel_promiscuous_md_info.promiscuous_on  &&
-		ieee->intel_promiscuous_md_info.bFilterSourceStationFrame) {
+		ieee->intel_promiscuous_md_info.fltr_src_sta_frame) {
 		if ((fc & RTLLIB_FCTL_TODS) && !(fc & RTLLIB_FCTL_FROMDS) &&
 		    !ether_addr_equal(dst, ieee->current_network.bssid) &&
 		    ether_addr_equal(bssid, ieee->current_network.bssid)) {
-- 
2.37.3

