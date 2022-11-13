Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680F2626DB0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 05:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiKMEfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 23:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiKMEfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 23:35:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDAA13CF3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:35:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso5550501wmo.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/o6EraAMHRFczQfa/cndaMxG5eJqM4XVYqY/gLHBFE=;
        b=O0j/ndj4Q6/BRI+wENUeg9dUFH0gzI5urlQjcsjzDPJxheO8771IGfBo1eBFvW+i4R
         1JQaeM0Mc4hZ3yX8yLCJ4+s1HPIL3Z1emofsHQtURufs2wHyceL8pfQUhJLnQzp/cpz9
         6S60LCJvdIaGCif5eMbSLGlhjxYbhXdAJvNqC81bEgCIiKIWfQIrswcvQjx8wNlAu8is
         JVA60/N0PvkuOtnafY8ZNIGyQ35W4gN/ttJGYt54k05it5ohHALRJHZqpT30vjJLGJ0y
         zqsP9Z822qWrfcohaUgo+JJYJuapviax2JoS3nxvqxvEFgYmbx+UwPyJwODHajmApjsw
         eEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/o6EraAMHRFczQfa/cndaMxG5eJqM4XVYqY/gLHBFE=;
        b=nGPOy0teIaTLvliCIyYamu07G5rohGNT76ujMBtSsh09TVZe1X5BHHi7BqnfYpM91y
         kIGOVTEpGIZ7fwFE2VEsqJodSGkep8lrwLUcotlpfHI6Uonm53EHgEshJ14PiwMz7kG5
         udAdoGuRbomy/efeCOYQxATAjL/rYO5zm0/lQTpYRbqTF5QD7XFAjvejY5qj0EJDn7qZ
         qlWtiYZGxVpoo/Lqu+GRD+yE9dt8XfTSqnB9Z1aeZS6eyguodnbPJ5XmUfKpRVXj2FRD
         nXzDo93OZmUcKVi42cWTYgn1DYRAIEQBpL3o/Tf1vZAlCHlx8iPuflxKbNbpDTuLofvE
         lCtg==
X-Gm-Message-State: ANoB5pklKSvPHW8azHKzHg+4Vde412ntmUbkS4Y/sZo2cNBlLnDa4K+t
        7edPujP67plb8ddyVD+aPGY=
X-Google-Smtp-Source: AA0mqf4HwOlEt7Ph+7yaJWMCwU+h25eLl56zG2E48mghbCuCKPuwIG83eLzhOhnanu2uKMq0uGgkbQ==
X-Received: by 2002:a05:600c:1c0a:b0:3cf:84e9:e722 with SMTP id j10-20020a05600c1c0a00b003cf84e9e722mr4868314wms.8.1668314114031;
        Sat, 12 Nov 2022 20:35:14 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id i17-20020adfefd1000000b00236b2804d79sm6047007wrp.2.2022.11.12.20.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:35:13 -0800 (PST)
Date:   Sun, 13 Nov 2022 05:35:12 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] staging: rtl8192e: Rename Regdot11HTOper..,
 bSupportM.. and PowerSaveCo..
Message-ID: <1ef7fd22b4a037c4d1f8685065ce7916b6f0930b.1668313325.git.philipp.g.hortmann@gmail.com>
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

Rename variable Regdot11HTOperationalRateSet to
reg_dot11ht_oper_rate_set, bSupportMode to support_mode and
PowerSaveControl to pwr_save_ctrl to avoid CamelCase which is not accepted
by checkpatch. Fix unnecessary parentheses warning from checkpatch when
used with this variables.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 30 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    | 10 +++----
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  4 +--
 drivers/staging/rtl8192e/rtl819x_HTProc.c     |  2 +-
 drivers/staging/rtl8192e/rtllib.h             |  4 +--
 drivers/staging/rtl8192e/rtllib_softmac.c     | 10 +++----
 7 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 58da2dab55bd..b14497423cbf 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1304,7 +1304,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
-					(&(priv->rtllib->PowerSaveControl));
+					(&priv->rtllib->pwr_save_ctrl);
 	bool bResult = true;
 	u8	i = 0, QueueID = 0;
 	struct rtl8192_tx_ring  *ring = NULL;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 952fe8d7a7be..16e15b8e1b7a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -607,13 +607,13 @@ static void _rtl92e_refresh_support_rate(struct r8192_priv *priv)
 
 	if (ieee->mode == WIRELESS_MODE_N_24G ||
 	    ieee->mode == WIRELESS_MODE_N_5G) {
-		memcpy(ieee->Regdot11HTOperationalRateSet,
+		memcpy(ieee->reg_dot11ht_oper_rate_set,
 		       ieee->RegHTSuppRateSet, 16);
 		memcpy(ieee->Regdot11TxHTOperationalRateSet,
 		       ieee->RegHTSuppRateSet, 16);
 
 	} else {
-		memset(ieee->Regdot11HTOperationalRateSet, 0, 16);
+		memset(ieee->reg_dot11ht_oper_rate_set, 0, 16);
 	}
 }
 
@@ -642,19 +642,19 @@ static u8 _rtl92e_get_supported_wireless_mode(struct net_device *dev)
 void rtl92e_set_wireless_mode(struct net_device *dev, u8 wireless_mode)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
-	u8 bSupportMode = _rtl92e_get_supported_wireless_mode(dev);
+	u8 support_mode = _rtl92e_get_supported_wireless_mode(dev);
 
 	if ((wireless_mode == WIRELESS_MODE_AUTO) ||
-	    ((wireless_mode & bSupportMode) == 0)) {
-		if (bSupportMode & WIRELESS_MODE_N_24G) {
+	    ((wireless_mode & support_mode) == 0)) {
+		if (support_mode & WIRELESS_MODE_N_24G) {
 			wireless_mode = WIRELESS_MODE_N_24G;
-		} else if (bSupportMode & WIRELESS_MODE_N_5G) {
+		} else if (support_mode & WIRELESS_MODE_N_5G) {
 			wireless_mode = WIRELESS_MODE_N_5G;
-		} else if ((bSupportMode & WIRELESS_MODE_A)) {
+		} else if ((support_mode & WIRELESS_MODE_A)) {
 			wireless_mode = WIRELESS_MODE_A;
-		} else if ((bSupportMode & WIRELESS_MODE_G)) {
+		} else if ((support_mode & WIRELESS_MODE_G)) {
 			wireless_mode = WIRELESS_MODE_G;
-		} else if ((bSupportMode & WIRELESS_MODE_B)) {
+		} else if ((support_mode & WIRELESS_MODE_B)) {
 			wireless_mode = WIRELESS_MODE_B;
 		} else {
 			netdev_info(dev,
@@ -683,7 +683,7 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
-					(&priv->rtllib->PowerSaveControl);
+					(&priv->rtllib->pwr_save_ctrl);
 	bool init_status;
 
 	priv->bdisable_nic = false;
@@ -820,7 +820,7 @@ static void _rtl92e_init_priv_constant(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
-					&priv->rtllib->PowerSaveControl;
+					&priv->rtllib->pwr_save_ctrl;
 
 	pPSC->reg_max_lps_awake_intvl = 5;
 }
@@ -877,7 +877,7 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rf_change_in_progress = false;
 	priv->bHwRfOffAction = 0;
 	priv->SetRFPowerStateInProgress = false;
-	priv->rtllib->PowerSaveControl.bLeisurePs = true;
+	priv->rtllib->pwr_save_ctrl.bLeisurePs = true;
 	priv->rtllib->LPSDelayCnt = 0;
 	priv->rtllib->sta_sleep = LPS_IS_WAKE;
 	priv->rtllib->rf_power_state = rf_on;
@@ -1272,7 +1272,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	static u8 check_reset_cnt;
 	unsigned long flags;
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
-					(&priv->rtllib->PowerSaveControl);
+					(&priv->rtllib->pwr_save_ctrl);
 	bool bBusyTraffic = false;
 	bool	bHigherBusyTraffic = false;
 	bool	bHigherBusyRxTraffic = false;
@@ -1295,7 +1295,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		     RTLLIB_NOLINK) &&
 		     (ieee->rf_power_state == rf_on) && !ieee->is_set_key &&
 		     (!ieee->proto_stoppping) && !ieee->wx_set_enc) {
-			if ((ieee->PowerSaveControl.ReturnPoint ==
+			if ((ieee->pwr_save_ctrl.ReturnPoint ==
 			     IPS_CALLBACK_NONE) &&
 			     (!ieee->bNetPromiscuousMode)) {
 				rtl92e_ips_enter(dev);
@@ -2422,7 +2422,7 @@ bool rtl92e_enable_nic(struct net_device *dev)
 	bool init_status = true;
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
-					(&priv->rtllib->PowerSaveControl);
+					(&priv->rtllib->pwr_save_ctrl);
 
 	if (!priv->up) {
 		netdev_warn(dev, "%s(): Driver is already down!\n", __func__);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 1501f7be8eee..8a6b7f58ebfd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -101,7 +101,7 @@ static void _rtl92e_ps_update_rf_state(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
-					&(priv->rtllib->PowerSaveControl);
+					&priv->rtllib->pwr_save_ctrl;
 
 	pPSC->bSwRfProcessing = true;
 	rtl92e_set_rf_state(dev, pPSC->eInactivePowerState, RF_CHANGE_BY_IPS);
@@ -113,7 +113,7 @@ void rtl92e_ips_enter(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
-					&(priv->rtllib->PowerSaveControl);
+					&priv->rtllib->pwr_save_ctrl;
 	enum rt_rf_power_state rt_state;
 
 	rt_state = priv->rtllib->rf_power_state;
@@ -129,7 +129,7 @@ void rtl92e_ips_leave(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
-					&(priv->rtllib->PowerSaveControl);
+					&priv->rtllib->pwr_save_ctrl;
 	enum rt_rf_power_state rt_state;
 
 	rt_state = priv->rtllib->rf_power_state;
@@ -207,7 +207,7 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
-					&(priv->rtllib->PowerSaveControl);
+					&priv->rtllib->pwr_save_ctrl;
 
 	if (!((priv->rtllib->iw_mode == IW_MODE_INFRA) &&
 	    (priv->rtllib->state == RTLLIB_LINKED))
@@ -233,7 +233,7 @@ void rtl92e_leisure_ps_leave(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
-					&(priv->rtllib->PowerSaveControl);
+					&priv->rtllib->pwr_save_ctrl;
 
 	if (pPSC->bLeisurePs) {
 		if (priv->rtllib->ps != RTLLIB_PS_DISABLED) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index ffef63e8dcae..d68f8f5902c8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -160,7 +160,7 @@ static int _rtl92e_wx_adapter_power_status(struct net_device *dev,
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
-					(&priv->rtllib->PowerSaveControl);
+					(&priv->rtllib->pwr_save_ctrl);
 	struct rtllib_device *ieee = priv->rtllib;
 
 	mutex_lock(&priv->wx_mutex);
@@ -189,7 +189,7 @@ static int _rtl92e_wx_set_lps_awake_interval(struct net_device *dev,
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
-					(&priv->rtllib->PowerSaveControl);
+					(&priv->rtllib->pwr_save_ctrl);
 
 	mutex_lock(&priv->wx_mutex);
 
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 7fad983ad4be..52f41562dd82 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -323,7 +323,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 		pCapELE->MPDUDensity	= 0;
 	}
 
-	memcpy(pCapELE->MCS, ieee->Regdot11HTOperationalRateSet, 16);
+	memcpy(pCapELE->MCS, ieee->reg_dot11ht_oper_rate_set, 16);
 	memset(&pCapELE->ExtHTCapInfo, 0, 2);
 	memset(pCapELE->TxBFCap, 0, 4);
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ca9e016ffa9f..d80883b211ce 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1435,7 +1435,7 @@ struct rtllib_device {
 	struct rt_hi_throughput *pHTInfo;
 
 	spinlock_t reorder_spinlock;
-	u8	Regdot11HTOperationalRateSet[16];
+	u8	reg_dot11ht_oper_rate_set[16];
 	u8	Regdot11TxHTOperationalRateSet[16];
 	u8	dot11HTOperationalRateSet[16];
 	u8	RegHTSuppRateSet[16];
@@ -1645,7 +1645,7 @@ struct rtllib_device {
 
 	struct rt_link_detect LinkDetectInfo;
 	bool bIsAggregateFrame;
-	struct rt_pwr_save_ctrl PowerSaveControl;
+	struct rt_pwr_save_ctrl pwr_save_ctrl;
 
 	/* used if IEEE_SOFTMAC_TX_QUEUE is set */
 	struct tx_pending tx_pending;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 604d4fd7e2cd..498febc88b15 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1504,7 +1504,7 @@ static void rtllib_associate_complete_wq(void *data)
 				     container_of_work_rsl(data,
 				     struct rtllib_device,
 				     associate_complete_wq);
-	struct rt_pwr_save_ctrl *pPSC = &(ieee->PowerSaveControl);
+	struct rt_pwr_save_ctrl *pPSC = &ieee->pwr_save_ctrl;
 
 	netdev_info(ieee->dev, "Associated successfully with %pM\n",
 		    ieee->current_network.bssid);
@@ -1960,7 +1960,7 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 {
 	int timeout;
 	u8 dtim;
-	struct rt_pwr_save_ctrl *pPSC = &(ieee->PowerSaveControl);
+	struct rt_pwr_save_ctrl *pPSC = &ieee->pwr_save_ctrl;
 
 	if (ieee->LPSDelayCnt) {
 		ieee->LPSDelayCnt--;
@@ -2984,9 +2984,9 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	ieee->ps = RTLLIB_PS_DISABLED;
 	ieee->sta_sleep = LPS_IS_WAKE;
 
-	ieee->Regdot11HTOperationalRateSet[0] = 0xff;
-	ieee->Regdot11HTOperationalRateSet[1] = 0xff;
-	ieee->Regdot11HTOperationalRateSet[4] = 0x01;
+	ieee->reg_dot11ht_oper_rate_set[0] = 0xff;
+	ieee->reg_dot11ht_oper_rate_set[1] = 0xff;
+	ieee->reg_dot11ht_oper_rate_set[4] = 0x01;
 
 	ieee->Regdot11TxHTOperationalRateSet[0] = 0xff;
 	ieee->Regdot11TxHTOperationalRateSet[1] = 0xff;
-- 
2.37.3

