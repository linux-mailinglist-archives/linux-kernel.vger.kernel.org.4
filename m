Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410B9734187
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbjFQN5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjFQN5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:57:43 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355552D50
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:57:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9877dfee81dso13741166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687010240; x=1689602240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMVVTdgUv6AYJZSJPcdnU5gv4Mtoi08C5m1hPrGDv9o=;
        b=pQi7cWG16wvjHcNDOkdA1lAC5WTuDEEPOs620xYRW0TK3ezqCzMdOU6YueRyxfB9OI
         r7ToJCByHqSzXGeAeUgI9fGYngr5VT5rIuanzti40T0wI1KkYTyc38ub+dsVQEkobFbo
         NFZzH9TMXAPF+siPjxbysYbnWUDPB/eAUGQchReAAOW9dyBi/R/RDWL5kNNsbbV73G6a
         ijxTxckwoWqVKsFkK/wz4PBzzkfoz9gdPKEzIb8mf31r7FqIIZG8qrIzKmBdBXeL7Tn+
         elY0CkYHkYzaOTNwUeRG6//I66P8ZhwP1M4A8nhG8TUh5XkTtvO+IZkRYbCGLX0KNQhL
         2pNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687010240; x=1689602240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMVVTdgUv6AYJZSJPcdnU5gv4Mtoi08C5m1hPrGDv9o=;
        b=F2hntKJAIZJvqtaLYnZauBMeWTUOWj/jElGkFxEv1cyys/Ii9nBcxpR941+khwd43E
         IG1ey3fkgBMeP0IBsVs/UXVE9iQRJjJvPBWZ1Q+isI+6piyVNteyjbtPncZyG4Izcmm7
         sdS93pbSkuNWIyKz7sfsoN9pg2RUpFB5pSTixvUplgjr9JxJka1tCWSW1UX9IUBRAifx
         apd/OFD05U+nu89ffkHY6sYbLUVEQbKM0kTLmNwDL3tuJDSbL6A7/r07Bpn/hJcQyChA
         9bYCztUV532vdbgIaOtjnC7cErs2mNsePxp4u7kusgMzI+eauOhjeALXePjuyO+RWcoO
         pTwg==
X-Gm-Message-State: AC+VfDzFZE9j2oatQlSbzHOeuL0+1OQej2CcYSYigjBtziOkyuhiNYrh
        nZrBBgsCiE9APG2S/Qtcz4YmfSg2nMs=
X-Google-Smtp-Source: ACHHUZ4HBGUeapiZCqdfAUN+MR2SdrWwcU9LX33V3qDim33G69YfVJcxAIi/6IQhv1A94ZLg2ORXSw==
X-Received: by 2002:a17:906:6493:b0:987:6960:36c5 with SMTP id e19-20020a170906649300b00987696036c5mr1352403ejm.6.1687010240035;
        Sat, 17 Jun 2023 06:57:20 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id s2-20020a170906960200b00982834553a6sm4382175ejx.165.2023.06.17.06.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 06:57:19 -0700 (PDT)
Date:   Sat, 17 Jun 2023 15:57:17 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] staging: rtl8192e: Rename state to link_state
Message-ID: <9cf4d0b01c6a84a11939099b628754d4c6d54839.1687007788.git.philipp.g.hortmann@gmail.com>
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

Rename state to link_state to align with rtlwifi driver and to
increase readability as state is to general.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Note: Special care must be taken because state is used in more than one
struct.
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 10 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 36 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 16 ++--
 .../staging/rtl8192e/rtl8192e/rtl_ethtool.c   |  4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    | 12 +--
 drivers/staging/rtl8192e/rtllib.h             |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c          | 14 ++--
 drivers/staging/rtl8192e/rtllib_softmac.c     | 82 +++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  | 16 ++--
 drivers/staging/rtl8192e/rtllib_wx.c          |  2 +-
 11 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index c20dfc81d549..b6c086047841 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -52,15 +52,15 @@ static void _rtl92e_update_msr(struct net_device *dev)
 
 	switch (priv->rtllib->iw_mode) {
 	case IW_MODE_INFRA:
-		if (priv->rtllib->state == RTLLIB_LINKED)
+		if (priv->rtllib->link_state == RTLLIB_LINKED)
 			msr |= MSR_LINK_MANAGED;
 		break;
 	case IW_MODE_ADHOC:
-		if (priv->rtllib->state == RTLLIB_LINKED)
+		if (priv->rtllib->link_state == RTLLIB_LINKED)
 			msr |= MSR_LINK_ADHOC;
 		break;
 	case IW_MODE_MASTER:
-		if (priv->rtllib->state == RTLLIB_LINKED)
+		if (priv->rtllib->link_state == RTLLIB_LINKED)
 			msr |= MSR_LINK_MASTER;
 		break;
 	default:
@@ -745,7 +745,7 @@ void rtl92e_link_change(struct net_device *dev)
 	if (!priv->up)
 		return;
 
-	if (ieee->state == RTLLIB_LINKED) {
+	if (ieee->link_state == RTLLIB_LINKED) {
 		_rtl92e_net_update(dev);
 		rtl92e_update_ratr_table(dev);
 		if ((ieee->pairwise_key_type == KEY_TYPE_WEP40) ||
@@ -760,7 +760,7 @@ void rtl92e_link_change(struct net_device *dev)
 		u32 reg;
 
 		reg = rtl92e_readl(dev, RCR);
-		if (priv->rtllib->state == RTLLIB_LINKED) {
+		if (priv->rtllib->link_state == RTLLIB_LINKED) {
 			if (ieee->intel_promiscuous_md_info.promiscuous_on)
 				;
 			else
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 777ee2509e7d..7b7500c6b181 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -169,7 +169,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 		    (priv->rtllib->iw_mode == IW_MODE_ADHOC)) {
 			if ((priv->rtllib->rf_off_reason > RF_CHANGE_BY_IPS) ||
 			    (change_source > RF_CHANGE_BY_IPS)) {
-				if (ieee->state == RTLLIB_LINKED)
+				if (ieee->link_state == RTLLIB_LINKED)
 					priv->blinked_ingpio = true;
 				else
 					priv->blinked_ingpio = false;
@@ -327,7 +327,7 @@ static void _rtl92e_qos_activate(void *data)
 	int i;
 
 	mutex_lock(&priv->mutex);
-	if (priv->rtllib->state != RTLLIB_LINKED)
+	if (priv->rtllib->link_state != RTLLIB_LINKED)
 		goto success;
 
 	for (i = 0; i <  QOS_QUEUE_NUM; i++)
@@ -344,7 +344,7 @@ static int _rtl92e_qos_handle_probe_response(struct r8192_priv *priv,
 	int ret = 0;
 	u32 size = sizeof(struct rtllib_qos_parameters);
 
-	if (priv->rtllib->state != RTLLIB_LINKED)
+	if (priv->rtllib->link_state != RTLLIB_LINKED)
 		return ret;
 
 	if (priv->rtllib->iw_mode != IW_MODE_INFRA)
@@ -400,7 +400,7 @@ static int _rtl92e_qos_assoc_resp(struct r8192_priv *priv,
 	if (!priv || !network)
 		return 0;
 
-	if (priv->rtllib->state != RTLLIB_LINKED)
+	if (priv->rtllib->link_state != RTLLIB_LINKED)
 		return 0;
 
 	if (priv->rtllib->iw_mode != IW_MODE_INFRA)
@@ -635,7 +635,7 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 	if (priv->polling_timer_on == 0)
 		rtl92e_check_rfctrl_gpio_timer(&priv->gpio_polling_timer);
 
-	if (priv->rtllib->state != RTLLIB_LINKED)
+	if (priv->rtllib->link_state != RTLLIB_LINKED)
 		rtllib_softmac_start_protocol(priv->rtllib, 0);
 	rtllib_reset_queue(priv->rtllib);
 	_rtl92e_watchdog_timer_cb(&priv->watch_dog_timer);
@@ -660,7 +660,7 @@ static int _rtl92e_sta_down(struct net_device *dev, bool shutdownrf)
 
 	priv->rtllib->rtllib_ips_leave(dev);
 
-	if (priv->rtllib->state == RTLLIB_LINKED)
+	if (priv->rtllib->link_state == RTLLIB_LINKED)
 		rtl92e_leisure_ps_leave(dev);
 
 	priv->up = 0;
@@ -1009,7 +1009,7 @@ static enum reset_type _rtl92e_if_check_reset(struct net_device *dev)
 
 	if (rfState == rf_on &&
 	    (priv->rtllib->iw_mode == IW_MODE_INFRA) &&
-	    (priv->rtllib->state == RTLLIB_LINKED))
+	    (priv->rtllib->link_state == RTLLIB_LINKED))
 		RxResetType = _rtl92e_rx_check_stuck(dev);
 
 	if (TxResetType == RESET_TYPE_NORMAL ||
@@ -1051,7 +1051,7 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 
 		mutex_lock(&priv->wx_mutex);
 
-		if (priv->rtllib->state == RTLLIB_LINKED)
+		if (priv->rtllib->link_state == RTLLIB_LINKED)
 			rtl92e_leisure_ps_leave(dev);
 
 		if (priv->up) {
@@ -1073,9 +1073,9 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 		rtl92e_dm_deinit(dev);
 		rtllib_stop_scan_syncro(ieee);
 
-		if (ieee->state == RTLLIB_LINKED) {
+		if (ieee->link_state == RTLLIB_LINKED) {
 			mutex_lock(&ieee->wx_mutex);
-			netdev_info(dev, "ieee->state is RTLLIB_LINKED\n");
+			netdev_info(dev, "ieee->link_state is RTLLIB_LINKED\n");
 			rtllib_stop_send_beacons(priv->rtllib);
 			del_timer_sync(&ieee->associate_timer);
 			cancel_delayed_work(&ieee->associate_retry_wq);
@@ -1083,7 +1083,7 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 			netif_carrier_off(dev);
 			mutex_unlock(&ieee->wx_mutex);
 		} else {
-			netdev_info(dev, "ieee->state is NOT LINKED\n");
+			netdev_info(dev, "ieee->link_state is NOT LINKED\n");
 			rtllib_softmac_stop_protocol(priv->rtllib, 0, true);
 		}
 
@@ -1110,14 +1110,14 @@ static void _rtl92e_if_silent_reset(struct net_device *dev)
 
 		rtl92e_enable_hw_security_config(dev);
 
-		if (ieee->state == RTLLIB_LINKED && ieee->iw_mode ==
+		if (ieee->link_state == RTLLIB_LINKED && ieee->iw_mode ==
 		    IW_MODE_INFRA) {
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel);
 
 			schedule_work(&ieee->associate_complete_wq);
 
-		} else if (ieee->state == RTLLIB_LINKED && ieee->iw_mode ==
+		} else if (ieee->link_state == RTLLIB_LINKED && ieee->iw_mode ==
 			   IW_MODE_ADHOC) {
 			ieee->set_chan(ieee->dev,
 				       ieee->current_network.channel);
@@ -1181,7 +1181,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	if (!priv->up || priv->hw_radio_off)
 		return;
 
-	if (priv->rtllib->state >= RTLLIB_LINKED) {
+	if (priv->rtllib->link_state >= RTLLIB_LINKED) {
 		if (priv->rtllib->CntAfterLink < 2)
 			priv->rtllib->CntAfterLink++;
 	} else {
@@ -1191,7 +1191,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	rtl92e_dm_watchdog(dev);
 
 	if (!rtllib_act_scanning(priv->rtllib, false)) {
-		if ((ieee->iw_mode == IW_MODE_INFRA) && (ieee->state ==
+		if ((ieee->iw_mode == IW_MODE_INFRA) && (ieee->link_state ==
 		     RTLLIB_NOLINK) &&
 		     (ieee->rf_power_state == rf_on) && !ieee->is_set_key &&
 		     (!ieee->proto_stoppping) && !ieee->wx_set_enc) {
@@ -1202,7 +1202,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 			}
 		}
 	}
-	if ((ieee->state == RTLLIB_LINKED) && (ieee->iw_mode ==
+	if ((ieee->link_state == RTLLIB_LINKED) && (ieee->iw_mode ==
 	     IW_MODE_INFRA) && (!ieee->net_promiscuous_md)) {
 		if (ieee->link_detect_info.NumRxOkInPeriod > 100 ||
 		ieee->link_detect_info.NumTxOkInPeriod > 100)
@@ -1244,7 +1244,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	ieee->link_detect_info.bHigherBusyTraffic = bHigherBusyTraffic;
 	ieee->link_detect_info.bHigherBusyRxTraffic = bHigherBusyRxTraffic;
 
-	if (ieee->state == RTLLIB_LINKED && ieee->iw_mode == IW_MODE_INFRA) {
+	if (ieee->link_state == RTLLIB_LINKED && ieee->iw_mode == IW_MODE_INFRA) {
 		u32	TotalRxBcnNum = 0;
 		u32	TotalRxDataNum = 0;
 
@@ -1263,7 +1263,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 				    "===>%s(): AP is power off, chan:%d, connect another one\n",
 				    __func__, priv->chan);
 
-			ieee->state = RTLLIB_ASSOCIATING;
+			ieee->link_state = RTLLIB_ASSOCIATING;
 
 			RemovePeerTS(priv->rtllib,
 				     priv->rtllib->current_network.bssid);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 70b7d7825c6d..74715e254df3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -291,7 +291,7 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 	if (priv->rtllib->mode != WIRELESS_MODE_N_24G)
 		return;
 
-	if (priv->rtllib->state == RTLLIB_LINKED) {
+	if (priv->rtllib->link_state == RTLLIB_LINKED) {
 		bshort_gi_enabled = (ht_info->cur_tx_bw40mhz &&
 				     ht_info->bCurShortGI40MHz) ||
 				    (!ht_info->cur_tx_bw40mhz &&
@@ -1075,7 +1075,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
 		dm_digtable.dig_state = DM_STA_DIG_OFF;
 	}
 
-	if (priv->rtllib->state == RTLLIB_LINKED)
+	if (priv->rtllib->link_state == RTLLIB_LINKED)
 		dm_digtable.cur_sta_connect_state = DIG_STA_CONNECT;
 	else
 		dm_digtable.cur_sta_connect_state = DIG_STA_DISCONNECT;
@@ -1105,7 +1105,7 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_false_alarm(struct net_device *dev)
 		dm_digtable.dig_algorithm_switch = 0;
 	}
 
-	if (priv->rtllib->state != RTLLIB_LINKED)
+	if (priv->rtllib->link_state != RTLLIB_LINKED)
 		return;
 
 	if ((priv->undecorated_smoothed_pwdb > dm_digtable.rssi_low_thresh) &&
@@ -1406,7 +1406,7 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 
 	if (priv->rtllib->iw_mode == IW_MODE_ADHOC)
 		goto dm_CheckEdcaTurbo_EXIT;
-	if (priv->rtllib->state != RTLLIB_LINKED)
+	if (priv->rtllib->link_state != RTLLIB_LINKED)
 		goto dm_CheckEdcaTurbo_EXIT;
 	if (priv->rtllib->ht_info->iot_action & HT_IOT_ACT_DISABLE_EDCA_TURBO)
 		goto dm_CheckEdcaTurbo_EXIT;
@@ -1820,7 +1820,7 @@ static void _rtl92e_dm_fsync_timer_callback(struct timer_list *t)
 	bool		bSwitchFromCountDiff = false;
 	bool		bDoubleTimeInterval = false;
 
-	if (priv->rtllib->state == RTLLIB_LINKED &&
+	if (priv->rtllib->link_state == RTLLIB_LINKED &&
 	    priv->rtllib->bfsync_enable &&
 	    (priv->rtllib->ht_info->iot_action & HT_IOT_ACT_CDD_FSYNC)) {
 		u32 rate_bitmap;
@@ -1990,7 +1990,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 	static u8 reg_c38_State = RegC38_Default;
 	static u32 reset_cnt;
 
-	if (priv->rtllib->state == RTLLIB_LINKED &&
+	if (priv->rtllib->link_state == RTLLIB_LINKED &&
 	    priv->rtllib->ht_info->IOTPeer == HT_IOT_PEER_BROADCOM) {
 		if (priv->rtllib->bfsync_enable == 0) {
 			switch (priv->rtllib->fsync_state) {
@@ -2043,7 +2043,7 @@ static void _rtl92e_dm_check_fsync(struct net_device *dev)
 			break;
 		}
 
-		if (priv->rtllib->state == RTLLIB_LINKED) {
+		if (priv->rtllib->link_state == RTLLIB_LINKED) {
 			if (priv->undecorated_smoothed_pwdb <=
 			    RegC38_TH) {
 				if (reg_c38_State !=
@@ -2112,7 +2112,7 @@ static void _rtl92e_dm_dynamic_tx_power(struct net_device *dev)
 		txlowpower_threshold = TX_POWER_NEAR_FIELD_THRESH_LOW;
 	}
 
-	if (priv->rtllib->state == RTLLIB_LINKED) {
+	if (priv->rtllib->link_state == RTLLIB_LINKED) {
 		if (priv->undecorated_smoothed_pwdb >= txhipower_threshold) {
 			priv->dynamic_tx_high_pwr = true;
 			priv->dynamic_tx_low_pwr = false;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
index f4f7b74c8cd1..543b0e9dfa88 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
@@ -27,8 +27,8 @@ static u32 _rtl92e_ethtool_get_link(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	return ((priv->rtllib->state == RTLLIB_LINKED) ||
-		(priv->rtllib->state == RTLLIB_LINKED_SCANNING));
+	return ((priv->rtllib->link_state == RTLLIB_LINKED) ||
+		(priv->rtllib->link_state == RTLLIB_LINKED_SCANNING));
 }
 
 const struct ethtool_ops rtl819x_ethtool_ops = {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 54a21c14cc75..bb52a595f75c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -118,7 +118,7 @@ void rtl92e_ips_enter(struct net_device *dev)
 
 	rt_state = priv->rtllib->rf_power_state;
 	if (rt_state == rf_on && !psc->bSwRfProcessing &&
-		(priv->rtllib->state != RTLLIB_LINKED) &&
+		(priv->rtllib->link_state != RTLLIB_LINKED) &&
 		(priv->rtllib->iw_mode != IW_MODE_MASTER)) {
 		psc->eInactivePowerState = rf_off;
 		_rtl92e_ps_update_rf_state(dev);
@@ -209,7 +209,7 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 					&priv->rtllib->pwr_save_ctrl;
 
 	if (!((priv->rtllib->iw_mode == IW_MODE_INFRA) &&
-	    (priv->rtllib->state == RTLLIB_LINKED))
+	    (priv->rtllib->link_state == RTLLIB_LINKED))
 	    || (priv->rtllib->iw_mode == IW_MODE_ADHOC) ||
 	    (priv->rtllib->iw_mode == IW_MODE_MASTER))
 		return;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 3346c4d72c3e..2d99badfb224 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -169,7 +169,7 @@ static int _rtl92e_wx_adapter_power_status(struct net_device *dev,
 		priv->ps_force = false;
 		psc->bLeisurePs = true;
 	} else {
-		if (priv->rtllib->state == RTLLIB_LINKED)
+		if (priv->rtllib->link_state == RTLLIB_LINKED)
 			rtl92e_leisure_ps_leave(dev);
 
 		priv->ps_force = true;
@@ -375,10 +375,10 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 	int ret;
 
 	if (!(ieee->softmac_features & IEEE_SOFTMAC_SCAN)) {
-		if ((ieee->state >= RTLLIB_ASSOCIATING) &&
-		    (ieee->state <= RTLLIB_ASSOCIATING_AUTHENTICATED))
+		if ((ieee->link_state >= RTLLIB_ASSOCIATING) &&
+		    (ieee->link_state <= RTLLIB_ASSOCIATING_AUTHENTICATED))
 			return 0;
-		if ((priv->rtllib->state == RTLLIB_LINKED) &&
+		if ((priv->rtllib->link_state == RTLLIB_LINKED) &&
 		    (priv->rtllib->CntAfterLink < 2))
 			return 0;
 	}
@@ -409,7 +409,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 
 	priv->rtllib->FirstIe_InScan = true;
 
-	if (priv->rtllib->state != RTLLIB_LINKED) {
+	if (priv->rtllib->link_state != RTLLIB_LINKED) {
 		if (rt_state == rf_off) {
 			if (priv->rtllib->rf_off_reason >
 			    RF_CHANGE_BY_IPS) {
@@ -1124,7 +1124,7 @@ static struct iw_statistics *_rtl92e_get_wireless_stats(struct net_device *dev)
 	int tmp_qual = 0;
 	int tmp_noise = 0;
 
-	if (ieee->state < RTLLIB_LINKED) {
+	if (ieee->link_state < RTLLIB_LINKED) {
 		wstats->qual.qual = 10;
 		wstats->qual.level = 0;
 		wstats->qual.noise = 0x100 - 100;	/* -100 dBm */
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 1aabbe11b484..933656e9fc8a 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1489,7 +1489,7 @@ struct rtllib_device {
 	 */
 	struct rtllib_network current_network;
 
-	enum rtl_link_state state;
+	enum rtl_link_state link_state;
 
 	int short_slot;
 	int mode;       /* A, B, G */
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 08782336d390..9beac92c613f 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1196,7 +1196,7 @@ static void rtllib_rx_check_leave_lps(struct rtllib_device *ieee, u8 unicast,
 				      u8 nr_subframes)
 {
 	if (unicast) {
-		if (ieee->state == RTLLIB_LINKED) {
+		if (ieee->link_state == RTLLIB_LINKED) {
 			if (((ieee->link_detect_info.NumRxUnicastOkInPeriod +
 			    ieee->link_detect_info.NumTxOkInPeriod) > 8) ||
 			    (ieee->link_detect_info.NumRxUnicastOkInPeriod > 2)) {
@@ -2117,7 +2117,7 @@ int rtllib_parse_info_param(struct rtllib_device *ieee,
 			network->tim.tim_period = info_element->data[1];
 
 			network->dtim_period = info_element->data[1];
-			if (ieee->state != RTLLIB_LINKED)
+			if (ieee->link_state != RTLLIB_LINKED)
 				break;
 			network->last_dtim_sta_time = jiffies;
 
@@ -2585,7 +2585,7 @@ static inline void rtllib_process_probe_response(
 				ieee->current_network.buseprotection = false;
 		}
 		if (is_beacon(frame_ctl)) {
-			if (ieee->state >= RTLLIB_LINKED)
+			if (ieee->link_state >= RTLLIB_LINKED)
 				ieee->link_detect_info.NumRecvBcnInPeriod++;
 		}
 	}
@@ -2643,7 +2643,7 @@ static inline void rtllib_process_probe_response(
 		    || ((ieee->current_network.ssid_len == network->ssid_len) &&
 		    (strncmp(ieee->current_network.ssid, network->ssid,
 		    network->ssid_len) == 0) &&
-		    (ieee->state == RTLLIB_NOLINK))))
+		    (ieee->link_state == RTLLIB_NOLINK))))
 			renew = 1;
 		update_network(ieee, target, network);
 		if (renew && (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE))
@@ -2654,7 +2654,7 @@ static inline void rtllib_process_probe_response(
 	if (is_beacon(frame_ctl) &&
 	    is_same_network(&ieee->current_network, network,
 	    (network->ssid_len ? 1 : 0)) &&
-	    (ieee->state == RTLLIB_LINKED)) {
+	    (ieee->link_state == RTLLIB_LINKED)) {
 		ieee->handle_beacon(ieee->dev, beacon, &ieee->current_network);
 	}
 free_network:
@@ -2683,7 +2683,7 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 
 		if (ieee->sta_sleep || (ieee->ps != RTLLIB_PS_DISABLED &&
 		    ieee->iw_mode == IW_MODE_INFRA &&
-		    ieee->state == RTLLIB_LINKED))
+		    ieee->link_state == RTLLIB_LINKED))
 			schedule_work(&ieee->ps_task);
 
 		break;
@@ -2700,7 +2700,7 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
 		    ((ieee->iw_mode == IW_MODE_ADHOC ||
 		    ieee->iw_mode == IW_MODE_MASTER) &&
-		    ieee->state == RTLLIB_LINKED))
+		    ieee->link_state == RTLLIB_LINKED))
 			rtllib_rx_probe_rq(ieee, skb);
 		break;
 	}
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 5609d1dbcf6a..242bb5c633e9 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -522,7 +522,7 @@ static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee, u8 is_mesh)
 		 * if the state become LINKED because of the #1 situation
 		 */
 
-		if (ieee->state == RTLLIB_LINKED)
+		if (ieee->link_state == RTLLIB_LINKED)
 			goto out;
 		if (ieee->sync_scan_hurryup) {
 			netdev_info(ieee->dev,
@@ -543,7 +543,7 @@ static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee, u8 is_mesh)
 	ieee->actscanning = false;
 	ieee->sync_scan_hurryup = 0;
 
-	if (ieee->state >= RTLLIB_LINKED) {
+	if (ieee->link_state >= RTLLIB_LINKED) {
 		if (IS_DOT11D_ENABLE(ieee))
 			dot11d_scan_complete(ieee);
 	}
@@ -1349,7 +1349,7 @@ static void rtllib_associate_abort(struct rtllib_device *ieee)
 	 * Here we will check if there are good nets to associate
 	 * with, so we retry or just get back to NO_LINK and scanning
 	 */
-	if (ieee->state == RTLLIB_ASSOCIATING_AUTHENTICATING) {
+	if (ieee->link_state == RTLLIB_ASSOCIATING_AUTHENTICATING) {
 		netdev_dbg(ieee->dev, "Authentication failed\n");
 		ieee->softmac_stats.no_auth_rs++;
 	} else {
@@ -1357,7 +1357,7 @@ static void rtllib_associate_abort(struct rtllib_device *ieee)
 		ieee->softmac_stats.no_ass_rs++;
 	}
 
-	ieee->state = RTLLIB_ASSOCIATING_RETRY;
+	ieee->link_state = RTLLIB_ASSOCIATING_RETRY;
 
 	schedule_delayed_work(&ieee->associate_retry_wq,
 			      RTLLIB_SOFTMAC_ASSOC_RETRY_TIME);
@@ -1386,7 +1386,7 @@ static void rtllib_associate_step1(struct rtllib_device *ieee, u8 *daddr)
 	if (!skb)
 		rtllib_associate_abort(ieee);
 	else {
-		ieee->state = RTLLIB_ASSOCIATING_AUTHENTICATING;
+		ieee->link_state = RTLLIB_ASSOCIATING_AUTHENTICATING;
 		netdev_dbg(ieee->dev, "Sending authentication request\n");
 		softmac_mgmt_xmit(skb, ieee);
 		if (!timer_pending(&ieee->associate_timer)) {
@@ -1508,7 +1508,7 @@ static void rtllib_associate_complete(struct rtllib_device *ieee)
 {
 	del_timer_sync(&ieee->associate_timer);
 
-	ieee->state = RTLLIB_LINKED;
+	ieee->link_state = RTLLIB_LINKED;
 	rtllib_sta_send_associnfo(ieee);
 
 	schedule_work(&ieee->associate_complete_wq);
@@ -1548,7 +1548,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 	/* we are interested in new only if we are not associated
 	 * and we are not associating / authenticating
 	 */
-	if (ieee->state != RTLLIB_NOLINK)
+	if (ieee->link_state != RTLLIB_NOLINK)
 		return;
 
 	if ((ieee->iw_mode == IW_MODE_INFRA) && !(net->capability &
@@ -1646,7 +1646,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 					ieee->ht_info->bCurrentHTSupport =
 								 false;
 
-				ieee->state = RTLLIB_ASSOCIATING;
+				ieee->link_state = RTLLIB_ASSOCIATING;
 				schedule_delayed_work(
 					   &ieee->associate_procedure_wq, 0);
 			} else {
@@ -1664,7 +1664,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 						    "Using B rates\n");
 				}
 				memset(ieee->dot11ht_oper_rate_set, 0, 16);
-				ieee->state = RTLLIB_LINKED;
+				ieee->link_state = RTLLIB_LINKED;
 			}
 		}
 	}
@@ -1682,7 +1682,7 @@ static void rtllib_softmac_check_all_nets(struct rtllib_device *ieee)
 		 * we had found what we are searching for
 		 */
 
-		if (ieee->state != RTLLIB_NOLINK)
+		if (ieee->link_state != RTLLIB_NOLINK)
 			break;
 
 		if (ieee->scan_age == 0 || time_after(target->last_scanned +
@@ -1985,7 +1985,7 @@ static inline void rtllib_sta_ps(struct work_struct *work)
 
 	if ((ieee->ps == RTLLIB_PS_DISABLED ||
 	     ieee->iw_mode != IW_MODE_INFRA ||
-	     ieee->state != RTLLIB_LINKED)) {
+	     ieee->link_state != RTLLIB_LINKED)) {
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 		rtllib_sta_wakeup(ieee, 1);
 
@@ -2139,7 +2139,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 		   WLAN_FC_GET_STYPE(frame_ctl));
 
 	if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
-	     ieee->state == RTLLIB_ASSOCIATING_AUTHENTICATED &&
+	     ieee->link_state == RTLLIB_ASSOCIATING_AUTHENTICATED &&
 	     (ieee->iw_mode == IW_MODE_INFRA)) {
 		errcode = assoc_parse(ieee, skb, &aid);
 		if (!errcode) {
@@ -2149,7 +2149,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 
 			if (!network)
 				return 1;
-			ieee->state = RTLLIB_LINKED;
+			ieee->link_state = RTLLIB_LINKED;
 			ieee->assoc_id = aid;
 			ieee->softmac_stats.rx_ass_ok++;
 			/* station support qos */
@@ -2218,7 +2218,7 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 	}
 
 	if (ieee->open_wep || !challenge) {
-		ieee->state = RTLLIB_ASSOCIATING_AUTHENTICATED;
+		ieee->link_state = RTLLIB_ASSOCIATING_AUTHENTICATED;
 		ieee->softmac_stats.rx_auth_rs_ok++;
 		if (!(ieee->ht_info->iot_action & HT_IOT_ACT_PURE_N_MODE)) {
 			if (!ieee->GetNmodeSupportBySecCfg(ieee->dev)) {
@@ -2258,7 +2258,7 @@ rtllib_rx_auth(struct rtllib_device *ieee, struct sk_buff *skb,
 	       struct rtllib_rx_stats *rx_stats)
 {
 	if (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) {
-		if (ieee->state == RTLLIB_ASSOCIATING_AUTHENTICATING &&
+		if (ieee->link_state == RTLLIB_ASSOCIATING_AUTHENTICATING &&
 		    (ieee->iw_mode == IW_MODE_INFRA)) {
 			netdev_dbg(ieee->dev,
 				   "Received authentication response");
@@ -2283,14 +2283,14 @@ rtllib_rx_deauth(struct rtllib_device *ieee, struct sk_buff *skb)
 	 * both for disassociation and deauthentication
 	 */
 	if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
-	    ieee->state == RTLLIB_LINKED &&
+	    ieee->link_state == RTLLIB_LINKED &&
 	    (ieee->iw_mode == IW_MODE_INFRA)) {
 		frame_ctl = le16_to_cpu(header->frame_ctl);
 		netdev_info(ieee->dev,
 			    "==========>received disassoc/deauth(%x) frame, reason code:%x\n",
 			    WLAN_FC_GET_STYPE(frame_ctl),
 			    ((struct rtllib_disassoc *)skb->data)->reason);
-		ieee->state = RTLLIB_ASSOCIATING;
+		ieee->link_state = RTLLIB_ASSOCIATING;
 		ieee->softmac_stats.reassoc++;
 		ieee->is_roaming = true;
 		ieee->link_detect_info.bBusyTraffic = false;
@@ -2458,7 +2458,7 @@ static void rtllib_start_master_bss(struct rtllib_device *ieee)
 	ether_addr_copy(ieee->current_network.bssid, ieee->dev->dev_addr);
 
 	ieee->set_chan(ieee->dev, ieee->current_network.channel);
-	ieee->state = RTLLIB_LINKED;
+	ieee->link_state = RTLLIB_LINKED;
 	ieee->link_change(ieee->dev);
 	notify_wx_assoc_event(ieee);
 	netif_carrier_on(ieee->dev);
@@ -2495,7 +2495,7 @@ static void rtllib_start_ibss_wq(void *data)
 		ieee->ssid_set = 1;
 	}
 
-	ieee->state = RTLLIB_NOLINK;
+	ieee->link_state = RTLLIB_NOLINK;
 	ieee->mode = WIRELESS_MODE_G;
 	/* check if we have this cell in our network list */
 	rtllib_softmac_check_all_nets(ieee);
@@ -2507,18 +2507,18 @@ static void rtllib_start_ibss_wq(void *data)
 	 * after setting ad-hoc mode. So we have to give another try..
 	 * Here, in ibss mode, should be safe to do this without extra care
 	 * (in bss mode we had to make sure no-one tried to associate when
-	 * we had just checked the ieee->state and we was going to start the
+	 * we had just checked the ieee->link_state and we was going to start the
 	 * scan) because in ibss mode the rtllib_new_net function, when
-	 * finds a good net, just set the ieee->state to RTLLIB_LINKED,
+	 * finds a good net, just set the ieee->link_state to RTLLIB_LINKED,
 	 * so, at worst, we waste a bit of time to initiate an unneeded syncro
 	 * scan, that will stop at the first round because it sees the state
 	 * associated.
 	 */
-	if (ieee->state == RTLLIB_NOLINK)
+	if (ieee->link_state == RTLLIB_NOLINK)
 		rtllib_start_scan_syncro(ieee, 0);
 
 	/* the network definitively is not here.. create a new cell */
-	if (ieee->state == RTLLIB_NOLINK) {
+	if (ieee->link_state == RTLLIB_NOLINK) {
 		netdev_info(ieee->dev, "creating new IBSS cell\n");
 		ieee->current_network.channel = ieee->bss_start_channel;
 		if (!ieee->wap_set)
@@ -2579,9 +2579,9 @@ static void rtllib_start_ibss_wq(void *data)
 		ieee->ht_info->bCurrentHTSupport = false;
 
 	ieee->SetHwRegHandler(ieee->dev, HW_VAR_MEDIA_STATUS,
-			      (u8 *)(&ieee->state));
+			      (u8 *)(&ieee->link_state));
 
-	ieee->state = RTLLIB_LINKED;
+	ieee->link_state = RTLLIB_LINKED;
 	ieee->link_change(ieee->dev);
 
 	HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
@@ -2615,7 +2615,7 @@ static void rtllib_start_bss(struct rtllib_device *ieee)
 	rtllib_softmac_check_all_nets(ieee);
 
 	/* ensure no-one start an associating process (thus setting
-	 * the ieee->state to rtllib_ASSOCIATING) while we
+	 * the ieee->link_state to rtllib_ASSOCIATING) while we
 	 * have just checked it and we are going to enable scan.
 	 * The rtllib_new_net function is always called with
 	 * lock held (from both rtllib_softmac_check_all_nets and
@@ -2623,7 +2623,7 @@ static void rtllib_start_bss(struct rtllib_device *ieee)
 	 */
 	spin_lock_irqsave(&ieee->lock, flags);
 
-	if (ieee->state == RTLLIB_NOLINK)
+	if (ieee->link_state == RTLLIB_NOLINK)
 		rtllib_start_scan(ieee);
 	spin_unlock_irqrestore(&ieee->lock, flags);
 }
@@ -2643,7 +2643,7 @@ void rtllib_disassociate(struct rtllib_device *ieee)
 
 	if (IS_DOT11D_ENABLE(ieee))
 		dot11d_reset(ieee);
-	ieee->state = RTLLIB_NOLINK;
+	ieee->link_state = RTLLIB_NOLINK;
 	ieee->is_set_key = false;
 	ieee->wap_set = 0;
 
@@ -2662,13 +2662,13 @@ static void rtllib_associate_retry_wq(void *data)
 	if (!ieee->proto_started)
 		goto exit;
 
-	if (ieee->state != RTLLIB_ASSOCIATING_RETRY)
+	if (ieee->link_state != RTLLIB_ASSOCIATING_RETRY)
 		goto exit;
 
 	/* until we do not set the state to RTLLIB_NOLINK
 	 * there are no possibility to have someone else trying
 	 * to start an association procedure (we get here with
-	 * ieee->state = RTLLIB_ASSOCIATING).
+	 * ieee->link_state = RTLLIB_ASSOCIATING).
 	 * When we set the state to RTLLIB_NOLINK it is possible
 	 * that the RX path run an attempt to associate, but
 	 * both rtllib_softmac_check_all_nets and the
@@ -2679,13 +2679,13 @@ static void rtllib_associate_retry_wq(void *data)
 	 * state and we are going to start the scan.
 	 */
 	ieee->beinretry = true;
-	ieee->state = RTLLIB_NOLINK;
+	ieee->link_state = RTLLIB_NOLINK;
 
 	rtllib_softmac_check_all_nets(ieee);
 
 	spin_lock_irqsave(&ieee->lock, flags);
 
-	if (ieee->state == RTLLIB_NOLINK)
+	if (ieee->link_state == RTLLIB_NOLINK)
 		rtllib_start_scan(ieee);
 	spin_unlock_irqrestore(&ieee->lock, flags);
 
@@ -2762,10 +2762,10 @@ void rtllib_stop_protocol(struct rtllib_device *ieee, u8 shutdown)
 	cancel_delayed_work_sync(&ieee->link_change_wq);
 	rtllib_stop_scan(ieee);
 
-	if (ieee->state <= RTLLIB_ASSOCIATING_AUTHENTICATED)
-		ieee->state = RTLLIB_NOLINK;
+	if (ieee->link_state <= RTLLIB_ASSOCIATING_AUTHENTICATED)
+		ieee->link_state = RTLLIB_NOLINK;
 
-	if (ieee->state == RTLLIB_LINKED) {
+	if (ieee->link_state == RTLLIB_LINKED) {
 		if (ieee->iw_mode == IW_MODE_INFRA)
 			SendDisassociation(ieee, 1, WLAN_REASON_DEAUTH_LEAVING);
 		rtllib_disassociate(ieee);
@@ -2845,7 +2845,7 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 
 	memset(&ieee->current_network, 0, sizeof(struct rtllib_network));
 
-	ieee->state = RTLLIB_NOLINK;
+	ieee->link_state = RTLLIB_NOLINK;
 	for (i = 0; i < 5; i++)
 		ieee->seq_ctrl[i] = 0;
 	ieee->dot11d_info = kzalloc(sizeof(struct rt_dot11d_info), GFP_ATOMIC);
@@ -3036,7 +3036,7 @@ static void rtllib_MgntDisconnectIBSS(struct rtllib_device *rtllib)
 	u8	i;
 	bool	bFilterOutNonAssociatedBSSID = false;
 
-	rtllib->state = RTLLIB_NOLINK;
+	rtllib->link_state = RTLLIB_NOLINK;
 
 	for (i = 0; i < 6; i++)
 		rtllib->current_network.bssid[i] = 0x55;
@@ -3063,7 +3063,7 @@ static void rtllib_MlmeDisassociateRequest(struct rtllib_device *rtllib,
 	RemovePeerTS(rtllib, asSta);
 
 	if (memcmp(rtllib->current_network.bssid, asSta, 6) == 0) {
-		rtllib->state = RTLLIB_NOLINK;
+		rtllib->link_state = RTLLIB_NOLINK;
 
 		for (i = 0; i < 6; i++)
 			rtllib->current_network.bssid[i] = 0x22;
@@ -3092,7 +3092,7 @@ rtllib_MgntDisconnectAP(
 	rtllib_MlmeDisassociateRequest(rtllib, rtllib->current_network.bssid,
 				       asRsn);
 
-	rtllib->state = RTLLIB_NOLINK;
+	rtllib->link_state = RTLLIB_NOLINK;
 }
 
 bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn)
@@ -3100,7 +3100,7 @@ bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn)
 	if (rtllib->ps != RTLLIB_PS_DISABLED)
 		rtllib->sta_wake_up(rtllib->dev);
 
-	if (rtllib->state == RTLLIB_LINKED) {
+	if (rtllib->link_state == RTLLIB_LINKED) {
 		if (rtllib->iw_mode == IW_MODE_ADHOC)
 			rtllib_MgntDisconnectIBSS(rtllib);
 		if (rtllib->iw_mode == IW_MODE_INFRA)
@@ -3119,7 +3119,7 @@ void notify_wx_assoc_event(struct rtllib_device *ieee)
 		return;
 
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
-	if (ieee->state == RTLLIB_LINKED)
+	if (ieee->link_state == RTLLIB_LINKED)
 		memcpy(wrqu.ap_addr.sa_data, ieee->current_network.bssid,
 		       ETH_ALEN);
 	else {
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index 8f2f0dca88e7..8e101b63ec75 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -53,7 +53,7 @@ int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
 
 		if (ieee->iw_mode == IW_MODE_ADHOC ||
 		    ieee->iw_mode == IW_MODE_MASTER)
-			if (ieee->state == RTLLIB_LINKED) {
+			if (ieee->link_state == RTLLIB_LINKED) {
 				rtllib_stop_send_beacons(ieee);
 				rtllib_start_send_beacons(ieee);
 			}
@@ -95,8 +95,8 @@ int rtllib_wx_get_wap(struct rtllib_device *ieee,
 	/* We want avoid to give to the user inconsistent infos*/
 	spin_lock_irqsave(&ieee->lock, flags);
 
-	if (ieee->state != RTLLIB_LINKED &&
-		ieee->state != RTLLIB_LINKED_SCANNING &&
+	if (ieee->link_state != RTLLIB_LINKED &&
+		ieee->link_state != RTLLIB_LINKED_SCANNING &&
 		ieee->wap_set == 0)
 
 		eth_zero_addr(wrqu->ap_addr.sa_data);
@@ -184,8 +184,8 @@ int rtllib_wx_get_essid(struct rtllib_device *ieee, struct iw_request_info *a,
 		goto out;
 	}
 
-	if (ieee->state != RTLLIB_LINKED &&
-		ieee->state != RTLLIB_LINKED_SCANNING &&
+	if (ieee->link_state != RTLLIB_LINKED &&
+		ieee->link_state != RTLLIB_LINKED_SCANNING &&
 		ieee->ssid_set == 0) {
 		ret = -1;
 		goto out;
@@ -323,7 +323,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 
 	rtllib_stop_all_queues(ieee);
 	rtllib_stop_send_beacons(ieee);
-	ieee->state = RTLLIB_LINKED_SCANNING;
+	ieee->link_state = RTLLIB_LINKED_SCANNING;
 	ieee->link_change(ieee->dev);
 	/* wait for ps packet to be kicked out successfully */
 	msleep(50);
@@ -355,7 +355,7 @@ void rtllib_wx_sync_scan_wq(void *data)
 
 	ieee->ScanOperationBackupHandler(ieee->dev, SCAN_OPT_RESTORE);
 
-	ieee->state = RTLLIB_LINKED;
+	ieee->link_state = RTLLIB_LINKED;
 	ieee->link_change(ieee->dev);
 
 	/* Notify AP that I wake up again */
@@ -385,7 +385,7 @@ int rtllib_wx_set_scan(struct rtllib_device *ieee, struct iw_request_info *a,
 		goto out;
 	}
 
-	if (ieee->state == RTLLIB_LINKED) {
+	if (ieee->link_state == RTLLIB_LINKED) {
 		schedule_work(&ieee->wx_sync_scan_wq);
 		/* intentionally forget to up sem */
 		return 0;
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 184eba571741..a82fd64dbdce 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -619,7 +619,7 @@ int rtllib_wx_set_mlme(struct rtllib_device *ieee,
 	bool deauth = false;
 	struct iw_mlme *mlme = (struct iw_mlme *)extra;
 
-	if (ieee->state != RTLLIB_LINKED)
+	if (ieee->link_state != RTLLIB_LINKED)
 		return -ENOLINK;
 
 	mutex_lock(&ieee->wx_mutex);
-- 
2.40.1

