Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6D5EE3CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiI1SEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiI1SD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:03:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49BE10196F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:03:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cv6so2956002pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=3whcrT3V6ZbW5bQsmrpMZmHA21DaBxS83EoyihXfhc8=;
        b=j5mCBCXEpARD02oZvltEJnt9jJJfGXA0zan7h7syIwgw1gzv0l5jYgwROoAYPen0mx
         sbh1v1DeyNyeXyq445mlx0tkVvc3g7DN1xYB9PNofr7trkuU8MkpevCUwTiJGyTvyM3v
         YTob7qAGbQ+GosnN0Q4B6ouzsA3jboVl2i88t6ZeDwjGgHjA+ogZc7L37WvBsVXlAH6i
         00YkQtAwFv0079z1+XC0jJxYjn9YlIrV+QigMnG4Jj+R89zB8mEbH+2vlmo8nAfWztfM
         1TNc0q+ODAzMt0xRzcNLDwfjJuir9455GeFXu99+u5FDKkjAxWwFzx4E70MjN0udNzra
         a8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3whcrT3V6ZbW5bQsmrpMZmHA21DaBxS83EoyihXfhc8=;
        b=QyvghYYfsGe2ruYcPCI578A1V3SAUlEd3ACV5hHsPXBZbgwZ2NGJ3Od9mVGVhbplbz
         qZqGhu7q73NjNZpimQE2JK6HVujW9/7MbRwZR4qf0c9sLteWeqNEYUqkDEtVezVoGKys
         jq2ECy/VWrfPKM8Mm+Pth7icMkeLvS49oD41VVE98+vOnM534fJot22ASdPbPRIpGXwq
         xr+D96rkCeLFSx9fkF9ssSArpq5p0V1ROaf0Cd4AlpOZtVtZP3SrKQc2t7luRq7K5QFS
         uY6YWY1elByA8HbvFe7w0TDM/piS+rnIZx/1E1lwkhDL22yxZnEN04JREvtx9jEsU+EX
         DCSg==
X-Gm-Message-State: ACrzQf0g1CziMVEjW/WI/6KhRPpB3XSgqwNjDE6te/kVlIR5miCPE1YW
        Xfayw9NOhrKh1f70/3NFr7k=
X-Google-Smtp-Source: AMsMyM4fQJjrgFJy7W+/zu2tTiZfQLy/K7D4j7UknVL2CVrS+Qdb5NGiw3bawGQyeKXnrJwzWnU7zA==
X-Received: by 2002:a17:902:f34c:b0:179:e3d6:306b with SMTP id q12-20020a170902f34c00b00179e3d6306bmr1038482ple.34.1664388235111;
        Wed, 28 Sep 2022 11:03:55 -0700 (PDT)
Received: from zephyrus ([103.251.210.220])
        by smtp.gmail.com with ESMTPSA id v6-20020a637a06000000b0041ae78c3493sm3887141pgc.52.2022.09.28.11.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 11:03:54 -0700 (PDT)
Date:   Wed, 28 Sep 2022 23:33:50 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8192e: Rename variable Bandwidth to avoid
 CamelCase
Message-ID: <20220928180350.GA82748@zephyrus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable Bandwidth to bandwidth to avoid CamelCase
which is not accepted by checkpatch.pl .

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---

Changes in v2:
    - Rename variable Bandwidth in file rtl819x_HTProc.c which was missed in v1

---
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c          | 8 ++++----
 drivers/staging/rtl8192e/rtllib.h                  | 4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
index 956e8e2a728c..ab2e9b729883 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
@@ -10,7 +10,7 @@
 #include "r8190P_rtl8256.h"
 
 void rtl92e_set_bandwidth(struct net_device *dev,
-			  enum ht_channel_width Bandwidth)
+			  enum ht_channel_width bandwidth)
 {
 	u8	eRFPath;
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -25,7 +25,7 @@ void rtl92e_set_bandwidth(struct net_device *dev,
 		if (!rtl92e_is_legal_rf_path(dev, eRFPath))
 			continue;
 
-		switch (Bandwidth) {
+		switch (bandwidth) {
 		case HT_CHANNEL_WIDTH_20:
 			rtl92e_set_rf_reg(dev, (enum rf90_radio_path)eRFPath,
 					  0x0b, bMask12Bits, 0x100);
@@ -44,7 +44,7 @@ void rtl92e_set_bandwidth(struct net_device *dev,
 			break;
 		default:
 			netdev_err(dev, "%s(): Unknown bandwidth: %#X\n",
-				   __func__, Bandwidth);
+				   __func__, bandwidth);
 			break;
 		}
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h
index 4cb483f1a152..3c52e2b43095 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h
@@ -9,7 +9,7 @@
 
 #define RTL819X_TOTAL_RF_PATH 2
 void rtl92e_set_bandwidth(struct net_device *dev,
-			  enum ht_channel_width Bandwidth);
+			  enum ht_channel_width bandwidth);
 bool rtl92e_config_rf(struct net_device *dev);
 void rtl92e_set_cck_tx_power(struct net_device *dev, u8	powerlevel);
 void rtl92e_set_ofdm_tx_power(struct net_device *dev, u8 powerlevel);
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 594db05b6558..1b592258e640 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1194,7 +1194,7 @@ static void _rtl92e_set_bw_mode_work_item(struct net_device *dev)
 	priv->SetBWModeInProgress = false;
 }
 
-void rtl92e_set_bw_mode(struct net_device *dev, enum ht_channel_width Bandwidth,
+void rtl92e_set_bw_mode(struct net_device *dev, enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -1206,7 +1206,7 @@ void rtl92e_set_bw_mode(struct net_device *dev, enum ht_channel_width Bandwidth,
 	atomic_inc(&(priv->rtllib->atm_swbw));
 	priv->SetBWModeInProgress = true;
 
-	priv->CurrentChannelBW = Bandwidth;
+	priv->CurrentChannelBW = bandwidth;
 
 	if (Offset == HT_EXTCHNL_OFFSET_LOWER)
 		priv->nCur40MhzPrimeSC = HAL_PRIME_CHNL_OFFSET_UPPER;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index e89c9ac90989..75629f5df954 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -75,7 +75,7 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath);
 
 u8 rtl92e_set_channel(struct net_device *dev, u8 channel);
 void rtl92e_set_bw_mode(struct net_device *dev,
-			enum ht_channel_width Bandwidth,
+			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset);
 void rtl92e_init_gain(struct net_device *dev, u8 Operation);
 
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 4a3bd49ce81a..ef3dca51cf99 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -503,7 +503,7 @@ static u8 HTFilterMCSRate(struct rtllib_device *ieee, u8 *pSupportMCS,
 }
 
 void HTSetConnectBwMode(struct rtllib_device *ieee,
-			enum ht_channel_width Bandwidth,
+			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset);
 
 void HTOnAssocRsp(struct rtllib_device *ieee)
@@ -850,7 +850,7 @@ static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
 }
 
 void HTSetConnectBwMode(struct rtllib_device *ieee,
-			enum ht_channel_width Bandwidth,
+			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset)
 {
 	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
@@ -859,13 +859,13 @@ void HTSetConnectBwMode(struct rtllib_device *ieee,
 		return;
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-		Bandwidth = HT_CHANNEL_WIDTH_20;
+		bandwidth = HT_CHANNEL_WIDTH_20;
 
 	if (pHTInfo->sw_bw_in_progress) {
 		pr_info("%s: sw_bw_in_progress!!\n", __func__);
 		return;
 	}
-	if (Bandwidth == HT_CHANNEL_WIDTH_20_40) {
+	if (bandwidth == HT_CHANNEL_WIDTH_20_40) {
 		if (ieee->current_network.channel < 2 &&
 		    Offset == HT_EXTCHNL_OFFSET_LOWER)
 			Offset = HT_EXTCHNL_OFFSET_NO_EXT;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index f7c786c8117e..3c72ed2a30a4 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1765,7 +1765,7 @@ struct rtllib_device {
 	/* check whether Tx hw resource available */
 	short (*check_nic_enough_desc)(struct net_device *dev, int queue_index);
 	void (*SetBWModeHandler)(struct net_device *dev,
-				 enum ht_channel_width Bandwidth,
+				 enum ht_channel_width bandwidth,
 				 enum ht_extchnl_offset Offset);
 	bool (*GetNmodeSupportBySecCfg)(struct net_device *dev);
 	void (*SetWirelessMode)(struct net_device *dev, u8 wireless_mode);
@@ -2073,7 +2073,7 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee, struct iw_request_info *info,
 #define MAX_RECEIVE_BUFFER_SIZE 9100
 
 void HTSetConnectBwMode(struct rtllib_device *ieee,
-			enum ht_channel_width Bandwidth,
+			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset);
 void HTUpdateDefaultSetting(struct rtllib_device *ieee);
 void HTConstructCapabilityElement(struct rtllib_device *ieee,
-- 
2.25.1

