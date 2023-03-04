Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1A86AAC13
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCDTNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCDTNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:13:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0620E1042D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 11:13:45 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i34so23081025eda.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 11:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677957223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eyAMcrub/JIPykeTPHmpekVXU2bApz4nuWRFoRhDAj8=;
        b=MnpetaVXvVS1PiobuSoJmb+zGIwqDEQXkoUW01YENNbgyYSzrKUImTRUVa6xGiisyu
         wnyM4Na6TDg3SJ8qxU5U0UK49tPNXrjZCOiTlVHEwM27e4AMYwsQTYZqSPaYmpqBXHrx
         8nNnG4q4vs2EG1bX1vLAJ1SXDck3UqHdt9BynfcN2S5eY9Q1z04HGHL/M1W7QsM05vvJ
         InRXkXhRw0742V2Z3y30BT9RW0vJUlDE5PYFqYoovEz714Xu5vJL3TbEZBdI1o+ez6W0
         iTk1/9DLcYlFtlS0NAt2s+CikDvyFOHoENyUpIFCsmJfg9VV9h6nMj/KRUzxhXWJH6L4
         UmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677957223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyAMcrub/JIPykeTPHmpekVXU2bApz4nuWRFoRhDAj8=;
        b=K5r7z8UGd1UlP26m3EMqdFyLS5ahVcam0abflxGSULuLvREHBtuRCD9IRTBTQA6PMK
         fVxB2IcP9r666sJq17I/RFp4sCj2lXjajrLttWWuIG2w6Ngn2pQ/qLD3j+Ik/4mHn+4c
         O8bOKhHO0cZY2ZXocFPNdXEa841bNMMtAo6QNY+O1RMkiPMpL2I+symKYmjg7l2gVeGU
         Lk/j/hClwVMOxsNhwmJDs/G8HqSS41moMfcXvNPODJzgHpRb8MMs/Xe3p4unlmVq48J/
         QepSRIBlcdbJ4n9RiH6RCHc8m8JF78b1D6aPQJsCyHjnL8MY3BD0wYo+0CEsazBaJZSy
         L4Cw==
X-Gm-Message-State: AO0yUKUdx4i+lJYcdNu9tMQ56tYtkbMNY15RpxZ/wc/X56hhPWS3MvKq
        ZGcHlJzHNlxNbO3m8R/S14aYiFpA484=
X-Google-Smtp-Source: AK7set/MxLsnE9m/taL4toCgHQWvN2+DonG9XbVNgeKMi+BwQIUopnyOQG+0GXPzvjnjGdKLD6Il4g==
X-Received: by 2002:a17:906:1043:b0:882:bffc:f2d2 with SMTP id j3-20020a170906104300b00882bffcf2d2mr6153384ejj.2.1677957223419;
        Sat, 04 Mar 2023 11:13:43 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b008eb2a1474d0sm2342797ejd.77.2023.03.04.11.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 11:13:43 -0800 (PST)
Date:   Sat, 4 Mar 2023 20:13:41 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8192e: Remove conditions for RF_2T4R
Message-ID: <af7dcd620fdad63b2f324d626f1c97601895823a.1677955334.git.philipp.g.hortmann@gmail.com>
References: <cover.1677955334.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677955334.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove conditions for RF_2T4R because hardware that uses RF_2T4R does not
exist.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   3 +-
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  21 +---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 109 ++++--------------
 drivers/staging/rtl8192e/rtllib.h             |   1 -
 4 files changed, 25 insertions(+), 109 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 1e307789ee93..8edfaaeda910 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -353,8 +353,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 
 			if (tempval&0x80)
 				priv->rf_type = RF_1T2R;
-			else
-				priv->rf_type = RF_2T4R;
+
 		} else {
 			priv->eeprom_legacy_ht_tx_pwr_diff = 0x04;
 		}
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 385ceb3a9636..35ca01ab65ff 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -52,9 +52,7 @@ u8 rtl92e_is_legal_rf_path(struct net_device *dev, u32 eRFPath)
 	u8 ret = 1;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (priv->rf_type == RF_2T4R)
-		ret = 0;
-	else if (priv->rf_type == RF_1T2R) {
+	if (priv->rf_type == RF_1T2R) {
 		if (eRFPath == RF90_PATH_A || eRFPath == RF90_PATH_B)
 			ret = 1;
 		else if (eRFPath == RF90_PATH_C || eRFPath == RF90_PATH_D)
@@ -531,12 +529,7 @@ static bool _rtl92e_bb_config_para_file(struct net_device *dev)
 	_rtl92e_phy_config_bb(dev, BB_CONFIG_AGC_TAB);
 
 	if (priv->ic_cut  > VERSION_8190_BD) {
-		if (priv->rf_type == RF_2T4R)
-			dwRegValue = priv->antenna_tx_pwr_diff[2] << 8 |
-				      priv->antenna_tx_pwr_diff[1] << 4 |
-				      priv->antenna_tx_pwr_diff[0];
-		else
-			dwRegValue = 0x0;
+		dwRegValue = 0x0;
 		rtl92e_set_bb_reg(dev, rFPGA0_TxGainStage,
 				  (bXBTxAGC|bXCTxAGC|bXDTxAGC), dwRegValue);
 
@@ -587,16 +580,8 @@ void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
 	if (priv->epromtype == EEPROM_93C46) {
 		powerlevel = priv->tx_pwr_level_cck[channel - 1];
 		powerlevelOFDM24G = priv->tx_pwr_level_ofdm_24g[channel - 1];
-	} else if (priv->epromtype == EEPROM_93C56) {
-		if (priv->rf_type == RF_2T4R) {
-			priv->antenna_tx_pwr_diff[2] = 0;
-			priv->antenna_tx_pwr_diff[1] = 0;
-			priv->antenna_tx_pwr_diff[0] = 0;
-
-			rtl92e_set_bb_reg(dev, rFPGA0_TxGainStage,
-					  (bXBTxAGC | bXCTxAGC | bXDTxAGC), 0);
-		}
 	}
+
 	switch (priv->rf_chip) {
 	case RF_8225:
 		break;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index d8408acfc763..eb54f8cbee76 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -274,14 +274,7 @@ void rtl92e_init_adaptive_rate(struct net_device *dev)
 	pra->ping_rssi_thresh_for_ra = 15;
 
 
-	if (priv->rf_type == RF_2T4R) {
-		pra->upper_rssi_threshold_ratr		=	0x8f0f0000;
-		pra->middle_rssi_threshold_ratr		=	0x8f0ff000;
-		pra->low_rssi_threshold_ratr		=	0x8f0ff001;
-		pra->low_rssi_threshold_ratr_40M	=	0x8f0ff005;
-		pra->low_rssi_threshold_ratr_20M	=	0x8f0ff001;
-		pra->ping_rssi_ratr	=	0x0000000d;
-	} else if (priv->rf_type == RF_1T2R) {
+	if (priv->rf_type == RF_1T2R) {
 		pra->upper_rssi_threshold_ratr		=	0x000fc000;
 		pra->middle_rssi_threshold_ratr		=	0x000ff000;
 		pra->low_rssi_threshold_ratr		=	0x000ff001;
@@ -495,47 +488,18 @@ static void _rtl92e_dm_tx_update_tssi_weak_signal(struct net_device *dev,
 {
 	struct r8192_priv *p = rtllib_priv(dev);
 
-	if (RF_Type == RF_2T4R) {
-		if ((p->rfa_txpowertrackingindex > 0) &&
-		    (p->rfc_txpowertrackingindex > 0)) {
-			p->rfa_txpowertrackingindex--;
-			if (p->rfa_txpowertrackingindex_real > 4) {
-				p->rfa_txpowertrackingindex_real--;
-				rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
-						  bMaskDWord,
-						  dm_tx_bb_gain[p->rfa_txpowertrackingindex_real]);
-			}
-
-			p->rfc_txpowertrackingindex--;
-			if (p->rfc_txpowertrackingindex_real > 4) {
-				p->rfc_txpowertrackingindex_real--;
-				rtl92e_set_bb_reg(dev,
-						  rOFDM0_XCTxIQImbalance,
-						  bMaskDWord,
-						  dm_tx_bb_gain[p->rfc_txpowertrackingindex_real]);
-			}
-		} else {
-			rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
-					  bMaskDWord,
-					  dm_tx_bb_gain[4]);
+	if (p->rfa_txpowertrackingindex > 0) {
+		p->rfa_txpowertrackingindex--;
+		if (p->rfa_txpowertrackingindex_real > 4) {
+			p->rfa_txpowertrackingindex_real--;
 			rtl92e_set_bb_reg(dev,
-					  rOFDM0_XCTxIQImbalance,
-					  bMaskDWord, dm_tx_bb_gain[4]);
+					  rOFDM0_XATxIQImbalance,
+					  bMaskDWord,
+					  dm_tx_bb_gain[p->rfa_txpowertrackingindex_real]);
 		}
 	} else {
-		if (p->rfa_txpowertrackingindex > 0) {
-			p->rfa_txpowertrackingindex--;
-			if (p->rfa_txpowertrackingindex_real > 4) {
-				p->rfa_txpowertrackingindex_real--;
-				rtl92e_set_bb_reg(dev,
-						  rOFDM0_XATxIQImbalance,
-						  bMaskDWord,
-						  dm_tx_bb_gain[p->rfa_txpowertrackingindex_real]);
-			}
-		} else {
-			rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
-					  bMaskDWord, dm_tx_bb_gain[4]);
-		}
+		rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
+				  bMaskDWord, dm_tx_bb_gain[4]);
 	}
 }
 
@@ -544,39 +508,16 @@ static void _rtl92e_dm_tx_update_tssi_strong_signal(struct net_device *dev,
 {
 	struct r8192_priv *p = rtllib_priv(dev);
 
-	if (RF_Type == RF_2T4R) {
-		if ((p->rfa_txpowertrackingindex < TX_BB_GAIN_TABLE_LEN - 1) &&
-		    (p->rfc_txpowertrackingindex < TX_BB_GAIN_TABLE_LEN - 1)) {
-			p->rfa_txpowertrackingindex++;
-			p->rfa_txpowertrackingindex_real++;
-			rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
-					  bMaskDWord,
-					  dm_tx_bb_gain[p->rfa_txpowertrackingindex_real]);
-			p->rfc_txpowertrackingindex++;
-			p->rfc_txpowertrackingindex_real++;
-			rtl92e_set_bb_reg(dev, rOFDM0_XCTxIQImbalance,
-					  bMaskDWord,
-					  dm_tx_bb_gain[p->rfc_txpowertrackingindex_real]);
-		} else {
-			rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
-					  bMaskDWord,
-					  dm_tx_bb_gain[TX_BB_GAIN_TABLE_LEN - 1]);
-			rtl92e_set_bb_reg(dev, rOFDM0_XCTxIQImbalance,
-					  bMaskDWord,
-					  dm_tx_bb_gain[TX_BB_GAIN_TABLE_LEN - 1]);
-		}
+	if (p->rfa_txpowertrackingindex < (TX_BB_GAIN_TABLE_LEN - 1)) {
+		p->rfa_txpowertrackingindex++;
+		p->rfa_txpowertrackingindex_real++;
+		rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
+				  bMaskDWord,
+				  dm_tx_bb_gain[p->rfa_txpowertrackingindex_real]);
 	} else {
-		if (p->rfa_txpowertrackingindex < (TX_BB_GAIN_TABLE_LEN - 1)) {
-			p->rfa_txpowertrackingindex++;
-			p->rfa_txpowertrackingindex_real++;
-			rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
-					  bMaskDWord,
-					  dm_tx_bb_gain[p->rfa_txpowertrackingindex_real]);
-		} else {
-			rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
-					  bMaskDWord,
-					  dm_tx_bb_gain[TX_BB_GAIN_TABLE_LEN - 1]);
-		}
+		rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
+				  bMaskDWord,
+				  dm_tx_bb_gain[TX_BB_GAIN_TABLE_LEN - 1]);
 	}
 }
 
@@ -682,13 +623,8 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 			else
 				_rtl92e_dm_tx_update_tssi_strong_signal(dev, RF_Type);
 
-			if (RF_Type == RF_2T4R) {
-				priv->cck_present_attn_diff
-					= priv->rfa_txpowertrackingindex - priv->rfa_txpowertracking_default;
-			} else {
-				priv->cck_present_attn_diff
-					= priv->rfa_txpowertrackingindex_real - priv->rfa_txpowertracking_default;
-			}
+			priv->cck_present_attn_diff
+				= priv->rfa_txpowertrackingindex_real - priv->rfa_txpowertracking_default;
 
 			if (priv->current_chnl_bw == HT_CHANNEL_WIDTH_20)
 				priv->cck_present_attn =
@@ -1730,9 +1666,6 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 	static u8 disabled_rf_cnt, cck_Rx_Path_initialized;
 	u8 update_cck_rx_path;
 
-	if (priv->rf_type != RF_2T4R)
-		return;
-
 	if (!cck_Rx_Path_initialized) {
 		dm_rx_path_sel_table.cck_rx_path = (rtl92e_readb(dev, 0xa07)&0xf);
 		cck_Rx_Path_initialized = 1;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 1152fbf43383..8e5e29ce8f0d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -451,7 +451,6 @@ enum led_ctl_mode {
 
 enum rt_rf_type_def {
 	RF_1T2R = 0,
-	RF_2T4R,
 };
 
 enum wireless_mode {
-- 
2.39.2

