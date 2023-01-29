Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAA367FFA4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjA2O6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjA2O6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:58:05 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9B14233
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:58:03 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bk16so8902771wrb.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+df5OLdhGJNxUJkjXVUmf/v5B3qBNneBJngUv8WOJr8=;
        b=WLo3w9AhmuuylxJBA4KSK0zT8UWMDBe3iAEYktZ9g5qIOEvY3P8LaHT0fjDAi+5SvN
         yf29jLZHKOwsHh3Yi1NaMWayOSChKwRFhSVgEsZ/RQQ9RANRbzTAM22Ztkrv/V/BJUZG
         VsCLglkm02HyhX8m47GpEMPJhfeqv1Dlt3zzRwtiCt5Tgb50ePx1OY3ZmoGqNKk43tDv
         m4AW4Sx8xGyNRPYScUnmJHWHzwMchmsDrHk7stVWkb2U/MqaQEneTvkP2MPmCl4Y1iC6
         OtexSC3HRqgxMjGS89+LKp0f0DDX82AIdfsiY/7XhRYHY2hyVAhjEliDxBmQd/+mM3R0
         D5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+df5OLdhGJNxUJkjXVUmf/v5B3qBNneBJngUv8WOJr8=;
        b=KJ4UmmG6iV6is6OjXDym5gv7y3LtK1+ZTcWfL0zMcDX/u5A/CkJJ3zxri17t3C7ueW
         EC+HklEMmjf8FnBWI4Q5tp5C+Yu0oSNOdQamte0dHUTv37mjL8V6i2qhyA/WOtiwbXBd
         LH5XCeOS8dFyqw2LDxyx1fPg6WrbItwIHDDEbCJiJlcb9bfpapVNhWPBMsaQTDaoCS1l
         SQlcJqKijyHOZvca3WkYJigXyTtRWPAualZF5R0jz48EuvmgukRM3mn22vXqWseAgL8y
         OEysUPY8EV04b+eHFG4obGzDFRblXQIF/1cWuDQCfQ0lV3/I7RDgr8tTV9LD8JgGDubX
         Hphg==
X-Gm-Message-State: AO0yUKVA7WZbrcj7PwL+tLFZJnPdEY+islD/gVcViLz0krM458C13tIZ
        zP/oiZk6+RJEQjBY4eUnQFg=
X-Google-Smtp-Source: AK7set9d2Vq/Q57/APuav68YRP2PvtU4F3m0a/4sMrc5g/BoKFhcwSKIKl4h5IUc83+zoceY6/Za3Q==
X-Received: by 2002:adf:db03:0:b0:2bf:d3e1:b0d4 with SMTP id s3-20020adfdb03000000b002bfd3e1b0d4mr1389303wri.0.1675004281964;
        Sun, 29 Jan 2023 06:58:01 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id hu18-20020a05600ca29200b003dc4b4dea31sm4696338wmb.27.2023.01.29.06.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:58:01 -0800 (PST)
Date:   Sun, 29 Jan 2023 15:57:59 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] staging: rtl8192e: Rename TxBBGainTab..,
 CCKTxBBGainTab.. and RT_CID_81..
Message-ID: <0f390222d1bd272c3e63d1b2936109ac50e9f05f.1675003608.git.philipp.g.hortmann@gmail.com>
References: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675003608.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename constant TxBBGainTableLength to TX_BB_GAIN_TABLE_LEN,
CCKTxBBGainTableLength to CCK_TX_BB_GAIN_TABLE_LEN and
RT_CID_819x_Netcore to RT_CID_819X_NETCORE to avoid CamelCase which is
not accepted by checkpatch. Added spaces before and after "-" to fix
checkpatch message.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |  2 +-
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  6 ++--
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  8 ++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  6 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 30 +++++++++----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h    |  6 ++--
 6 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index 9ea281808128..73a86e1d0701 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -151,7 +151,7 @@ void rtl92e_set_cck_tx_power(struct net_device *dev, u8 powerlevel)
 
 	TxAGC = powerlevel;
 	if (priv->dynamic_tx_low_pwr) {
-		if (priv->customer_id == RT_CID_819x_Netcore)
+		if (priv->customer_id == RT_CID_819X_NETCORE)
 			TxAGC = 0x22;
 		else
 			TxAGC += priv->cck_pwr_enl;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 3989d484cc33..7ed3d47964af 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -460,7 +460,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		priv->customer_id = RT_CID_819x_RUNTOP;
 		break;
 	case EEPROM_CID_NetCore:
-		priv->customer_id = RT_CID_819x_Netcore;
+		priv->customer_id = RT_CID_819X_NETCORE;
 		break;
 	case EEPROM_CID_TOSHIBA:
 		priv->customer_id = RT_CID_TOSHIBA;
@@ -741,7 +741,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 						    bMaskDWord);
 			rtl92e_get_bb_reg(dev, rOFDM0_XCTxIQImbalance, bMaskDWord);
 
-			for (i = 0; i < TxBBGainTableLength; i++) {
+			for (i = 0; i < TX_BB_GAIN_TABLE_LEN; i++) {
 				if (tmpRegA == dm_tx_bb_gain[i]) {
 					priv->rfa_txpowertrackingindex = i;
 					priv->rfa_txpowertrackingindex_real = i;
@@ -754,7 +754,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
 			TempCCk = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1,
 						    bMaskByte2);
 
-			for (i = 0; i < CCKTxBBGainTableLength; i++) {
+			for (i = 0; i < CCK_TX_BB_GAIN_TABLE_LEN; i++) {
 				if (TempCCk == dm_cck_tx_bb_gain[i][0]) {
 					priv->cck_present_attn_20m_def = i;
 					break;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index ca10a14c63b4..456b7ca73073 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -991,9 +991,9 @@ static void _rtl92e_cck_tx_power_track_bw_switch_tssi(struct net_device *dev)
 			    priv->cck_present_attn_diff;
 
 		if (priv->cck_present_attn >
-		    (CCKTxBBGainTableLength-1))
+		    (CCK_TX_BB_GAIN_TABLE_LEN - 1))
 			priv->cck_present_attn =
-					 CCKTxBBGainTableLength-1;
+					 CCK_TX_BB_GAIN_TABLE_LEN - 1;
 		if (priv->cck_present_attn < 0)
 			priv->cck_present_attn = 0;
 
@@ -1016,9 +1016,9 @@ static void _rtl92e_cck_tx_power_track_bw_switch_tssi(struct net_device *dev)
 			priv->cck_present_attn_diff;
 
 		if (priv->cck_present_attn >
-		    (CCKTxBBGainTableLength - 1))
+		    (CCK_TX_BB_GAIN_TABLE_LEN - 1))
 			priv->cck_present_attn =
-					 CCKTxBBGainTableLength-1;
+					 CCK_TX_BB_GAIN_TABLE_LEN - 1;
 		if (priv->cck_present_attn < 0)
 			priv->cck_present_attn = 0;
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 4cf776094ac0..1287580ce352 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -90,8 +90,8 @@
 
 #define	PHY_RSSI_SLID_WIN_MAX			100
 
-#define TxBBGainTableLength			37
-#define CCKTxBBGainTableLength			23
+#define TX_BB_GAIN_TABLE_LEN			37
+#define CCK_TX_BB_GAIN_TABLE_LEN		23
 
 #define CHANNEL_PLAN_LEN			10
 #define sCrcLng					4
@@ -154,7 +154,7 @@ enum rt_customer_id {
 	RT_CID_819x_RUNTOP      = 7,
 	RT_CID_819x_Senao       = 8,
 	RT_CID_TOSHIBA	  = 9,
-	RT_CID_819x_Netcore     = 10,
+	RT_CID_819X_NETCORE     = 10,
 	RT_CID_Nettronix	= 11,
 	RT_CID_DLINK	    = 12,
 	RT_CID_PRONET	   = 13,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 79f993ab7cee..5d77baf7df64 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -46,7 +46,7 @@ static u32 edca_setting_UL[HT_IOT_PEER_MAX] = {
 	0x5e4332
 };
 
-const u32 dm_tx_bb_gain[TxBBGainTableLength] = {
+const u32 dm_tx_bb_gain[TX_BB_GAIN_TABLE_LEN] = {
 	0x7f8001fe, /* 12 dB */
 	0x788001e2, /* 11 dB */
 	0x71c001c7,
@@ -86,7 +86,7 @@ const u32 dm_tx_bb_gain[TxBBGainTableLength] = {
 	0x10000040, /* -24 dB */
 };
 
-const u8 dm_cck_tx_bb_gain[CCKTxBBGainTableLength][8] = {
+const u8 dm_cck_tx_bb_gain[CCK_TX_BB_GAIN_TABLE_LEN][8] = {
 	{0x36, 0x35, 0x2e, 0x25, 0x1c, 0x12, 0x09, 0x04},
 	{0x33, 0x32, 0x2b, 0x23, 0x1a, 0x11, 0x08, 0x04},
 	{0x30, 0x2f, 0x29, 0x21, 0x19, 0x10, 0x08, 0x03},
@@ -112,7 +112,7 @@ const u8 dm_cck_tx_bb_gain[CCKTxBBGainTableLength][8] = {
 	{0x0f, 0x0f, 0x0d, 0x0b, 0x08, 0x05, 0x03, 0x01}
 };
 
-const u8 dm_cck_tx_bb_gain_ch14[CCKTxBBGainTableLength][8] = {
+const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8] = {
 	{0x36, 0x35, 0x2e, 0x1b, 0x00, 0x00, 0x00, 0x00},
 	{0x33, 0x32, 0x2b, 0x19, 0x00, 0x00, 0x00, 0x00},
 	{0x30, 0x2f, 0x29, 0x18, 0x00, 0x00, 0x00, 0x00},
@@ -290,7 +290,7 @@ void rtl92e_init_adaptive_rate(struct net_device *dev)
 	pra->low_rssi_thresh_for_ra20M = RateAdaptiveTH_Low_20M;
 	pra->low_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M;
 
-	if (priv->customer_id == RT_CID_819x_Netcore)
+	if (priv->customer_id == RT_CID_819X_NETCORE)
 		pra->ping_rssi_enable = 1;
 	else
 		pra->ping_rssi_enable = 0;
@@ -568,8 +568,8 @@ static void _rtl92e_dm_tx_update_tssi_strong_signal(struct net_device *dev,
 	struct r8192_priv *p = rtllib_priv(dev);
 
 	if (RF_Type == RF_2T4R) {
-		if ((p->rfa_txpowertrackingindex < TxBBGainTableLength - 1) &&
-		    (p->rfc_txpowertrackingindex < TxBBGainTableLength - 1)) {
+		if ((p->rfa_txpowertrackingindex < TX_BB_GAIN_TABLE_LEN - 1) &&
+		    (p->rfc_txpowertrackingindex < TX_BB_GAIN_TABLE_LEN - 1)) {
 			p->rfa_txpowertrackingindex++;
 			p->rfa_txpowertrackingindex_real++;
 			rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
@@ -583,13 +583,13 @@ static void _rtl92e_dm_tx_update_tssi_strong_signal(struct net_device *dev,
 		} else {
 			rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
 					  bMaskDWord,
-					  dm_tx_bb_gain[TxBBGainTableLength - 1]);
+					  dm_tx_bb_gain[TX_BB_GAIN_TABLE_LEN - 1]);
 			rtl92e_set_bb_reg(dev, rOFDM0_XCTxIQImbalance,
 					  bMaskDWord,
-					  dm_tx_bb_gain[TxBBGainTableLength - 1]);
+					  dm_tx_bb_gain[TX_BB_GAIN_TABLE_LEN - 1]);
 		}
 	} else {
-		if (p->rfa_txpowertrackingindex < (TxBBGainTableLength - 1)) {
+		if (p->rfa_txpowertrackingindex < (TX_BB_GAIN_TABLE_LEN - 1)) {
 			p->rfa_txpowertrackingindex++;
 			p->rfa_txpowertrackingindex_real++;
 			rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
@@ -598,7 +598,7 @@ static void _rtl92e_dm_tx_update_tssi_strong_signal(struct net_device *dev,
 		} else {
 			rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance,
 					  bMaskDWord,
-					  dm_tx_bb_gain[TxBBGainTableLength - 1]);
+					  dm_tx_bb_gain[TX_BB_GAIN_TABLE_LEN - 1]);
 		}
 	}
 }
@@ -722,13 +722,13 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 					 priv->cck_present_attn_40m_def +
 					 priv->cck_present_attn_diff;
 
-			if (priv->cck_present_attn > (CCKTxBBGainTableLength-1))
-				priv->cck_present_attn = CCKTxBBGainTableLength-1;
+			if (priv->cck_present_attn > (CCK_TX_BB_GAIN_TABLE_LEN - 1))
+				priv->cck_present_attn = CCK_TX_BB_GAIN_TABLE_LEN - 1;
 			if (priv->cck_present_attn < 0)
 				priv->cck_present_attn = 0;
 
 			if (priv->cck_present_attn > -1 &&
-			    priv->cck_present_attn < CCKTxBBGainTableLength) {
+			    priv->cck_present_attn < CCK_TX_BB_GAIN_TABLE_LEN) {
 				if (priv->rtllib->current_network.channel == 14 &&
 				    !priv->bcck_in_ch14) {
 					priv->bcck_in_ch14 = true;
@@ -1148,7 +1148,7 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
 	dm_digtable.rssi_val = 50;
 	dm_digtable.backoff_val = DM_DIG_BACKOFF;
 	dm_digtable.rx_gain_range_max = DM_DIG_MAX;
-	if (priv->customer_id == RT_CID_819x_Netcore)
+	if (priv->customer_id == RT_CID_819X_NETCORE)
 		dm_digtable.rx_gain_range_min = DM_DIG_MIN_Netcore;
 	else
 		dm_digtable.rx_gain_range_min = DM_DIG_MIN;
@@ -1734,7 +1734,7 @@ static void _rtl92e_dm_init_rx_path_selection(struct net_device *dev)
 	DM_RxPathSelTable.Enable = 1;
 	DM_RxPathSelTable.SS_TH_low = RxPathSelection_SS_TH_low;
 	DM_RxPathSelTable.diff_TH = RxPathSelection_diff_TH;
-	if (priv->customer_id == RT_CID_819x_Netcore)
+	if (priv->customer_id == RT_CID_819X_NETCORE)
 		DM_RxPathSelTable.cck_method = CCK_Rx_Version_2;
 	else
 		DM_RxPathSelTable.cck_method = CCK_Rx_Version_1;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 65d077dfee37..7339ce1e40db 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -162,9 +162,9 @@ extern	struct dig_t dm_digtable;
 extern struct drx_path_sel DM_RxPathSelTable;
 
 /* Pre-calculated gain tables */
-extern const u32 dm_tx_bb_gain[TxBBGainTableLength];
-extern const u8 dm_cck_tx_bb_gain[CCKTxBBGainTableLength][8];
-extern const u8 dm_cck_tx_bb_gain_ch14[CCKTxBBGainTableLength][8];
+extern const u32 dm_tx_bb_gain[TX_BB_GAIN_TABLE_LEN];
+extern const u8 dm_cck_tx_bb_gain[CCK_TX_BB_GAIN_TABLE_LEN][8];
+extern const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8];
 /* Maps table index to iq amplify gain (dB, 12 to -24dB) */
 #define dm_tx_bb_gain_idx_to_amplify(idx) (-idx + 12)
 
-- 
2.39.1

