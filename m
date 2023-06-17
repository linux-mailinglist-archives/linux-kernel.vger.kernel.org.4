Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CCA734189
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346206AbjFQN6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjFQN6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:58:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41C82700
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:57:33 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-516a0105121so402926a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687010252; x=1689602252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkmjazlAR0SOJnibuMAsrh0dHrzkB5jiHviyz5Pstgw=;
        b=rJRtS9moHqpXhI4Hk5iQvZgVkY+D9eUn5XNHCL3JfXtr0RhT/6VCRsnLvR721Y84b4
         /lSzIHOlg1aTXigGz3SGJyiRPMqNkv/ijtVR0FKtmhnHJ8ANGDpyfbBM8Vj37bC3LnAr
         8JzWJSKtBitls4qiIkfd3Umi1982q2/3D06NpDGmcqG32gtmi30aflgquHpBsog59ekc
         fn0jQvqKpqmIEZIf8ndtJfpV8YF91JwU1Pr7DjjB+a8vsWxvB8AebCL4/9w9LsdeyOzk
         WtUTRbzLmfRqWj7P9a0gh4eD8mW8wt1HG3w/aXkccNf7hL7v6xXOscQ6x8JZOnbIh8aF
         N+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687010252; x=1689602252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkmjazlAR0SOJnibuMAsrh0dHrzkB5jiHviyz5Pstgw=;
        b=LJFRQxEnjxgf2epwcscXp2cKtAKfpIoduUT3QZlKEDvGGNASC7KxcZZ+0ciNrVtbbL
         cqVX1zqCKfwfwKuJNsIrjZRo4cz2AK+nocUZ2zD5wyHb8H02zZo9FuFwr/whbgCdrvmo
         ZHiu8iDYZVxU5ND6PhFrCodZPBfHU3vAI8j8xugPHhyUVfx2vJlEWi4wJbfmlSFIey9b
         sye3ZAGzLqifhQ9wyGRLLykjA1XxfinpKLL3bQWZJ+RJ5gKSpAMOLhmnG6YC38eLo4O3
         4gh7uATyOVCFWQ6fMPUu1LAbr548Qb4lGxEXaP/wgx1fe8RNfJHLH6M2AMoZ0efFnRz5
         YaQg==
X-Gm-Message-State: AC+VfDysJiDpcxtC8PFThmIcK1p/llhMtRyta4Fdx4Lcy8ojZz4L1HVL
        MEXMqA86pyLGZ5qlXB2V35/nWyH3OpE=
X-Google-Smtp-Source: ACHHUZ6FtskcSTRECAxBoKpnqyL+RR0w/eZwdEqmLvJ9r86v6fg3cTMycPC3KiEs1azh/X3XOWOarQ==
X-Received: by 2002:a05:6402:2753:b0:509:c551:c00c with SMTP id z19-20020a056402275300b00509c551c00cmr4125835edd.2.1687010251968;
        Sat, 17 Jun 2023 06:57:31 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id eh9-20020a0564020f8900b0050a276e7ba8sm11024906edb.36.2023.06.17.06.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 06:57:31 -0700 (PDT)
Date:   Sat, 17 Jun 2023 15:57:29 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] staging: rtl8192e: Rename RTLLIB_LINKED to
 MAC80211_LINKED
Message-ID: <532bd98301657b2a8329e95eccb993540ae9ba3f.1687007788.git.philipp.g.hortmann@gmail.com>
References: <cover.1687007788.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687007788.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename RTLLIB_LINKED to MAC80211_LINKED to align with rtlwifi driver.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 10 +++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 30 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 16 +++++-----
 .../staging/rtl8192e/rtl8192e/rtl_ethtool.c   |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  4 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  8 ++---
 drivers/staging/rtl8192e/rtllib.h             |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c          | 12 ++++----
 drivers/staging/rtl8192e/rtllib_softmac.c     | 28 ++++++++---------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  | 10 +++----
 drivers/staging/rtl8192e/rtllib_wx.c          |  2 +-
 11 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b6c086047841..7683853e7c46 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -52,15 +52,15 @@ static void _rtl92e_update_msr(struct net_device *dev)
 
 	switch (priv->rtllib->iw_mode) {
 	case IW_MODE_INFRA:
-		if (priv->rtllib->link_state == RTLLIB_LINKED)
+		if (priv->rtllib->link_state == MAC80211_LINKED)
 			msr |= MSR_LINK_MANAGED;
 		break;
 	case IW_MODE_ADHOC:
-		if (priv->rtllib->link_state == RTLLIB_LINKED)
+		if (priv->rtllib->link_state == MAC80211_LINKED)
 			msr |= MSR_LINK_ADHOC;
 		break;
 	case IW_MODE_MASTER:
-		if (priv->rtllib->link_state == RTLLIB_LINKED)
+		if (priv->rtllib->link_state == MAC80211_LINKED)
 			msr |= MSR_LINK_MASTER;
 		break;
 	default:
@@ -745,7 +745,7 @@ void rtl92e_link_change(struct net_device *dev)
 	if (!priv->up)
 		return;
 
-	if (ieee->link_state == RTLLIB_LINKED) {
+	if (ieee->link_state == MAC80211_LINKED) {
 		_rtl92e_net_update(dev);
 		rtl92e_update_ratr_table(dev);
 		if ((ieee->pairwise_key_type == KEY_TYPE_WEP40) ||
@@ -760,7 +760,7 @@ void rtl92e_link_change(struct net_device *dev)
 		u32 reg;
 
 		reg = rtl92e_readl(dev, RCR);
-		if (priv->rtllib->link_state == RTLLIB_LINKED) {
+		if (priv->rtllib->link_state == MAC80211_LINKED) {
 			if (ieee->intel_promiscuous_md_info.promiscuous_on)
 				;
 			else
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index b4c618d37a71..9cb4ae9ba970 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -169,7 +169,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 		    (priv->rtllib->iw_mode == IW_MODE_ADHOC)) {
 			if ((priv->rtllib->rf_off_reason > RF_CHANGE_BY_IPS) ||
 			    (change_source > RF_CHANGE_BY_IPS)) {
-				if (ieee->link_state == RTLLIB_LINKED)
+				if (ieee->link_state == MAC80211_LINKED)
 					priv->blinked_ingpio = true;
 				else
 					priv->blinked_ingpio = false;
@@ -327,7 +327,7 @@ static void _rtl92e_qos_activate(void *data)
 	int i;
 
 	mutex_lock(&priv->mutex);
-	if (priv->rtllib->link_state != RTLLIB_LINKED)
+	if (priv->rtllib->link_state != MAC80211_LINKED)
 		goto success;
 
 	for (i = 0; i <  QOS_QUEUE_NUM; i++)
@@ -344,7 +344,7 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
 	int ret = 0;
 	u32 size = sizeof(struct rtllib_qos_parameters);
 
-	if (priv->rtllib->link_state != RTLLIB_LINKED)
+	if (priv->rtllib->link_state != MAC80211_LINKED)
 		return ret;
 
 	if (priv->rtllib->iw_mode != IW_MODE_INFRA)
@@ -400,7 +400,7 @@ static int _rtl92e_qos_assoc_resp(struct r8192_priv *priv,
 	if (!priv || !network)
 		return 0;
 
-	if (priv->rtllib->link_state != RTLLIB_LINKED)
+	if (priv->rtllib->link_state != MAC80211_LINKED)
 		return 0;
 
 	if (priv->rtllib->iw_mode != IW_MODE_INFRA)
@@ -635,7 +635,7 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 	if (priv->polling_timer_on == 0)
 		rtl92e_check_rfctrl_gpio_timer(&priv->gpio_polling_timer);
 
-	if (priv->rtllib->link_state != RTLLIB_LINKED)
+	if (priv->rtllib->link_state != MAC80211_LINKED)
 		rtllib_softmac_start_protocol(priv->rtllib, 0);
 	rtllib_reset_queue(priv->rtllib);
 	_rtl92e_watchdog_timer_cb(&priv->watch_dog_timer);
@@ -660,7 +660,7 @@ static int _rtl92e_sta_down(struct net_device *dev, bool shutdownrf)
 
 	priv->rtllib->rtllib_ips_leave(dev);
 
-	if (priv->rtllib->link_state == RTLLIB_LINKED)
+	if (priv->rtllib->link_state == MAC80211_LINKED)
 		rtl92e_leisure_ps_leave(dev);
 
 	priv->up = 0;
@@ -1009,7 +1009,7 @@ static enum reset_type _rtl92e_if_check_reset(struct net_device *dev)
 
 	if (rfState == rf_on &&
 	    (priv->rtllib->iw_mode == IW_MODE_INFRA) &&
-	    (priv->rtllib->link_state == RTLLIB_LINKED))
+	    (priv->rtllib->link_state == MAC80211_LINKED))
 		RxResetType = _rtl92e_rx_check_stuck(dev);
 
 	if (TxResetType == RESET_TYPE_NORMAL ||
@@ -1051,7 +1051,7 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 
 		mutex_lock(&priv->wx_mutex);
 
-		if (priv->rtllib->link_state == RTLLIB_LINKED)
+		if (priv->rtllib->link_state == MAC80211_LINKED)
 			rtl92e_leisure_ps_leave(dev);
 
 		if (priv->up) {
@@ -1073,9 +1073,9 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 		rtl92e_dm_deinit(dev);
 		rtllib_stop_scan_syncro(ieee);
 
-		if (ieee->link_state == RTLLIB_LINKED) {
+		if (ieee->link_state == MAC80211_LINKED) {
 			mutex_lock(&ieee->wx_mutex);
-			netdev_info(dev, "ieee->link_state is RTLLIB_LINKED\n");
+			netdev_info(dev, "ieee->link_state is MAC80211_LINKED\n");
 			rtllib_stop_send_beacons(priv->rtllib);
 			del_timer_sync(&ieee->associate_timer);
 			cancel_delayed_work(&ieee->associate_retry_wq);
@@ -1110,14 +1110,14 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 
 		rtl92e_enable_hw_security_config(dev);
 
-		if (ieee->link_state == RTLLIB_LINKED && ieee->iw_mode ==
+		if (ieee->link_state == MAC80211_LINKED && ieee->iw_mode ==
 		    IW_MODE_INFRA) {
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel);
 
 			schedule_work(&ieee->associate_complete_wq);
 
-		} else if (ieee->link_state == RTLLIB_LINKED && ieee->iw_mode ==
+		} else if (ieee->link_state == MAC80211_LINKED && ieee->iw_mode ==
 			   IW_MODE_ADHOC) {
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel);
@@ -1181,7 +1181,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	if (!priv->up || priv->hw_radio_off)
 		return;
 
-	if (priv->rtllib->link_state >= RTLLIB_LINKED) {
+	if (priv->rtllib->link_state >= MAC80211_LINKED) {
 		if (priv->rtllib->CntAfterLink < 2)
 			priv->rtllib->CntAfterLink++;
 	} else {
@@ -1202,7 +1202,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 			}
 		}
 	}
-	if ((ieee->link_state == RTLLIB_LINKED) && (ieee->iw_mode ==
+	if ((ieee->link_state == MAC80211_LINKED) && (ieee->iw_mode ==
 	     IW_MODE_INFRA) && (!ieee->net_promiscuous_md)) {
 		if (ieee->link_detect_info.NumRxOkInPeriod > 100 ||
 		ieee->link_detect_info.NumTxOkInPeriod > 100)
@@ -1244,7 +1244,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	ieee->link_detect_info.bHigherBusyTraffic = bHigherBusyTraffic;
 	ieee->link_detect_info.bHigherBusyRxTraffic = bHigherBusyRxTraffic;
 
-	if (ieee->link_state == RTLLIB_LINKED && ieee->iw_mode == IW_MODE_INFRA) {
+	if (ieee->link_state == MAC80211_LINKED && ieee->iw_mode == IW_MODE_INFRA) {
 		u32	TotalRxBcnNum = 0;
 		u32	TotalRxDataNum = 0;
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 74715e254df3..adb6f12c89d8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -291,7 +291,7 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 	if (priv->rtllib->mode != WIRELESS_MODE_N_24G)
 		return;
 
-	if (priv->rtllib->link_state == RTLLIB_LINKED) {
+	if (priv->rtllib->link_state == MAC80211_LINKED) {
 		bshort_gi_enabled = (ht_info->cur_tx_bw40mhz &&
 				     ht_info->bCurShortGI40MHz) ||
 				    (!ht_info->cur_tx_bw40mhz &&
@@ -1075,7 +1075,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
 		dm_digtable.dig_state = DM_STA_DIG_OFF;
 	}
 
-	if (priv->rtllib->link_state == RTLLIB_LINKED)
+	if (priv->rtllib->link_state == MAC80211_LINKED)
 		dm_digtable.cur_sta_connect_state = DIG_STA_CONNECT;
 	else
 		dm_digtable.cur_sta_connect_state = DIG_STA_DISCONNECT;
@@ -1105,7 +1105,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
 		dm_digtable.dig_algorithm_switch = 0;
 	}
 
-	if (priv->rtllib->link_state != RTLLIB_LINKED)
+	if (priv->rtllib->link_state != MAC80211_LINKED)
 		return;
 
 	if ((priv->undecorated_smoothed_pwdb > dm_digtable.rssi_low_thresh) &&
@@ -1406,7 +1406,7 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 
 	if (priv->rtllib->iw_mode == IW_MODE_ADHOC)
 		goto dm_CheckEdcaTurbo_EXIT;
-	if (priv->rtllib->link_state != RTLLIB_LINKED)
+	if (priv->rtllib->link_state != MAC80211_LINKED)
 		goto dm_CheckEdcaTurbo_EXIT;
 	if (priv->rtllib->ht_info->iot_action & HT_IOT_ACT_DISABLE_EDCA_TURBO)
 		goto dm_CheckEdcaTurbo_EXIT;
@@ -1820,7 +1820,7 @@ static void _rtl92e_dm_fsync_timer_callback(struct timer_list *t)
 	bool		bSwitchFromCountDiff = false;
 	bool		bDoubleTimeInterval = false;
 
-	if (priv->rtllib->link_state == RTLLIB_LINKED &&
+	if (priv->rtllib->link_state == MAC80211_LINKED &&
 	    priv->rtllib->bfsync_enable &&
 	    (priv->rtllib->ht_info->iot_action & HT_IOT_ACT_CDD_FSYNC)) {
 		u32 rate_bitmap;
@@ -1990,7 +1990,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 	static u8 reg_c38_State = RegC38_Default;
 	static u32 reset_cnt;
 
-	if (priv->rtllib->link_state == RTLLIB_LINKED &&
+	if (priv->rtllib->link_state == MAC80211_LINKED &&
 	    priv->rtllib->ht_info->IOTPeer == HT_IOT_PEER_BROADCOM) {
 		if (priv->rtllib->bfsync_enable == 0) {
 			switch (priv->rtllib->fsync_state) {
@@ -2043,7 +2043,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 			break;
 		}
 
-		if (priv->rtllib->link_state == RTLLIB_LINKED) {
+		if (priv->rtllib->link_state == MAC80211_LINKED) {
 			if (priv->undecorated_smoothed_pwdb <=
 			    RegC38_TH) {
 				if (reg_c38_State !=
@@ -2112,7 +2112,7 @@ static void _rtl92e_dm_dynamic_tx_power(struct net_device *dev)
 		txlowpower_threshold = TX_POWER_NEAR_FIELD_THRESH_LOW;
 	}
 
-	if (priv->rtllib->link_state == RTLLIB_LINKED) {
+	if (priv->rtllib->link_state == MAC80211_LINKED) {
 		if (priv->undecorated_smoothed_pwdb >= txhipower_threshold) {
 			priv->dynamic_tx_high_pwr = true;
 			priv->dynamic_tx_low_pwr = false;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
index 543b0e9dfa88..1625d1326599 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
@@ -27,7 +27,7 @@ static u32 _rtl92e_ethtool_get_link(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	return ((priv->rtllib->link_state == RTLLIB_LINKED) ||
+	return ((priv->rtllib->link_state == MAC80211_LINKED) ||
 		(priv->rtllib->link_state == RTLLIB_LINKED_SCANNING));
 }
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index bb52a595f75c..5ecade840d75 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -118,7 +118,7 @@ void rtl92e_ips_enter(struct net_device *dev)
 
 	rt_state = priv->rtllib->rf_power_state;
 	if (rt_state == rf_on && !psc->bSwRfProcessing &&
-		(priv->rtllib->link_state != RTLLIB_LINKED) &&
+		(priv->rtllib->link_state != MAC80211_LINKED) &&
 		(priv->rtllib->iw_mode != IW_MODE_MASTER)) {
 		psc->eInactivePowerState = rf_off;
 		_rtl92e_ps_update_rf_state(dev);
@@ -209,7 +209,7 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 					&priv->rtllib->pwr_save_ctrl;
 
 	if (!((priv->rtllib->iw_mode == IW_MODE_INFRA) &&
-	    (priv->rtllib->link_state == RTLLIB_LINKED))
+	    (priv->rtllib->link_state == MAC80211_LINKED))
 	    || (priv->rtllib->iw_mode == IW_MODE_ADHOC) ||
 	    (priv->rtllib->iw_mode == IW_MODE_MASTER))
 		return;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 2d99badfb224..4436442b56dd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -169,7 +169,7 @@ static int _rtl92e_wx_adapter_power_status(struct net_device *dev,
 		priv->ps_force = false;
 		psc->bLeisurePs = true;
 	} else {
-		if (priv->rtllib->link_state == RTLLIB_LINKED)
+		if (priv->rtllib->link_state == MAC80211_LINKED)
 			rtl92e_leisure_ps_leave(dev);
 
 		priv->ps_force = true;
@@ -378,7 +378,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 		if ((ieee->link_state >= RTLLIB_ASSOCIATING) &&
 		    (ieee->link_state <= RTLLIB_ASSOCIATING_AUTHENTICATED))
 			return 0;
-		if ((priv->rtllib->link_state == RTLLIB_LINKED) &&
+		if ((priv->rtllib->link_state == MAC80211_LINKED) &&
 		    (priv->rtllib->CntAfterLink < 2))
 			return 0;
 	}
@@ -409,7 +409,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 
 	priv->rtllib->FirstIe_InScan = true;
 
-	if (priv->rtllib->link_state != RTLLIB_LINKED) {
+	if (priv->rtllib->link_state != MAC80211_LINKED) {
 		if (rt_state == rf_off) {
 			if (priv->rtllib->rf_off_reason >
 			    RF_CHANGE_BY_IPS) {
@@ -1124,7 +1124,7 @@ static struct iw_statistics *_rtl92e_get_wireless_stats(struct net_device *dev)
 	int tmp_qual = 0;
 	int tmp_noise = 0;
 
-	if (ieee->link_state < RTLLIB_LINKED) {
+	if (ieee->link_state < MAC80211_LINKED) {
 		wstats->qual.qual = 10;
 		wstats->qual.level = 0;
 		wstats->qual.noise = 0x100 - 100;	/* -100 dBm */
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 68f0e1426b35..7758bfd90283 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1146,7 +1146,7 @@ enum rtl_link_state {
 	/* the link is ok. the card associated to a BSS or linked
 	 * to a ibss cell or acting as an AP and creating the bss
 	 */
-	RTLLIB_LINKED,
+	MAC80211_LINKED,
 
 	/* same as LINKED, but the driver shall apply RX filter
 	 * rules as we are in NO_LINK mode. As the card is still
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 68f1393b1b63..78d13ff1f14e 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1196,7 +1196,7 @@ static void rtllib_rx_check_leave_lps(struct rtllib_device *ieee, u8 unicast,
 				      u8 nr_subframes)
 {
 	if (unicast) {
-		if (ieee->link_state == RTLLIB_LINKED) {
+		if (ieee->link_state == MAC80211_LINKED) {
 			if (((ieee->link_detect_info.NumRxUnicastOkInPeriod +
 			    ieee->link_detect_info.NumTxOkInPeriod) > 8) ||
 			    (ieee->link_detect_info.NumRxUnicastOkInPeriod > 2)) {
@@ -2117,7 +2117,7 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 			network->tim.tim_period = info_element->data[1];
 
 			network->dtim_period = info_element->data[1];
-			if (ieee->link_state != RTLLIB_LINKED)
+			if (ieee->link_state != MAC80211_LINKED)
 				break;
 			network->last_dtim_sta_time = jiffies;
 
@@ -2585,7 +2585,7 @@ static inline void rtllib_process_probe_response(
 				ieee->current_network.buseprotection = false;
 		}
 		if (is_beacon(frame_ctl)) {
-			if (ieee->link_state >= RTLLIB_LINKED)
+			if (ieee->link_state >= MAC80211_LINKED)
 				ieee->link_detect_info.NumRecvBcnInPeriod++;
 		}
 	}
@@ -2654,7 +2654,7 @@ static inline void rtllib_process_probe_response(
 	if (is_beacon(frame_ctl) &&
 	    is_same_network(&ieee->current_network, network,
 	    (network->ssid_len ? 1 : 0)) &&
-	    (ieee->link_state == RTLLIB_LINKED)) {
+	    (ieee->link_state == MAC80211_LINKED)) {
 		ieee->handle_beacon(ieee->dev, beacon, &ieee->current_network);
 	}
 free_network:
@@ -2683,7 +2683,7 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 
 		if (ieee->sta_sleep || (ieee->ps != RTLLIB_PS_DISABLED &&
 		    ieee->iw_mode == IW_MODE_INFRA &&
-		    ieee->link_state == RTLLIB_LINKED))
+		    ieee->link_state == MAC80211_LINKED))
 			schedule_work(&ieee->ps_task);
 
 		break;
@@ -2700,7 +2700,7 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
 		    ((ieee->iw_mode == IW_MODE_ADHOC ||
 		    ieee->iw_mode == IW_MODE_MASTER) &&
-		    ieee->link_state == RTLLIB_LINKED))
+		    ieee->link_state == MAC80211_LINKED))
 			rtllib_rx_probe_rq(ieee, skb);
 		break;
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index bbb0f61c851d..d99b98a39cc7 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -510,7 +510,7 @@ static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee, u8 is_mesh)
 		 *    new one. In this case the link state is
 		 *    MAC80211_NOLINK until we found an interesting cell.
 		 *    If so the ieee8021_new_net, called by the RX path
-		 *    will set the state to RTLLIB_LINKED, so we stop
+		 *    will set the state to MAC80211_LINKED, so we stop
 		 *    scanning
 		 * 2- We are linked and the root uses run iwlist scan.
 		 *    So we switch to RTLLIB_LINKED_SCANNING to remember
@@ -522,7 +522,7 @@ static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee, u8 is_mesh)
 		 * if the state become LINKED because of the #1 situation
 		 */
 
-		if (ieee->link_state == RTLLIB_LINKED)
+		if (ieee->link_state == MAC80211_LINKED)
 			goto out;
 		if (ieee->sync_scan_hurryup) {
 			netdev_info(ieee->dev,
@@ -543,7 +543,7 @@ static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee, u8 is_mesh)
 	ieee->actscanning = false;
 	ieee->sync_scan_hurryup = 0;
 
-	if (ieee->link_state >= RTLLIB_LINKED) {
+	if (ieee->link_state >= MAC80211_LINKED) {
 		if (IS_DOT11D_ENABLE(ieee))
 			dot11d_scan_complete(ieee);
 	}
@@ -1508,7 +1508,7 @@ static void rtllib_associate_complete(struct rtllib_device *ieee)
 {
 	del_timer_sync(&ieee->associate_timer);
 
-	ieee->link_state = RTLLIB_LINKED;
+	ieee->link_state = MAC80211_LINKED;
 	rtllib_sta_send_associnfo(ieee);
 
 	schedule_work(&ieee->associate_complete_wq);
@@ -1664,7 +1664,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 						    "Using B rates\n");
 				}
 				memset(ieee->dot11ht_oper_rate_set, 0, 16);
-				ieee->link_state = RTLLIB_LINKED;
+				ieee->link_state = MAC80211_LINKED;
 			}
 		}
 	}
@@ -1985,7 +1985,7 @@ static inline void rtllib_sta_ps(struct work_struct *work)
 
 	if ((ieee->ps == RTLLIB_PS_DISABLED ||
 	     ieee->iw_mode != IW_MODE_INFRA ||
-	     ieee->link_state != RTLLIB_LINKED)) {
+	     ieee->link_state != MAC80211_LINKED)) {
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 		rtllib_sta_wakeup(ieee, 1);
 
@@ -2149,7 +2149,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 
 			if (!network)
 				return 1;
-			ieee->link_state = RTLLIB_LINKED;
+			ieee->link_state = MAC80211_LINKED;
 			ieee->assoc_id = aid;
 			ieee->softmac_stats.rx_ass_ok++;
 			/* station support qos */
@@ -2283,7 +2283,7 @@ rtllib_rx_deauth(struct rtllib_device *ieee, struct sk_buff *skb)
 	 * both for disassociation and deauthentication
 	 */
 	if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
-	    ieee->link_state == RTLLIB_LINKED &&
+	    ieee->link_state == MAC80211_LINKED &&
 	    (ieee->iw_mode == IW_MODE_INFRA)) {
 		frame_ctl = le16_to_cpu(header->frame_ctl);
 		netdev_info(ieee->dev,
@@ -2458,7 +2458,7 @@ static void rtllib_start_master_bss(struct rtllib_device *ieee)
 	ether_addr_copy(ieee->current_network.bssid, ieee->dev->dev_addr);
 
 	ieee->set_chan(ieee->dev, ieee->current_network.channel);
-	ieee->link_state = RTLLIB_LINKED;
+	ieee->link_state = MAC80211_LINKED;
 	ieee->link_change(ieee->dev);
 	notify_wx_assoc_event(ieee);
 	netif_carrier_on(ieee->dev);
@@ -2509,7 +2509,7 @@ static void rtllib_start_ibss_wq(void *data)
 	 * (in bss mode we had to make sure no-one tried to associate when
 	 * we had just checked the ieee->link_state and we was going to start the
 	 * scan) because in ibss mode the rtllib_new_net function, when
-	 * finds a good net, just set the ieee->link_state to RTLLIB_LINKED,
+	 * finds a good net, just set the ieee->link_state to MAC80211_LINKED,
 	 * so, at worst, we waste a bit of time to initiate an unneeded syncro
 	 * scan, that will stop at the first round because it sees the state
 	 * associated.
@@ -2581,7 +2581,7 @@ static void rtllib_start_ibss_wq(void *data)
 	ieee->SetHwRegHandler(ieee->dev, HW_VAR_MEDIA_STATUS,
 			      (u8 *)(&ieee->link_state));
 
-	ieee->link_state = RTLLIB_LINKED;
+	ieee->link_state = MAC80211_LINKED;
 	ieee->link_change(ieee->dev);
 
 	HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
@@ -2765,7 +2765,7 @@ void rtllib_stop_protocol(struct rtllib_device *ieee, u8 shutdown)
 	if (ieee->link_state <= RTLLIB_ASSOCIATING_AUTHENTICATED)
 		ieee->link_state = MAC80211_NOLINK;
 
-	if (ieee->link_state == RTLLIB_LINKED) {
+	if (ieee->link_state == MAC80211_LINKED) {
 		if (ieee->iw_mode == IW_MODE_INFRA)
 			SendDisassociation(ieee, 1, WLAN_REASON_DEAUTH_LEAVING);
 		rtllib_disassociate(ieee);
@@ -3100,7 +3100,7 @@ bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn)
 	if (rtllib->ps != RTLLIB_PS_DISABLED)
 		rtllib->sta_wake_up(rtllib->dev);
 
-	if (rtllib->link_state == RTLLIB_LINKED) {
+	if (rtllib->link_state == MAC80211_LINKED) {
 		if (rtllib->iw_mode == IW_MODE_ADHOC)
 			rtllib_MgntDisconnectIBSS(rtllib);
 		if (rtllib->iw_mode == IW_MODE_INFRA)
@@ -3119,7 +3119,7 @@ void notify_wx_assoc_event(struct rtllib_device *ieee)
 		return;
 
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
-	if (ieee->link_state == RTLLIB_LINKED)
+	if (ieee->link_state == MAC80211_LINKED)
 		memcpy(wrqu.ap_addr.sa_data, ieee->current_network.bssid,
 		       ETH_ALEN);
 	else {
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 8e101b63ec75..c1d1bf4d720a 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -53,7 +53,7 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
 
 		if (ieee->iw_mode == IW_MODE_ADHOC ||
 		    ieee->iw_mode == IW_MODE_MASTER)
-			if (ieee->link_state == RTLLIB_LINKED) {
+			if (ieee->link_state == MAC80211_LINKED) {
 				rtllib_stop_send_beacons(ieee);
 				rtllib_start_send_beacons(ieee);
 			}
@@ -95,7 +95,7 @@ int rtllib_wx_get_wap(struct rtllib_device *ieee,
 	/* We want avoid to give to the user inconsistent infos*/
 	spin_lock_irqsave(&ieee->lock, flags);
 
-	if (ieee->link_state != RTLLIB_LINKED &&
+	if (ieee->link_state != MAC80211_LINKED &&
 		ieee->link_state != RTLLIB_LINKED_SCANNING &&
 		ieee->wap_set == 0)
 
@@ -184,7 +184,7 @@ int rtllib_wx_get_essid(struct rtllib_device *ieee, struct iw_request_info *a,
 		goto out;
 	}
 
-	if (ieee->link_state != RTLLIB_LINKED &&
+	if (ieee->link_state != MAC80211_LINKED &&
 		ieee->link_state != RTLLIB_LINKED_SCANNING &&
 		ieee->ssid_set == 0) {
 		ret = -1;
@@ -355,7 +355,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 
 	ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_RESTORE);
 
-	ieee->link_state = RTLLIB_LINKED;
+	ieee->link_state = MAC80211_LINKED;
 	ieee->link_change(ieee->dev);
 
 	/* Notify AP that I wake up again */
@@ -385,7 +385,7 @@ int rtllib_wx_set_scan(struct rtllib_device *ieee, struct iw_request_info *a,
 		goto out;
 	}
 
-	if (ieee->link_state == RTLLIB_LINKED) {
+	if (ieee->link_state == MAC80211_LINKED) {
 		schedule_work(&ieee->wx_sync_scan_wq);
 		/* intentionally forget to up sem */
 		return 0;
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index a82fd64dbdce..538cedb1dc02 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -619,7 +619,7 @@ int rtllib_wx_set_mlme(struct rtllib_device *ieee,
 	bool deauth = false;
 	struct iw_mlme *mlme = (struct iw_mlme *)extra;
 
-	if (ieee->link_state != RTLLIB_LINKED)
+	if (ieee->link_state != MAC80211_LINKED)
 		return -ENOLINK;
 
 	mutex_lock(&ieee->wx_mutex);
-- 
2.40.1

