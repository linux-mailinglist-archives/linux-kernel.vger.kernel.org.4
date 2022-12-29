Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E0658F06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiL2Q0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiL2Q0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:26:00 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473A8C760
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:25:59 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s5so27290622edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww/uAqFdAcwRcQeR8Rg6QiNEw//qbeEW+MDr/TQ3wnA=;
        b=bvPwjDEtB8E2c4O2ooRhlmbl8wUsfTz0op26AoZzjrZMCvgJYeSSEYCU808USKIXyH
         Onmuxo+7e2k7ks2OIcn5LcBA9UPuQswvAS4leGSmYI1k8n76uFGykfHJOLWs5o+Aqf7o
         ScPrbonWZgoqAMBv+b6u3Ii8sCG7h5Br1SZUPNj3O2nB5I7RegTeY6Oy0scVsdMeaPkV
         Q53UDMiT/YDCIUqq38VvkgqK4NXooIqeKtsjXeDFKDV6+gmrob6xXZD1k+1/D6iwKHlq
         NZ19Yk7AOjermqL3lphSdwh19YGm4y8LlBliel6dHBBe2WOOlHu8ummExElA0i9dk9PX
         ZNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww/uAqFdAcwRcQeR8Rg6QiNEw//qbeEW+MDr/TQ3wnA=;
        b=jC+zFXaN4ke78PmHNyRciePrrIHUVUkhgTEa1ukNEOUSA5J7mMdARnGpTYr7eSAVY2
         G9l0vkz5W263XGHHuUTXFe6yhQnUdRon9vsMSlBiPKggEOfHM0bu9GcPtFg9quJrx4qo
         4znxOKZ2ctItAksKh6dMRL0TzljxAn2JTLe7z92vsdm1DdJk6A2aRNbFzz4GGpF/ecfq
         YJWXl8oy04gITlamWzcKapYknUOBw71dr42k3qy1n6l+VhVfVzGQD97hA+bXfgtaxmJW
         MkXhwQ7/6RbKA3q6lyydbUJd5hr5gwtoAg7T+bfPWCBN/iRDS8ExziqwoaCMeGW/K8Ed
         Kt7A==
X-Gm-Message-State: AFqh2kqCF1WOcL1AJtS8krDKSzb3NLog7s4tJ6praOAI4fBTkarHSDAj
        F2F4gszt1L1ZMsXwLyW5CtQ=
X-Google-Smtp-Source: AMrXdXuHMZQHmYbCrMpYPS9ae/Uky9B57qU+3AN2c78nCrAt/JDn4p/0pC2pHzcAzKyZpydn69rehw==
X-Received: by 2002:a05:6402:541a:b0:46c:e974:fa49 with SMTP id ev26-20020a056402541a00b0046ce974fa49mr5333856edb.4.1672331157876;
        Thu, 29 Dec 2022 08:25:57 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id ek20-20020a056402371400b004835bd8dfe5sm6455611edb.35.2022.12.29.08.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:25:57 -0800 (PST)
Date:   Thu, 29 Dec 2022 17:25:55 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] staging: rtl8192e: Rename CCKPresentAtt...
Message-ID: <194e83dd0aa5d2619ba472b35e9add81aa0c82a0.1672330343.git.philipp.g.hortmann@gmail.com>
References: <cover.1672330343.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1672330343.git.philipp.g.hortmann@gmail.com>
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
index c94c67643efb..e3b534206f20 100644
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
index 0e02add8b6be..1c5a2a622ccb 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -463,9 +463,9 @@ struct r8192_priv {
 	u8 cck_pwr_enl;
 	u16 tssi_13dbm;
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
index c27d9fb7a7e6..272c5472367e 100644
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

