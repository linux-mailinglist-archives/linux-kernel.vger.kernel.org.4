Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18253626DB7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 05:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiKMEhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 23:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiKMEge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 23:36:34 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E887912D18
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:36:11 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id y16so11599681wrt.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 20:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Waj2wVmJ6VIMUK7fVeeqwrsUbV46YA2aMojAJKw2kw=;
        b=jAAncIEP9n9rJ2pamz3EV6edyGp/ejCVX6op+UL3/q6bf7W5nucjG7Ur3/JaWTHPuI
         ijwKa7d67fjHAp9VIg9WFWifdzX535UqLbNjZI9ooseVITX7qTLqmwFbnK4rqUzTcSoP
         zC+ES5BLt0G2/KNBxoKYTeQQI9ewHK0hG8fFeu1OXelPkXCka+wdWcikYKcPIBoEiO9m
         uHLyawXlTrUEb5skzPAMffmPe8V5ph+jyAPMae9/I86iq3yG2o0IJzcPxEeY7tIFkmD8
         JYgLkzVhfbTkUnox+glZPd+2048yf5zk0trhRwrLNKRaeDgXCw9erjBUc+ki0gtOY972
         Lfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Waj2wVmJ6VIMUK7fVeeqwrsUbV46YA2aMojAJKw2kw=;
        b=goTUuwF0xfgOYjxv4MmMoN6SpiLFPbqxfwNxT07aGj3tQrP02YQgWGA/QPigk+meup
         2EpwlnNICmkPfT+/snDW8+A+ypEZGZL7HeVItPBePS2LFg+5xM2tKpgMf0mqNk3Hq4Z0
         fV7vdUsb93EwrClXHlDXHWu0GuwNVsuNkQuOB45Z7Wzt3h6P0cJu3pKC/CpmCPHeDi8e
         M16A7MpnvCAjH53OOD5JZJPFCYlR1KHvkj4vCbWdf5RVYoQNFqfxTzO/CQvgB2n1o5ge
         JtGBUyoZ9JazN7YzCo3BUaBlYPTp8dgx7x8lORP+nqDV7QsWJq4rPO3lhHvl1H0O5KHX
         NdQQ==
X-Gm-Message-State: ANoB5plFwN3qCFMzF70CYaw9K44qh6PqslSO4ggU+B0WzUKbie2PBE2T
        nclID3liG8n0OPy8Ga76ep8=
X-Google-Smtp-Source: AA0mqf6DhB+2BZOgiK2HVr1gVinRB4aH7sc2Kmdz8/0CIUyXHC9GLAxQ0JKAwTCk0tAwy+jxzbGEfA==
X-Received: by 2002:a5d:6e0d:0:b0:236:71c3:bf36 with SMTP id h13-20020a5d6e0d000000b0023671c3bf36mr4353232wrz.184.1668314171252;
        Sat, 12 Nov 2022 20:36:11 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c4f4900b003b3307fb98fsm9086747wmq.24.2022.11.12.20.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:36:10 -0800 (PST)
Date:   Sun, 13 Nov 2022 05:36:09 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] staging: rtl8192e: Rename InterruptLog, RxCounter and
 bHwRfOffAction
Message-ID: <82ea07ddd894ac9b863ce90ddb9ba78065bd1f4e.1668313325.git.philipp.g.hortmann@gmail.com>
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

Rename variable InterruptLog to int_log, RxCounter to rx_ctr and
bHwRfOffAction to hw_rf_off_action to avoid CamelCase which is not
accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 0eeb9b2daefc..e530f917fd23 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1928,7 +1928,7 @@ void rtl92e_stop_adapter(struct net_device *dev, bool reset)
 	if (!reset) {
 		mdelay(150);
 
-		priv->bHwRfOffAction = 2;
+		priv->hw_rf_off_action = 2;
 
 		if (!priv->rtllib->bSupportRemoteWakeUp) {
 			rtl92e_set_rf_off(dev);
@@ -2129,7 +2129,7 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 
 	SlotIndex = (priv->SilentResetRxSlotIndex++)%SilentResetRxSoltNum;
 
-	if (priv->RxCounter == RegRxCounter) {
+	if (priv->rx_ctr == RegRxCounter) {
 		priv->SilentResetRxStuckEvent[SlotIndex] = 1;
 
 		for (i = 0; i < SilentResetRxSoltNum; i++)
@@ -2147,7 +2147,7 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 		priv->SilentResetRxStuckEvent[SlotIndex] = 0;
 	}
 
-	priv->RxCounter = RegRxCounter;
+	priv->rx_ctr = RegRxCounter;
 
 	return bStuck;
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index ac3c7f047ca2..a813eded4cb3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1342,7 +1342,7 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 				mdelay(1);
 				rtl92e_set_bb_reg(dev, rFPGA0_AnalogParameter1,
 						 0x4, 0x1);
-				priv->bHwRfOffAction = 0;
+				priv->hw_rf_off_action = 0;
 
 				rtl92e_set_bb_reg(dev, rFPGA0_XA_RFInterfaceOE,
 						  BIT4, 0x1);
@@ -1450,7 +1450,7 @@ bool rtl92e_set_rf_power_state(struct net_device *dev,
 	bool bResult = false;
 
 	if (rf_power_state == priv->rtllib->rf_power_state &&
-	    priv->bHwRfOffAction == 0) {
+	    priv->hw_rf_off_action == 0) {
 		return bResult;
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 1c4985dcc5eb..43601ec8d903 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -869,13 +869,13 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->force_reset = false;
 	memset(priv->rtllib->swcamtable, 0, sizeof(struct sw_cam_table) * 32);
 
-	memset(&priv->InterruptLog, 0, sizeof(struct log_int_8190));
-	priv->RxCounter = 0;
+	memset(&priv->int_log, 0, sizeof(struct log_int_8190));
+	priv->rx_ctr = 0;
 	priv->rtllib->wx_set_enc = 0;
 	priv->hw_radio_off = false;
 	priv->rtllib->rf_off_reason = 0;
 	priv->rf_change_in_progress = false;
-	priv->bHwRfOffAction = 0;
+	priv->hw_rf_off_action = 0;
 	priv->SetRFPowerStateInProgress = false;
 	priv->rtllib->pwr_save_ctrl.bLeisurePs = true;
 	priv->rtllib->LPSDelayCnt = 0;
@@ -2189,7 +2189,7 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 
 	if (inta & IMR_ROK) {
 		priv->stats.rxint++;
-		priv->InterruptLog.nIMR_ROK++;
+		priv->int_log.nIMR_ROK++;
 		tasklet_schedule(&priv->irq_rx_tasklet);
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index dfbc9fbcc129..b1656d4ecbad 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -330,7 +330,7 @@ struct r8192_priv {
 
 	struct work_struct				reset_wq;
 
-	struct log_int_8190 InterruptLog;
+	struct log_int_8190 int_log;
 
 	enum rt_customer_id CustomerID;
 
@@ -469,7 +469,7 @@ struct r8192_priv {
 
 	u16 reg_chnl_plan;
 	u16 ChannelPlan;
-	u8 bHwRfOffAction;
+	u8 hw_rf_off_action;
 
 	bool rf_change_in_progress;
 	bool SetRFPowerStateInProgress;
@@ -538,7 +538,7 @@ struct r8192_priv {
 
 	enum reset_type rst_progress;
 	u16		TxCounter;
-	u16		RxCounter;
+	u16		rx_ctr;
 	bool		bResetInProgress;
 	bool		force_reset;
 	bool		force_lps;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 234e85a25d45..e0f6f1405c17 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1693,7 +1693,7 @@ static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
 
 	if (bActuallySet) {
 		mdelay(1000);
-		priv->bHwRfOffAction = 1;
+		priv->hw_rf_off_action = 1;
 		rtl92e_set_rf_state(dev, rf_power_state_to_set, RF_CHANGE_BY_HW);
 		if (priv->hw_radio_off)
 			argv[1] = "RFOFF";
-- 
2.37.3

