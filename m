Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF568DFBF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjBGSRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBGSR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:28 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51053EC6B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:17:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o36so11671939wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGwqZUsDnGRvbERNE55E/iqBGAJKPmXKHucUfptNjuE=;
        b=g4cKbTwaTW/Mk5IWf4FL266QBdQso0Ex5EBXUrFXqWcrYoNG/HcXJ68UIrAMBSWqHG
         sKj1UWvYDrOKvNxXGJZp8u4Ezt5d/ibzzo1qwq6zuXXXDXHiL9wwHm5X9vKLJarNwA5Q
         vSPYKgURQ3gDIiPq2cHtCEG/s1cekORMmz2oplfXRgmq1JqVnHxnPmeY+LDIYWNR5YYi
         qOBX0Gz9qZtYYpRLjvNHynjS5V1lOZH797bRdUU3roBukgckqqi3W1bU+BMaAyxJcU4a
         GWSd86LUDgYDyF2lZFWlluqU5k3WtliPorl2WZtNnUFSARTrvRgWGUoXY1/0p0eK0QM+
         ju5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGwqZUsDnGRvbERNE55E/iqBGAJKPmXKHucUfptNjuE=;
        b=m/dUAYox7HIT9KF/CyHZAP/6FbfcVXz+/CSIVsLrQh6F5OMDRIWdr3AmzD+XrkQtQM
         deNmqdrbD56M5U3lJBTtCdcoN4RISuhI0BobGZ4kJIh1uZr13P2+wETT3OEJ7AwZGzfU
         82ADmbd6Rqv2AuksfwgCBN9aahK0jdbIunehsR/+MtJ+mFatV51UomAwjWGvjRz98fAM
         YPEa+42Tq92UEZLB25MHovYefTMO7Gsx4tt/e2diYkTEbiv9dbKk/X7DoTnhhmssRl59
         O8NAAnsIm83expjzzDSknhRVmXXvKF+xNHAQbe3Dvt7SupTaXCB/etc/NTHsqy7mm31U
         pvRw==
X-Gm-Message-State: AO0yUKXjP1K4mpp+biB/f3qZU81G8z7ZDGvAZ7H+4MFO+afUQVjbAKjQ
        8oCqV3C3MhzCJeDAgMG5E3c=
X-Google-Smtp-Source: AK7set9FfqUA9hTHe2Ir6IOwB6OVABkct9dUWH3zjza2f7QZbPKgi87IEl2HI+d+Q5C4YMCZKSDvHQ==
X-Received: by 2002:a05:600c:35c5:b0:3d2:231a:cb30 with SMTP id r5-20020a05600c35c500b003d2231acb30mr5185165wmq.3.1675793823149;
        Tue, 07 Feb 2023 10:17:03 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b003d9fba3c7a4sm21260423wmq.16.2023.02.07.10.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:17:02 -0800 (PST)
Date:   Tue, 7 Feb 2023 19:17:00 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] staging: rtl8192e: Rename RateAdaptiveTH..,
 VeryLowRSSI and WAIotTHVal
Message-ID: <ebca576cae161442e51cd5b73930dc53f8ae26ba.1675792435.git.philipp.g.hortmann@gmail.com>
References: <cover.1675792435.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675792435.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename constants RateAdaptiveTH_Low_40M to RATE_ADAPTIVE_TH_LOW_40M,
VeryLowRSSI to VERY_LOW_RSSI and WAIotTHVal to WA_IOT_TH_VAL to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h     | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 7e445a168daa..0b5b2ae27f9e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -2021,17 +2021,17 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 		rx_chk_cnt = 0;
 	} else if ((priv->undecorated_smoothed_pwdb < (RATE_ADAPTIVE_TH_HIGH + 5))
 	  && (((priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) &&
-	  (priv->undecorated_smoothed_pwdb >= RateAdaptiveTH_Low_40M))
+	  (priv->undecorated_smoothed_pwdb >= RATE_ADAPTIVE_TH_LOW_40M))
 	  || ((priv->current_chnl_bw == HT_CHANNEL_WIDTH_20) &&
 	  (priv->undecorated_smoothed_pwdb >= RATE_ADAPTIVE_TH_LOW_20M)))) {
 		if (rx_chk_cnt < 2)
 			return bStuck;
 		rx_chk_cnt = 0;
 	} else if ((((priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) &&
-		  (priv->undecorated_smoothed_pwdb < RateAdaptiveTH_Low_40M)) ||
+		  (priv->undecorated_smoothed_pwdb < RATE_ADAPTIVE_TH_LOW_40M)) ||
 		((priv->current_chnl_bw == HT_CHANNEL_WIDTH_20) &&
 		 (priv->undecorated_smoothed_pwdb < RATE_ADAPTIVE_TH_LOW_20M))) &&
-		priv->undecorated_smoothed_pwdb >= VeryLowRSSI) {
+		priv->undecorated_smoothed_pwdb >= VERY_LOW_RSSI) {
 		if (rx_chk_cnt < 4)
 			return bStuck;
 		rx_chk_cnt = 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 739f7c512831..55e03eaf9219 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -284,11 +284,11 @@ void rtl92e_init_adaptive_rate(struct net_device *dev)
 	pra->ratr_state = DM_RATR_STA_MAX;
 	pra->high2low_rssi_thresh_for_ra = RATE_ADAPTIVE_TH_HIGH;
 	pra->low2high_rssi_thresh_for_ra20M = RATE_ADAPTIVE_TH_LOW_20M + 5;
-	pra->low2high_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M+5;
+	pra->low2high_rssi_thresh_for_ra40M = RATE_ADAPTIVE_TH_LOW_40M + 5;
 
 	pra->high_rssi_thresh_for_ra = RATE_ADAPTIVE_TH_HIGH + 5;
 	pra->low_rssi_thresh_for_ra20M = RATE_ADAPTIVE_TH_LOW_20M;
-	pra->low_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M;
+	pra->low_rssi_thresh_for_ra40M = RATE_ADAPTIVE_TH_LOW_40M;
 
 	if (priv->customer_id == RT_CID_819X_NETCORE)
 		pra->ping_rssi_enable = 1;
@@ -1649,7 +1649,7 @@ static void _rtl92e_dm_init_wa_broadcom_iot(struct net_device *dev)
 	struct rt_hi_throughput *ht_info = priv->rtllib->ht_info;
 
 	ht_info->bWAIotBroadcom = false;
-	ht_info->WAIotTH = WAIotTHVal;
+	ht_info->WAIotTH = WA_IOT_TH_VAL;
 }
 
 static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index ea698e894146..86974abea19c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -30,10 +30,10 @@
 
 #define		RATE_ADAPTIVE_TH_HIGH			50
 #define		RATE_ADAPTIVE_TH_LOW_20M		30
-#define		RateAdaptiveTH_Low_40M		10
-#define		VeryLowRSSI					15
+#define		RATE_ADAPTIVE_TH_LOW_40M		10
+#define		VERY_LOW_RSSI				15
 
-#define		WAIotTHVal						25
+#define		WA_IOT_TH_VAL				25
 
 #define		E_FOR_TX_POWER_TRACK	       300
 #define		TX_POWER_NEAR_FIELD_THRESH_HIGH		68
-- 
2.39.1

