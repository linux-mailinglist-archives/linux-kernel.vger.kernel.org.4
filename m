Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B34662FF1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbjAITJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbjAITIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:08:47 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E7395FF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:08:45 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id fc4so22583415ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dN85jDDbS9++X72ZVzQ9zBzrc025p4BbE5KdWzs6teU=;
        b=dYLebetn+ue1TzjRxs86nXaH4dOwnQ3mPO1MjAjPdrANYUoFmIf2tju0M6myLkPK5a
         zOpuMhHvKiEkATgJeLESWvHLQ0XKK9KZ9E3NhE6neN6zs1/wqU5WMwtgzcFYLLYEpjwf
         Vx/YbLHP4xYHrLIym+Im1oSz4ZkUXlLFBuF0OonxlvVnbFd6npZR1AM1NisSydVJalSZ
         bk+ibOF5tW2hkUwXiIj6ufYeIg2w5laGCEN/BdUu63ncUPB+pD4nYScXeS5xmxEC7hkr
         LjnI0mMUbpQtxlDiR9T6PHdpw7M0TsUV4Hr/thr81BmaPBX7vdqv+TJAli3d5m3PwlRX
         hjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN85jDDbS9++X72ZVzQ9zBzrc025p4BbE5KdWzs6teU=;
        b=Qmanb+QjLsPTrmN/08xRj+t8n/c2PStQv4+PS4DQEejLpAn0rzlZ+Zp+1c9f11ihQa
         WL/fWlMzbxBe7s6nOHDSxAFFuVLn3syMge3qf8mNu0d9qfCHFLNsMw7fOAimCqMYNHou
         4wUUjVQFQd9fgz7JCmg+jeK2e7d+R6OGt5xj4FAPMPEqoT6qZRDrLsChIt8PdD2IlF3H
         Kfu1RKbi+YXYGuTarkc30UFkXA2MFmXPZ6Hp9BI2FtCTVsQTsopJvRxFoCeK2a8dOf0D
         JKZTzIGrbATfVCotuAC+By+rB7Iyd2CnooHK06jQ5wSSefmvT1sjZRG1Ww3XxGqIc35R
         C7pg==
X-Gm-Message-State: AFqh2kpGbuOF6Gc9L3oOrtsHVYgvMP0aKFzcSjKYunUGbbUm6lqDfL+V
        dAvaXuwRgHyk1+qrBPJSkOuj54eqBo4=
X-Google-Smtp-Source: AMrXdXs4DHQlacg6eIYe0Vg6eSoumPw5RMsJl5MHx50rRk9HXh2TK6Dwb6VfNdLWVHW4zqHhPJ24wQ==
X-Received: by 2002:a17:906:308c:b0:7b2:91e8:155c with SMTP id 12-20020a170906308c00b007b291e8155cmr13682743ejv.5.1673291324420;
        Mon, 09 Jan 2023 11:08:44 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id fu17-20020a170907b01100b0084c723b4c40sm4115507ejc.103.2023.01.09.11.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:08:43 -0800 (PST)
Date:   Mon, 9 Jan 2023 20:08:41 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] staging: rtl8192e: Rename CCKPresentAtt...
Message-ID: <1254f23aefd25075ef3e16719eed79b461f41e4c.1673290428.git.philipp.g.hortmann@gmail.com>
References: <cover.1673290428.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1673290428.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable CCKPresentAttentuation_20Mdefault to
cck_present_attn_20m_def, CCKPresentAttentuation_40Mdefault to
cck_present_attn_40m_def and CCKPresentAttentuation_difference to
cck_present_attn_diff to avoid CamelCase which is not accepted by
checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  8 ++++----
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 16 ++++++++--------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 8b61c7581fe0..5c5326491e90 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -787,14 +787,14 @@ bool rtl92e_start_adapter(struct net_device *dev)
 
 			for (i = 0; i < CCKTxBBGainTableLength; i++) {
 				if (TempCCk == dm_cck_tx_bb_gain[i][0]) {
-					priv->CCKPresentAttentuation_20Mdefault = i;
+					priv->cck_present_attn_20m_def = i;
 					break;
 				}
 			}
-			priv->CCKPresentAttentuation_40Mdefault = 0;
-			priv->CCKPresentAttentuation_difference = 0;
+			priv->cck_present_attn_40m_def = 0;
+			priv->cck_present_attn_diff = 0;
 			priv->cck_present_attn =
-				  priv->CCKPresentAttentuation_20Mdefault;
+				  priv->cck_present_attn_20m_def;
 			priv->btxpower_tracking = false;
 		}
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index ccbce3e177b6..33b39b1dc655 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1009,8 +1009,8 @@ static void _rtl92e_cck_tx_power_track_bw_switch_tssi(struct net_device *dev)
 	switch (priv->CurrentChannelBW) {
 	case HT_CHANNEL_WIDTH_20:
 		priv->cck_present_attn =
-			priv->CCKPresentAttentuation_20Mdefault +
-			    priv->CCKPresentAttentuation_difference;
+			priv->cck_present_attn_20m_def +
+			    priv->cck_present_attn_diff;
 
 		if (priv->cck_present_attn >
 		    (CCKTxBBGainTableLength-1))
@@ -1034,8 +1034,8 @@ static void _rtl92e_cck_tx_power_track_bw_switch_tssi(struct net_device *dev)
 
 	case HT_CHANNEL_WIDTH_20_40:
 		priv->cck_present_attn =
-			priv->CCKPresentAttentuation_40Mdefault +
-			priv->CCKPresentAttentuation_difference;
+			priv->cck_present_attn_40m_def +
+			priv->cck_present_attn_diff;
 
 		if (priv->cck_present_attn >
 		    (CCKTxBBGainTableLength - 1))
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 825cb8ce06c0..344b2c92843a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -463,9 +463,9 @@ struct r8192_priv {
 	u8 cck_pwr_enl;
 	u16 tssi_13dBm;
 	u32 pwr_track;
-	u8 CCKPresentAttentuation_20Mdefault;
-	u8 CCKPresentAttentuation_40Mdefault;
-	s8 CCKPresentAttentuation_difference;
+	u8 cck_present_attn_20m_def;
+	u8 cck_present_attn_40m_def;
+	s8 cck_present_attn_diff;
 	s8 cck_present_attn;
 	long undecorated_smoothed_pwdb;
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 6cd49b3f6408..6d3c9491d070 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -708,21 +708,21 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 				_rtl92e_dm_tx_update_tssi_strong_signal(dev, RF_Type);
 
 			if (RF_Type == RF_2T4R) {
-				priv->CCKPresentAttentuation_difference
+				priv->cck_present_attn_diff
 					= priv->rfa_txpowertrackingindex - priv->rfa_txpowertracking_default;
 			} else {
-				priv->CCKPresentAttentuation_difference
+				priv->cck_present_attn_diff
 					= priv->rfa_txpowertrackingindex_real - priv->rfa_txpowertracking_default;
 			}
 
 			if (priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20)
 				priv->cck_present_attn =
-					 priv->CCKPresentAttentuation_20Mdefault +
-					 priv->CCKPresentAttentuation_difference;
+					 priv->cck_present_attn_20m_def +
+					 priv->cck_present_attn_diff;
 			else
 				priv->cck_present_attn =
-					 priv->CCKPresentAttentuation_40Mdefault +
-					 priv->CCKPresentAttentuation_difference;
+					 priv->cck_present_attn_40m_def +
+					 priv->cck_present_attn_diff;
 
 			if (priv->cck_present_attn > (CCKTxBBGainTableLength-1))
 				priv->cck_present_attn = CCKTxBBGainTableLength-1;
@@ -742,8 +742,8 @@ static void _rtl92e_dm_tx_power_tracking_callback_tssi(struct net_device *dev)
 					rtl92e_dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
 			}
 
-			if (priv->CCKPresentAttentuation_difference <= -12 ||
-			    priv->CCKPresentAttentuation_difference >= 24) {
+			if (priv->cck_present_attn_diff <= -12 ||
+			    priv->cck_present_attn_diff >= 24) {
 				priv->rtllib->bdynamic_txpower_enable = true;
 				rtl92e_writeb(dev, Pw_Track_Flag, 0);
 				rtl92e_writeb(dev, FW_Busy_Flag, 0);
-- 
2.39.0

