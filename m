Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904B65E903B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 00:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiIXWDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 18:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIXWDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 18:03:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E0D33350
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:03:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id 13so7168764ejn.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=RWP+wPM99hQVxgyz83xLNtYO23yw8YqASQDEQXbGrw4=;
        b=ZDQU8Xz7zJzUjzZXw6hZsiR6gkl61F+r4yCIleou4af4W1fiV1xEHleHi+1W8W4Uqc
         nVc63IM5euec58gVrw+oCOLPt6f8hA+fK2TdgkNgCmCj2t5BSK+4+AZgEIepg33lG+7R
         REB6AMqfnHcIzKG5vcQeeUaJKhUVTeu1MhagSzO7pMyxZi+8wQSVHuaFXwbT+5n9X+R3
         JM+PBi2OHxvko+q6pENK8yCeR53qj0WVuBAxEYLHj6JBp5CJZxZJjgW5wNKywN3yAOhz
         POCH++pt2NS+0yQQn22DHohKWAj7EYmiP2Sq4Nr6wJvTHLyO/KjJsS1Xqe7LCJ1oC/qi
         DZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RWP+wPM99hQVxgyz83xLNtYO23yw8YqASQDEQXbGrw4=;
        b=JfSSRjtQglZfpOlMgYXIi0ScYNOFIFKqqBC7aAtyuLXsW9fVYYpkxJbxOnLTDUqgjg
         8c/XwNXJrY3LtEUp3T1qFnCS/7/sGE94lt10b5iEMGsxV2wOXFvalyGw4PyX1TNryABm
         8mOgKqfdAUMDB/icFMo03b/At7qoo7mHAcluUgiR3TpNJ+oUWgaAonvnk44gxOd/Tvyr
         xXBoO70Kq+digbpmdyylbG+YRB03ZRCTaJh4fKxPvjKjrLN9nmlXOuFZ05PS6arlSP8x
         3fPk0uiqixmC7LxYd2ZW45VREV1mzOJDQy0O9gB2kiqgSMwd+urOnI1p3K/TuLio3Lph
         9/qA==
X-Gm-Message-State: ACrzQf1rSyDa9fGDrlVZNfKj/sKVUgY3qp6LF8y+ldzvVilVMpP0CrL1
        Dm3PjeTmI1fSZHaC0xuqi7E=
X-Google-Smtp-Source: AMsMyM632cg6jU8oHCPWqGfofWarR90yzcqMqEUh0JEkV+OvjQXJjFgIaa2Gk385GOlqiIESEYZa1Q==
X-Received: by 2002:a17:906:cc17:b0:781:d78b:e2d3 with SMTP id ml23-20020a170906cc1700b00781d78be2d3mr12787214ejb.83.1664056990082;
        Sat, 24 Sep 2022 15:03:10 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id y17-20020a056402171100b00456f2dbb379sm2219657edu.62.2022.09.24.15.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 15:03:09 -0700 (PDT)
Date:   Sun, 25 Sep 2022 00:03:07 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] staging: rtl8192e: Rename eRFPowerState, eRfOff and
 eRfOn
Message-ID: <52c676bbaf1f894e30971c5c409b4bcb71c8ef7e.1664055213.git.philipp.g.hortmann@gmail.com>
References: <cover.1664055213.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664055213.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable eRFPowerState to rf_power_state, eRfOff to rf_off and
eRfOn to rf_on to avoid CamelCase which is not accepted by checkpatch.
Omit the upfront "e" as no RFPowerState, RfOff and RfOn exist and it
makes the variables unnecessary long.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 10 +++----
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 26 +++++++++----------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   |  4 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 26 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  8 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c    |  4 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    | 18 ++++++-------
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    | 12 ++++-----
 drivers/staging/rtl8192e/rtllib.h             |  6 ++---
 drivers/staging/rtl8192e/rtllib_softmac.c     |  6 ++---
 11 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 5832ccdb4e50..cb8b5fd7ab86 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -625,7 +625,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	priv->pFirmware->status = FW_STATUS_0_INIT;
 
 	if (priv->RegRfOff)
-		priv->rtllib->eRFPowerState = eRfOff;
+		priv->rtllib->rf_power_state = rf_off;
 
 	ulRegRead = rtl92e_readl(dev, CPU_GEN);
 	if (priv->pFirmware->status == FW_STATUS_0_INIT)
@@ -757,13 +757,13 @@ bool rtl92e_start_adapter(struct net_device *dev)
 	rtl92e_writeb(dev, 0x87, 0x0);
 
 	if (priv->RegRfOff) {
-		rtl92e_set_rf_state(dev, eRfOff, RF_CHANGE_BY_SW);
+		rtl92e_set_rf_state(dev, rf_off, RF_CHANGE_BY_SW);
 	} else if (priv->rtllib->RfOffReason > RF_CHANGE_BY_PS) {
-		rtl92e_set_rf_state(dev, eRfOff, priv->rtllib->RfOffReason);
+		rtl92e_set_rf_state(dev, rf_off, priv->rtllib->RfOffReason);
 	} else if (priv->rtllib->RfOffReason >= RF_CHANGE_BY_IPS) {
-		rtl92e_set_rf_state(dev, eRfOff, priv->rtllib->RfOffReason);
+		rtl92e_set_rf_state(dev, rf_off, priv->rtllib->RfOffReason);
 	} else {
-		priv->rtllib->eRFPowerState = eRfOn;
+		priv->rtllib->rf_power_state = rf_on;
 		priv->rtllib->RfOffReason = 0;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index d1c4d44bfc87..c81907d31af8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -200,7 +200,7 @@ void rtl92e_set_rf_reg(struct net_device *dev, enum rf90_radio_path eRFPath,
 
 	if (!rtl92e_is_legal_rf_path(dev, eRFPath))
 		return;
-	if (priv->rtllib->eRFPowerState != eRfOn && !priv->being_init_adapter)
+	if (priv->rtllib->rf_power_state != rf_on && !priv->being_init_adapter)
 		return;
 
 	if (priv->Rf_Mode == RF_OP_By_FW) {
@@ -237,7 +237,7 @@ u32 rtl92e_get_rf_reg(struct net_device *dev, enum rf90_radio_path eRFPath,
 
 	if (!rtl92e_is_legal_rf_path(dev, eRFPath))
 		return 0;
-	if (priv->rtllib->eRFPowerState != eRfOn && !priv->being_init_adapter)
+	if (priv->rtllib->rf_power_state != rf_on && !priv->being_init_adapter)
 		return	0;
 	mutex_lock(&priv->rf_mutex);
 	if (priv->Rf_Mode == RF_OP_By_FW) {
@@ -1301,7 +1301,7 @@ void rtl92e_set_rf_off(struct net_device *dev)
 }
 
 static bool _rtl92e_set_rf_power_state(struct net_device *dev,
-				       enum rt_rf_power_state eRFPowerState)
+				       enum rt_rf_power_state rf_power_state)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_pwr_save_ctrl *pPSC = (struct rt_pwr_save_ctrl *)
@@ -1316,9 +1316,9 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 
 	switch (priv->rf_chip) {
 	case RF_8256:
-		switch (eRFPowerState) {
-		case eRfOn:
-			if ((priv->rtllib->eRFPowerState == eRfOff) &&
+		switch (rf_power_state) {
+		case rf_on:
+			if ((priv->rtllib->rf_power_state == rf_off) &&
 			     RT_IN_PS_LEVEL(pPSC, RT_RF_OFF_LEVL_HALT_NIC)) {
 				bool rtstatus;
 				u32 InitilizeCount = 3;
@@ -1364,7 +1364,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 			break;
 
 		case eRfSleep:
-			if (priv->rtllib->eRFPowerState == eRfOff)
+			if (priv->rtllib->rf_power_state == rf_off)
 				break;
 
 
@@ -1386,7 +1386,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 			rtl92e_set_rf_off(dev);
 			break;
 
-		case eRfOff:
+		case rf_off:
 			for (QueueID = 0, i = 0; QueueID < MAX_TX_QUEUE; ) {
 				ring = &priv->tx_ring[QueueID];
 
@@ -1418,7 +1418,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 			bResult = false;
 			netdev_warn(dev,
 				    "%s(): Unknown state requested: 0x%X.\n",
-				    __func__, eRFPowerState);
+				    __func__, rf_power_state);
 			break;
 		}
 
@@ -1430,7 +1430,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 	}
 
 	if (bResult) {
-		priv->rtllib->eRFPowerState = eRFPowerState;
+		priv->rtllib->rf_power_state = rf_power_state;
 
 		switch (priv->rf_chip) {
 		case RF_8256:
@@ -1447,18 +1447,18 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 }
 
 bool rtl92e_set_rf_power_state(struct net_device *dev,
-			       enum rt_rf_power_state eRFPowerState)
+			       enum rt_rf_power_state rf_power_state)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	bool bResult = false;
 
-	if (eRFPowerState == priv->rtllib->eRFPowerState &&
+	if (rf_power_state == priv->rtllib->rf_power_state &&
 	    priv->bHwRfOffAction == 0) {
 		return bResult;
 	}
 
-	bResult = _rtl92e_set_rf_power_state(dev, eRFPowerState);
+	bResult = _rtl92e_set_rf_power_state(dev, rf_power_state);
 	return bResult;
 }
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 7f2a24b72e52..e89c9ac90989 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -82,7 +82,7 @@ void rtl92e_init_gain(struct net_device *dev, u8 Operation);
 void rtl92e_set_rf_off(struct net_device *dev);
 
 bool rtl92e_set_rf_power_state(struct net_device *dev,
-			       enum rt_rf_power_state eRFPowerState);
+			       enum rt_rf_power_state rf_power_state);
 
 void rtl92e_scan_op_backup(struct net_device *dev, u8 Operation);
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index 8dba8606bda1..5faf17d8d536 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -80,9 +80,9 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 	enum rt_rf_power_state rt_state;
 
-	rt_state = priv->rtllib->eRFPowerState;
+	rt_state = priv->rtllib->rf_power_state;
 	if (priv->rtllib->PowerSaveControl.bInactivePs) {
-		if (rt_state == eRfOff) {
+		if (rt_state == rf_off) {
 			if (priv->rtllib->RfOffReason > RF_CHANGE_BY_IPS) {
 				netdev_warn(dev, "%s(): RF is OFF.\n",
 					    __func__);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 671fe547639b..8954d1e4534c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -166,10 +166,10 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 		}
 	}
 
-	rt_state = priv->rtllib->eRFPowerState;
+	rt_state = priv->rtllib->rf_power_state;
 
 	switch (state_to_set) {
-	case eRfOn:
+	case rf_on:
 		priv->rtllib->RfOffReason &= (~change_source);
 
 		if ((change_source == RF_CHANGE_BY_HW) && priv->hw_radio_off)
@@ -179,13 +179,13 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 			priv->rtllib->RfOffReason = 0;
 			action_allowed = true;
 
-			if (rt_state == eRfOff &&
+			if (rt_state == rf_off &&
 			    change_source >= RF_CHANGE_BY_HW)
 				connect_by_ssid = true;
 		}
 		break;
 
-	case eRfOff:
+	case rf_off:
 
 		if ((priv->rtllib->iw_mode == IW_MODE_INFRA) ||
 		    (priv->rtllib->iw_mode == IW_MODE_ADHOC)) {
@@ -216,7 +216,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 
 	if (action_allowed) {
 		rtl92e_set_rf_power_state(dev, state_to_set);
-		if (state_to_set == eRfOn) {
+		if (state_to_set == rf_on) {
 			if (connect_by_ssid && priv->blinked_ingpio) {
 				schedule_delayed_work(
 					 &ieee->associate_procedure_wq, 0);
@@ -892,7 +892,7 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rtllib->PowerSaveControl.bFwCtrlLPS = false;
 	priv->rtllib->LPSDelayCnt = 0;
 	priv->rtllib->sta_sleep = LPS_IS_WAKE;
-	priv->rtllib->eRFPowerState = eRfOn;
+	priv->rtllib->rf_power_state = rf_on;
 
 	priv->rtllib->current_network.beacon_interval = DEFAULT_BEACONINTERVAL;
 	priv->rtllib->iw_mode = IW_MODE_INFRA;
@@ -1114,12 +1114,12 @@ static enum reset_type _rtl92e_if_check_reset(struct net_device *dev)
 	enum reset_type RxResetType = RESET_TYPE_NORESET;
 	enum rt_rf_power_state rfState;
 
-	rfState = priv->rtllib->eRFPowerState;
+	rfState = priv->rtllib->rf_power_state;
 
-	if (rfState == eRfOn)
+	if (rfState == rf_on)
 		TxResetType = _rtl92e_tx_check_stuck(dev);
 
-	if (rfState == eRfOn &&
+	if (rfState == rf_on &&
 	    (priv->rtllib->iw_mode == IW_MODE_INFRA) &&
 	    (priv->rtllib->state == RTLLIB_LINKED))
 		RxResetType = _rtl92e_rx_check_stuck(dev);
@@ -1307,7 +1307,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	if (!rtllib_act_scanning(priv->rtllib, false)) {
 		if ((ieee->iw_mode == IW_MODE_INFRA) && (ieee->state ==
 		     RTLLIB_NOLINK) &&
-		     (ieee->eRFPowerState == eRfOn) && !ieee->is_set_key &&
+		     (ieee->rf_power_state == rf_on) && !ieee->is_set_key &&
 		     (!ieee->proto_stoppping) && !ieee->wx_set_enc) {
 			if ((ieee->PowerSaveControl.ReturnPoint ==
 			     IPS_CALLBACK_NONE) &&
@@ -1370,7 +1370,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 			priv->check_roaming_cnt = 0;
 
 		if (priv->check_roaming_cnt > 0) {
-			if (ieee->eRFPowerState == eRfOff)
+			if (ieee->rf_power_state == rf_off)
 				netdev_info(dev, "%s(): RF is off\n", __func__);
 
 			netdev_info(dev,
@@ -1507,7 +1507,7 @@ static void _rtl92e_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
 				    MAX_DEV_ADDR_SIZE);
 	u8 queue_index = tcb_desc->queue_index;
 
-	if ((priv->rtllib->eRFPowerState == eRfOff) || !priv->up ||
+	if ((priv->rtllib->rf_power_state == rf_off) || !priv->up ||
 	     priv->bResetInProgress) {
 		kfree_skb(skb);
 		return;
@@ -1540,7 +1540,7 @@ static int _rtl92e_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	u8 queue_index = tcb_desc->queue_index;
 
 	if (queue_index != TXCMD_QUEUE) {
-		if ((priv->rtllib->eRFPowerState == eRfOff) ||
+		if ((priv->rtllib->rf_power_state == rf_off) ||
 		     !priv->up || priv->bResetInProgress) {
 			kfree_skb(skb);
 			return 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 6d09b71d4993..92bf4bac31f1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -648,7 +648,7 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 					rtl92e_writeb(dev, FW_Busy_Flag, 0);
 					return;
 				}
-				if (priv->rtllib->eRFPowerState != eRfOn) {
+				if (priv->rtllib->rf_power_state != rf_on) {
 					rtl92e_writeb(dev, Pw_Track_Flag, 0);
 					rtl92e_writeb(dev, FW_Busy_Flag, 0);
 					return;
@@ -1684,13 +1684,13 @@ static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
 
 	tmp1byte = rtl92e_readb(dev, GPI);
 
-	eRfPowerStateToSet = (tmp1byte&BIT1) ?  eRfOn : eRfOff;
+	eRfPowerStateToSet = (tmp1byte&BIT1) ?  rf_on : rf_off;
 
-	if (priv->hw_radio_off && (eRfPowerStateToSet == eRfOn)) {
+	if (priv->hw_radio_off && (eRfPowerStateToSet == rf_on)) {
 		netdev_info(dev, "gpiochangeRF  - HW Radio ON\n");
 		priv->hw_radio_off = false;
 		bActuallySet = true;
-	} else if (!priv->hw_radio_off && (eRfPowerStateToSet == eRfOff)) {
+	} else if (!priv->hw_radio_off && (eRfPowerStateToSet == rf_off)) {
 		netdev_info(dev, "gpiochangeRF  - HW Radio OFF\n");
 		priv->hw_radio_off = true;
 		bActuallySet = true;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
index ced00de89114..82b45c61ac75 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
@@ -32,7 +32,7 @@ int rtl92e_suspend(struct device *dev_d)
 	netif_device_detach(dev);
 
 	if (!priv->rtllib->bSupportRemoteWakeUp) {
-		rtl92e_set_rf_state(dev, eRfOff, RF_CHANGE_BY_INIT);
+		rtl92e_set_rf_state(dev, rf_off, RF_CHANGE_BY_INIT);
 		ulRegRead = rtl92e_readl(dev, CPU_GEN);
 		ulRegRead |= CPU_GEN_SYSTEM_RESET;
 		rtl92e_writel(dev, CPU_GEN, ulRegRead);
@@ -83,7 +83,7 @@ int rtl92e_resume(struct device *dev_d)
 		dev->netdev_ops->ndo_open(dev);
 
 	if (!priv->rtllib->bSupportRemoteWakeUp)
-		rtl92e_set_rf_state(dev, eRfOn, RF_CHANGE_BY_INIT);
+		rtl92e_set_rf_state(dev, rf_on, RF_CHANGE_BY_INIT);
 
 out:
 	return 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index d752bbc310d1..b43454320606 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -51,7 +51,7 @@ void rtl92e_hw_wakeup(struct net_device *dev)
 		return;
 	}
 	spin_unlock_irqrestore(&priv->rf_ps_lock, flags);
-	rtl92e_set_rf_state(dev, eRfOn, RF_CHANGE_BY_PS);
+	rtl92e_set_rf_state(dev, rf_on, RF_CHANGE_BY_PS);
 }
 
 void rtl92e_hw_wakeup_wq(void *data)
@@ -117,11 +117,11 @@ void rtl92e_ips_enter(struct net_device *dev)
 	enum rt_rf_power_state rt_state;
 
 	if (pPSC->bInactivePs) {
-		rt_state = priv->rtllib->eRFPowerState;
-		if (rt_state == eRfOn && !pPSC->bSwRfProcessing &&
+		rt_state = priv->rtllib->rf_power_state;
+		if (rt_state == rf_on && !pPSC->bSwRfProcessing &&
 			(priv->rtllib->state != RTLLIB_LINKED) &&
 			(priv->rtllib->iw_mode != IW_MODE_MASTER)) {
-			pPSC->eInactivePowerState = eRfOff;
+			pPSC->eInactivePowerState = rf_off;
 			priv->isRFOff = true;
 			priv->bInPowerSaveMode = true;
 			_rtl92e_ps_update_rf_state(dev);
@@ -137,10 +137,10 @@ void rtl92e_ips_leave(struct net_device *dev)
 	enum rt_rf_power_state rt_state;
 
 	if (pPSC->bInactivePs) {
-		rt_state = priv->rtllib->eRFPowerState;
-		if (rt_state != eRfOn  && !pPSC->bSwRfProcessing &&
+		rt_state = priv->rtllib->rf_power_state;
+		if (rt_state != rf_on  && !pPSC->bSwRfProcessing &&
 		    priv->rtllib->RfOffReason <= RF_CHANGE_BY_IPS) {
-			pPSC->eInactivePowerState = eRfOn;
+			pPSC->eInactivePowerState = rf_on;
 			priv->bInPowerSaveMode = false;
 			_rtl92e_ps_update_rf_state(dev);
 		}
@@ -164,10 +164,10 @@ void rtl92e_rtllib_ips_leave_wq(struct net_device *dev)
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 	enum rt_rf_power_state rt_state;
 
-	rt_state = priv->rtllib->eRFPowerState;
+	rt_state = priv->rtllib->rf_power_state;
 
 	if (priv->rtllib->PowerSaveControl.bInactivePs) {
-		if (rt_state == eRfOff) {
+		if (rt_state == rf_off) {
 			if (priv->rtllib->RfOffReason > RF_CHANGE_BY_IPS) {
 				netdev_warn(dev, "%s(): RF is OFF.\n",
 					    __func__);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index bfb963768fc3..4c9ff1b1dfe1 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -248,12 +248,12 @@ static int _rtl92e_wx_set_mode(struct net_device *dev,
 
 	if (priv->hw_radio_off)
 		return 0;
-	rt_state = priv->rtllib->eRFPowerState;
+	rt_state = priv->rtllib->rf_power_state;
 	mutex_lock(&priv->wx_mutex);
 	if (wrqu->mode == IW_MODE_ADHOC || wrqu->mode == IW_MODE_MONITOR ||
 	    ieee->bNetPromiscuousMode) {
 		if (priv->rtllib->PowerSaveControl.bInactivePs) {
-			if (rt_state == eRfOff) {
+			if (rt_state == rf_off) {
 				if (priv->rtllib->RfOffReason >
 				    RF_CHANGE_BY_IPS) {
 					netdev_warn(dev, "%s(): RF is OFF.\n",
@@ -392,7 +392,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 			    __func__);
 		return 0;
 	}
-	rt_state = priv->rtllib->eRFPowerState;
+	rt_state = priv->rtllib->rf_power_state;
 	if (!priv->up)
 		return -ENETDOWN;
 	if (priv->rtllib->LinkDetectInfo.bBusyTraffic == true)
@@ -415,7 +415,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 
 	if (priv->rtllib->state != RTLLIB_LINKED) {
 		if (priv->rtllib->PowerSaveControl.bInactivePs) {
-			if (rt_state == eRfOff) {
+			if (rt_state == rf_off) {
 				if (priv->rtllib->RfOffReason >
 				    RF_CHANGE_BY_IPS) {
 					netdev_warn(dev, "%s(): RF is OFF.\n",
@@ -433,7 +433,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 			priv->rtllib->LedControlHandler(dev,
 							 LED_CTL_SITE_SURVEY);
 
-		if (priv->rtllib->eRFPowerState != eRfOff) {
+		if (priv->rtllib->rf_power_state != rf_off) {
 			priv->rtllib->actscanning = true;
 
 			if (ieee->ScanOperationBackupHandler)
@@ -487,7 +487,7 @@ static int _rtl92e_wx_set_essid(struct net_device *dev,
 
 	if (priv->hw_radio_off) {
 		netdev_info(dev,
-			    "=========>%s():hw radio off,or Rf state is eRfOff, return\n",
+			    "=========>%s():hw radio off,or Rf state is rf_off, return\n",
 			    __func__);
 		return 0;
 	}
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b4b606f552fb..6b5c5962ae14 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1244,9 +1244,9 @@ enum ips_callback_function {
 };
 
 enum rt_rf_power_state {
-	eRfOn,
+	rf_on,
 	eRfSleep,
-	eRfOff
+	rf_off
 };
 
 struct rt_pwr_save_ctrl {
@@ -1434,7 +1434,7 @@ struct rtllib_device {
 	bool FirstIe_InScan;
 	bool be_scan_inprogress;
 	bool beinretry;
-	enum rt_rf_power_state eRFPowerState;
+	enum rt_rf_power_state rf_power_state;
 	RT_RF_CHANGE_SOURCE	RfOffReason;
 	bool is_set_key;
 	bool wx_set_enc;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index e4f5f4ecf4d0..9a5dd031d3ff 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -586,9 +586,9 @@ static void rtllib_softmac_scan_wq(void *data)
 
 	mutex_lock(&ieee->scan_mutex);
 
-	if (ieee->eRFPowerState == eRfOff) {
+	if (ieee->rf_power_state == rf_off) {
 		netdev_info(ieee->dev,
-			    "======>%s():rf state is eRfOff, return\n",
+			    "======>%s():rf state is rf_off, return\n",
 			    __func__);
 		goto out1;
 	}
@@ -1585,7 +1585,7 @@ static void rtllib_associate_procedure_wq(void *data)
 
 	rtllib_stop_scan(ieee);
 	HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
-	if (ieee->eRFPowerState == eRfOff) {
+	if (ieee->rf_power_state == rf_off) {
 		if (ieee->rtllib_ips_leave_wq != NULL)
 			ieee->rtllib_ips_leave_wq(ieee->dev);
 		mutex_unlock(&ieee->wx_mutex);
-- 
2.37.3

