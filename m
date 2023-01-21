Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D946769B2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 22:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjAUVpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 16:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjAUVp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 16:45:28 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40C428844
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:45:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q5so3024073wrv.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 13:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vx5DSmr5lxiARhdcInV5kBQVKTGumAreM6/77gMk5Q=;
        b=NYqxFwmMFi55/wN5xzVXFQr9rFmK0pvxpTENnmcWmqFN2T5kanNE6fpfB4EVBATjZ/
         bWpr/Xtue1/20LK/GBLns8y2nnOgCREwH3OqeA/TXxjpSxgkjKGqLl+k1KAkAe0DzjXY
         wz7UkrEZRJA9CkEwbWaOb9dd1/oWbsSfexOo4h2z22eJgYRyU+qeKRd1Cft9cHsBVNzZ
         LU66XQjVQ9yrktaBgYg/y9LG0iN+NsuUD8ecIxFyd/BYwzd/3y77ubSsah5JIccH0xk6
         9edButdmPEUKSuAhf+jPlX5WLh9R/6cvttGdSJesaOXyJtro33Vm3+rO+L+EHz12jmpJ
         OSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Vx5DSmr5lxiARhdcInV5kBQVKTGumAreM6/77gMk5Q=;
        b=F5TZpR1QerZUKISxdgfgJb6uGZ7X6aVfgpjcGjHLI+bYbIN0dOEh4iXGxFRQR/7mfH
         N4OWx/n1vX2MADI3SGZZCCESWCvO3wO39DaXJgw3pMhSGt7WzfZhgQ+RNeDdvnW7IrAE
         IngorGaWkccy4TF0tq6xNo5AInXFvdF0feASZ+ag+e/ny70C01jRVB1Q4ovli4f1sko8
         xrOp+sw0doVgciAfO1lMd+XfGKyaP2XPe/p1wNLnZ3y6H4KMrxdgI5Hdw2zyEMBImG2f
         uccr6graXsQNckytJP3R1hBsmiH32y7/ayt81ZLwMiHDdgdbZ/t7CfZWoV7XsJoG8TJZ
         qk8A==
X-Gm-Message-State: AFqh2kqnlqV1NFyuMSXESnhNd6Rg7MhwHQHcR58tDh1FRUzo1qc6MzMn
        WVuHcsk9+P6+KSVwebpz0Aw=
X-Google-Smtp-Source: AMrXdXtmsf6qVmtghFPEzqERxS3oXnXFsy8wzNRBO1n+Xc3iJ2vrvHK4W43gpcnBrz64eep2+fr3HQ==
X-Received: by 2002:a5d:4b47:0:b0:2bf:9437:30f0 with SMTP id w7-20020a5d4b47000000b002bf943730f0mr877365wrs.2.1674337513323;
        Sat, 21 Jan 2023 13:45:13 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id r11-20020adff70b000000b002bdf290efdasm16266776wrp.58.2023.01.21.13.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:45:12 -0800 (PST)
Date:   Sat, 21 Jan 2023 22:45:11 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: rtl8192e: Rename btxpower_trackin..,
 Slide_Beaco.. and Slide_B..
Message-ID: <b722cd913d04d07ac1952da2add2a16cfeb2dc8c.1674336211.git.philipp.g.hortmann@gmail.com>
References: <cover.1674336211.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674336211.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable btxpower_trackingInit to tx_pwr_tracking_init,
Slide_Beacon_pwdb to slide_beacon_pwdb and Slide_Beacon_Total to
slide_beacon_total to avoid CamelCase which is not accepted by
checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 10 +++++-----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 10 +++++-----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 6c570582479d..9260d308e68b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1574,17 +1574,17 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 		    PHY_Beacon_RSSI_SLID_WIN_MAX) {
 			slide_beacon_adc_pwdb_statistics =
 					 PHY_Beacon_RSSI_SLID_WIN_MAX;
-			last_beacon_adc_pwdb = priv->stats.Slide_Beacon_pwdb
+			last_beacon_adc_pwdb = priv->stats.slide_beacon_pwdb
 					       [slide_beacon_adc_pwdb_index];
-			priv->stats.Slide_Beacon_Total -= last_beacon_adc_pwdb;
+			priv->stats.slide_beacon_total -= last_beacon_adc_pwdb;
 		}
-		priv->stats.Slide_Beacon_Total += prev_st->RxPWDBAll;
-		priv->stats.Slide_Beacon_pwdb[slide_beacon_adc_pwdb_index] =
+		priv->stats.slide_beacon_total += prev_st->RxPWDBAll;
+		priv->stats.slide_beacon_pwdb[slide_beacon_adc_pwdb_index] =
 							 prev_st->RxPWDBAll;
 		slide_beacon_adc_pwdb_index++;
 		if (slide_beacon_adc_pwdb_index >= PHY_Beacon_RSSI_SLID_WIN_MAX)
 			slide_beacon_adc_pwdb_index = 0;
-		prev_st->RxPWDBAll = priv->stats.Slide_Beacon_Total /
+		prev_st->RxPWDBAll = priv->stats.slide_beacon_total /
 				     slide_beacon_adc_pwdb_statistics;
 		if (prev_st->RxPWDBAll >= 3)
 			prev_st->RxPWDBAll -= 3;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 55a68bbe3861..983bc663a570 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -229,8 +229,8 @@ struct rt_stats {
 	u8 rx_rssi_percentage[4];
 	u8 rx_evm_percentage[2];
 	long rxSNRdB[4];
-	u32 Slide_Beacon_pwdb[100];
-	u32 Slide_Beacon_Total;
+	u32 slide_beacon_pwdb[100];
+	u32 slide_beacon_total;
 	u32	CurrentShowTxate;
 };
 
@@ -481,7 +481,7 @@ struct r8192_priv {
 	bool		bcck_in_ch14;
 
 	u8		txpower_count;
-	bool		btxpower_trackingInit;
+	bool		tx_pwr_tracking_init;
 
 	u8		ofdm_index[2];
 	u8		cck_index;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index ba92dab682ec..79f993ab7cee 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -768,7 +768,7 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 	u8 tmpOFDMindex, tmpCCKindex, tmpCCK20Mindex, tmpCCK40Mindex, tmpval;
 	int i = 0, CCKSwingNeedUpdate = 0;
 
-	if (!priv->btxpower_trackingInit) {
+	if (!priv->tx_pwr_tracking_init) {
 		tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
 					    bMaskDWord);
 		for (i = 0; i < OFDM_Table_Length; i++) {
@@ -783,7 +783,7 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 				break;
 			}
 		}
-		priv->btxpower_trackingInit = true;
+		priv->tx_pwr_tracking_init = true;
 		return;
 	}
 
@@ -868,7 +868,7 @@ static void _rtl92e_dm_initialize_tx_power_tracking_tssi(struct net_device *dev)
 
 	priv->btxpower_tracking = true;
 	priv->txpower_count       = 0;
-	priv->btxpower_trackingInit = false;
+	priv->tx_pwr_tracking_init = false;
 
 }
 
@@ -882,7 +882,7 @@ static void _rtl92e_dm_init_tx_power_tracking_thermal(struct net_device *dev)
 	else
 		priv->btxpower_tracking = false;
 	priv->txpower_count       = 0;
-	priv->btxpower_trackingInit = false;
+	priv->tx_pwr_tracking_init = false;
 }
 
 void rtl92e_dm_init_txpower_tracking(struct net_device *dev)
@@ -1073,7 +1073,7 @@ void rtl92e_dm_restore_state(struct net_device *dev)
 		ratr_value &= ~(RATE_ALL_OFDM_2SS);
 	rtl92e_writel(dev, RATR0, ratr_value);
 	rtl92e_writeb(dev, UFWP, 1);
-	if (priv->btxpower_trackingInit && priv->btxpower_tracking)
+	if (priv->tx_pwr_tracking_init && priv->btxpower_tracking)
 		_rtl92e_dm_tx_power_reset_recovery(dev);
 
 	_rtl92e_dm_bb_initialgain_restore(dev);
-- 
2.39.0

