Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7566B3CC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjAOUUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 15:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjAOUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:20:42 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A771A13535
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:20:35 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mp20so17108254ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ouM6QWYCZ5t51yksCPB1b6uNMFDiFA56prLXy+81mDY=;
        b=bz6qdByBJl4nrO56DtSFjRI5uHjLdjelXPwGBGlHPjJmBh1aGpLSZX50gurAfGgDlp
         mnXToDbbWKk0hpSaKT3U5Xwr25/ZsvlxnFFDtnVQcwjkFFNh/Z/Pkb/C/vbl0HSy0lx+
         Wlma522NjSsjL7WIupl891Lx7dPE9G0M1mvMTW3Z0/OK7NJs4/Jco5mkOjrqw97ikOje
         w3xbZFQ6lMGHvaQZKY5GHOkH/cZ3q1VRWXfdzmO7r4+G4+oISFvk8U2bHwYrOhx5nhlW
         agqtKvIB2x4HT5uNVS5mJ0WuHjt0/IExwV1csfolLAr4ArcshcHfYZRtXd/kzTZbvETD
         ymMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouM6QWYCZ5t51yksCPB1b6uNMFDiFA56prLXy+81mDY=;
        b=n82gPFvj3C8uWmKbmsbFvvjeBS+B3FNF+hz3zocXw/WxGNPH61KWGjoudVLS3ZR8f6
         is43y+jnCLuW690S27lCsjDLOzMUOIQRrqEda4cyv4bG+7UPK8+TVVtljGq3no/a30JX
         Y6s0tRtqzh2q+q1mO+SDIkjMrAP4eU5sKplnCIJWQLnUdRQlYx5C6cnDWK9+1aRBe3rI
         Pkv+Sbu1vEkMdI+tVF+13IxwA95iO3M+x6KUY/HzrS0oANPXasW2gaUUop+2hCC3HNMh
         yVBh8ulN6qHbIZrtHUfE1Lends8rmdawgFybNBHQvMHtsepIVJfBblIGw9pRwITOddTK
         +X7g==
X-Gm-Message-State: AFqh2kofILg8dO3CPi9zXZK4qjjYgLh1zmgDZztLSKviVp223njev1fh
        AQm7Gdd9wALHowfzbo7bfBg=
X-Google-Smtp-Source: AMrXdXs4Fw2//ebJi0/xGsf6QxY+j4Nw3up0fzIqYtAx0Q1bZZ++ipUDDPSbjkhdGZf1tWc4CiYW9w==
X-Received: by 2002:a17:906:7255:b0:86e:2051:a514 with SMTP id n21-20020a170906725500b0086e2051a514mr1257362ejk.5.1673814034198;
        Sun, 15 Jan 2023 12:20:34 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906308e00b0084d3acda5fasm9475529ejv.189.2023.01.15.12.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 12:20:33 -0800 (PST)
Date:   Sun, 15 Jan 2023 21:20:32 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] staging: rtl8192e: Rename bResetInPro.., framesyncMo..
 and nCur40MhzPri..
Message-ID: <dc9a6353e2342f524d8cbf0de6a6340990dc913b.1673812849.git.philipp.g.hortmann@gmail.com>
References: <cover.1673812849.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673812849.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable bResetInProgress to reset_in_progress, framesyncMonitor to
frame_sync_monitor and nCur40MhzPrimeSC to n_cur_40mhz_prime_sc to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 10 +++++-----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 10 +++++-----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 10 +++++-----
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 1f0c53dcbb2d..734a097ee268 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1074,7 +1074,7 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 			pTxFwInfo->TxSubCarrier = 0;
 		} else {
 			pTxFwInfo->TxBandwidth = 0;
-			pTxFwInfo->TxSubCarrier = priv->nCur40MhzPrimeSC;
+			pTxFwInfo->TxSubCarrier = priv->n_cur_40mhz_prime_sc;
 		}
 	} else {
 		pTxFwInfo->TxBandwidth = 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index a0233281ad94..59b2e8385ef7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1156,9 +1156,9 @@ static void _rtl92e_set_bw_mode_work_item(struct net_device *dev)
 		}
 
 		rtl92e_set_bb_reg(dev, rCCK0_System, bCCKSideBand,
-				  (priv->nCur40MhzPrimeSC>>1));
+				  (priv->n_cur_40mhz_prime_sc>>1));
 		rtl92e_set_bb_reg(dev, rOFDM1_LSTF, 0xC00,
-				  priv->nCur40MhzPrimeSC);
+				  priv->n_cur_40mhz_prime_sc);
 
 		rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1, 0x00100000, 0);
 		break;
@@ -1208,11 +1208,11 @@ void rtl92e_set_bw_mode(struct net_device *dev, enum ht_channel_width bandwidth,
 	priv->CurrentChannelBW = bandwidth;
 
 	if (Offset == HT_EXTCHNL_OFFSET_LOWER)
-		priv->nCur40MhzPrimeSC = HAL_PRIME_CHNL_OFFSET_UPPER;
+		priv->n_cur_40mhz_prime_sc = HAL_PRIME_CHNL_OFFSET_UPPER;
 	else if (Offset == HT_EXTCHNL_OFFSET_UPPER)
-		priv->nCur40MhzPrimeSC = HAL_PRIME_CHNL_OFFSET_LOWER;
+		priv->n_cur_40mhz_prime_sc = HAL_PRIME_CHNL_OFFSET_LOWER;
 	else
-		priv->nCur40MhzPrimeSC = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
+		priv->n_cur_40mhz_prime_sc = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
 	_rtl92e_set_bw_mode_work_item(dev);
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 050f0435ab6d..8e1180b75d38 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1138,7 +1138,7 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 			goto END;
 		}
 		priv->rf_change_in_progress = true;
-		priv->bResetInProgress = true;
+		priv->reset_in_progress = true;
 		spin_unlock_irqrestore(&priv->rf_ps_lock, flag);
 
 RESET_START:
@@ -1229,7 +1229,7 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 END:
 		priv->rst_progress = RESET_TYPE_NORESET;
 		priv->reset_count++;
-		priv->bResetInProgress = false;
+		priv->reset_in_progress = false;
 
 		rtl92e_writeb(dev, UFWP, 1);
 	}
@@ -1397,7 +1397,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	if ((priv->force_reset || ResetType == RESET_TYPE_SILENT))
 		_rtl92e_if_silent_reset(dev);
 	priv->force_reset = false;
-	priv->bResetInProgress = false;
+	priv->reset_in_progress = false;
 }
 
 static void _rtl92e_watchdog_timer_cb(struct timer_list *t)
@@ -1486,7 +1486,7 @@ static void _rtl92e_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
 	u8 queue_index = tcb_desc->queue_index;
 
 	if ((priv->rtllib->rf_power_state == rf_off) || !priv->up ||
-	     priv->bResetInProgress) {
+	     priv->reset_in_progress) {
 		kfree_skb(skb);
 		return;
 	}
@@ -1519,7 +1519,7 @@ static int _rtl92e_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if (queue_index != TXCMD_QUEUE) {
 		if ((priv->rtllib->rf_power_state == rf_off) ||
-		     !priv->up || priv->bResetInProgress) {
+		     !priv->up || priv->reset_in_progress) {
 			kfree_skb(skb);
 			return 0;
 		}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index be87bb9da6cc..ed9ddb2f987b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -442,7 +442,7 @@ struct r8192_priv {
 	u8 SwChnlStep;
 	u8 SetBWModeInProgress;
 
-	u8 nCur40MhzPrimeSC;
+	u8 n_cur_40mhz_prime_sc;
 
 	u32 rf_reg_0value[4];
 	u8 num_total_rf_path;
@@ -515,14 +515,14 @@ struct r8192_priv {
 	bool		bswitch_fsync;
 	u8		framesync;
 	u32		framesyncC34;
-	u8		framesyncMonitor;
+	u8		frame_sync_monitor;
 
 	u32		reset_count;
 
 	enum reset_type rst_progress;
 	u16		tx_counter;
 	u16		rx_ctr;
-	bool		bResetInProgress;
+	bool		reset_in_progress;
 	bool		force_reset;
 	bool		force_lps;
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 2a570c28e694..0e278b872470 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -640,7 +640,7 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 			if (Pwr_Flag == 0) {
 				mdelay(1);
 
-				if (priv->bResetInProgress) {
+				if (priv->reset_in_progress) {
 					rtl92e_writeb(dev, Pw_Track_Flag, 0);
 					rtl92e_writeb(dev, FW_Busy_Flag, 0);
 					return;
@@ -1969,7 +1969,7 @@ static void _rtl92e_dm_init_fsync(struct net_device *dev)
 	priv->rtllib->fsync_firstdiff_ratethreshold = 100;
 	priv->rtllib->fsync_seconddiff_ratethreshold = 200;
 	priv->rtllib->fsync_state = Default_Fsync;
-	priv->framesyncMonitor = 1;
+	priv->frame_sync_monitor = 1;
 
 	timer_setup(&priv->fsync_timer, _rtl92e_dm_fsync_timer_callback, 0);
 }
@@ -2196,7 +2196,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 
 			}
 		}
-		if (priv->framesyncMonitor) {
+		if (priv->frame_sync_monitor) {
 			if (reg_c38_State != RegC38_Fsync_AP_BCM) {
 				rtl92e_writeb(dev, rOFDM0_RxDetector3, 0x95);
 
@@ -2218,7 +2218,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 			break;
 		}
 
-		if (priv->framesyncMonitor) {
+		if (priv->frame_sync_monitor) {
 			if (priv->rtllib->state == RTLLIB_LINKED) {
 				if (priv->undecorated_smoothed_pwdb <=
 				    RegC38_TH) {
@@ -2249,7 +2249,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 			}
 		}
 	}
-	if (priv->framesyncMonitor) {
+	if (priv->frame_sync_monitor) {
 		if (priv->reset_count != reset_cnt) {
 			rtl92e_writeb(dev, rOFDM0_RxDetector3,
 				       priv->framesync);
-- 
2.39.0

