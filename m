Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACD75FA3E3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiJJTEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJJTEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:04:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B9911A15
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:04:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso6931467wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4ujXLGbw0auAgosY5LK+MY/dUXHfRUWpy6qwYKbvdY=;
        b=FQTkz9o9yvXkD6OBt53TSZZf7XSeKC/r4f1NHep5VR2iHNzwSS7Gn9S9iQoV2mupny
         ooKU9VoiXGo20CbEm6LMKdXeheD/bwnctR9Gi0MgUFY+uVDcjxr1v72dJ+7HrwuBavWI
         Ee5O6EjZezusGhSAO3i42jvpV11PI7bPIqFKRB606M1IxdSSSu0QyUg48tV6PexV6F0/
         OsTFislNgOnpMMmIdx5FtgkLgJEcpi+nNZQ7SItYlV2rjYTVLF74CSwd6vm8aei26vzk
         Orh3OMVfeCDr70O4DgvG8EMQauCp9PyEPTrficReQfsVHV7eriyQj5u57S3DOWzKq1+r
         pWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4ujXLGbw0auAgosY5LK+MY/dUXHfRUWpy6qwYKbvdY=;
        b=sge2ZGa4hASNt6vr8Nv44BDnK9Hfl0gceyfV4icCjbegz5yTBWGW05Tff6WRXA3sWT
         7VxeQszZeFjk0SFdVHaZV6NV4XpI2dGUbzZaL3RLXImMcPHpIcB2yn35GThhwp2vo+C+
         0ajR9P3sgynqz/3ZxXmlTiINgBEdI8ikMSBrRsLdp76I36AyRnhFMA3efUW4zZbkSMjb
         OBJC6HsAHqfULE8nCnH5p3bsv4+sqpg1OPExSTb6djfa87RGhMNUBSHgqev2g8fqww8C
         /tHtZ/+bcTtlgS2XaDaT8TqDXbD7tbO8OA41xdeldXqfw+ssjGSel93/A2TQwnyDcp9O
         /tnw==
X-Gm-Message-State: ACrzQf2vRgfGheReYiqo1IKed3Oq8MwsoBslY61or7V0FD7BEUT3n/xg
        mw+L83da3q6RQnT+gGnax/M=
X-Google-Smtp-Source: AMsMyM4UUUutZCWheQnFzSMW7BEbelhlppEy3zD0d5MN45yC/iPCg7nCVMizmkD1pGgl0X/P37a1EQ==
X-Received: by 2002:a05:600c:310b:b0:3b4:c709:4322 with SMTP id g11-20020a05600c310b00b003b4c7094322mr20140464wmo.141.1665428684306;
        Mon, 10 Oct 2022 12:04:44 -0700 (PDT)
Received: from localhost.localdomain ([176.61.123.135])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b003b3365b38f9sm10753380wms.10.2022.10.10.12.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:04:43 -0700 (PDT)
From:   Dragan Cvetic <dragan.m.cvetic@gmail.com>
To:     philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dragan Cvetic <dragan.m.cvetic@gmail.com>
Subject: [PATCH 1/3] staging: rtl8192e: Rename RateAdapt..., RxPath...TH_low, RxPath..._TH
Date:   Mon, 10 Oct 2022 20:04:37 +0100
Message-Id: <20221010190439.13131-2-dragan.m.cvetic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221010190439.13131-1-dragan.m.cvetic@gmail.com>
References: <20221010190439.13131-1-dragan.m.cvetic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename macros: RateAdaptiveTH_High to RATE_ADAPTIVE_TH_HIGH,
RxPathSelection_SS_TH_low to RX_PATH_SELECTION_SS_TH_LOW and
RxPathSelection_diff_TH to RX_PATH_SELECTION_DIFF_TH
to avoid CamelCase which is not accepted by checkpatch.

Signed-off-by: Dragan Cvetic <dragan.m.cvetic@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h     | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 18e4e5d84878..3a2e89f6f683 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -2109,9 +2109,9 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 	u8		SilentResetRxSoltNum = 4;
 
 	rx_chk_cnt++;
-	if (priv->undecorated_smoothed_pwdb >= (RateAdaptiveTH_High+5)) {
+	if (priv->undecorated_smoothed_pwdb >= (RATE_ADAPTIVE_TH_HIGH + 5)) {
 		rx_chk_cnt = 0;
-	} else if ((priv->undecorated_smoothed_pwdb < (RateAdaptiveTH_High + 5))
+	} else if ((priv->undecorated_smoothed_pwdb < (RATE_ADAPTIVE_TH_HIGH + 5))
 	  && (((priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) &&
 	  (priv->undecorated_smoothed_pwdb >= RateAdaptiveTH_Low_40M))
 	  || ((priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20) &&
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index d7bfaf68291c..fab427e3597e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -284,11 +284,11 @@ void rtl92e_init_adaptive_rate(struct net_device *dev)
 	struct rate_adaptive *pra = &priv->rate_adaptive;
 
 	pra->ratr_state = DM_RATR_STA_MAX;
-	pra->high2low_rssi_thresh_for_ra = RateAdaptiveTH_High;
+	pra->high2low_rssi_thresh_for_ra = RATE_ADAPTIVE_TH_HIGH;
 	pra->low2high_rssi_thresh_for_ra20M = RateAdaptiveTH_Low_20M+5;
 	pra->low2high_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M+5;
 
-	pra->high_rssi_thresh_for_ra = RateAdaptiveTH_High+5;
+	pra->high_rssi_thresh_for_ra = RATE_ADAPTIVE_TH_HIGH + 5;
 	pra->low_rssi_thresh_for_ra20M = RateAdaptiveTH_Low_20M;
 	pra->low_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M;
 
@@ -1734,8 +1734,8 @@ static void _rtl92e_dm_init_rx_path_selection(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	DM_RxPathSelTable.Enable = 1;
-	DM_RxPathSelTable.SS_TH_low = RxPathSelection_SS_TH_low;
-	DM_RxPathSelTable.diff_TH = RxPathSelection_diff_TH;
+	DM_RxPathSelTable.SS_TH_low = RX_PATH_SELECTION_SS_TH_LOW;
+	DM_RxPathSelTable.diff_TH = RX_PATH_SELECTION_DIFF_TH;
 	if (priv->CustomerID == RT_CID_819x_Netcore)
 		DM_RxPathSelTable.cck_method = CCK_Rx_Version_2;
 	else
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 51e295d389a8..bf96eb25d808 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -26,10 +26,10 @@
 #define		DM_DIG_MIN					0x1c
 #define		DM_DIG_MIN_Netcore			0x12
 
-#define		RxPathSelection_SS_TH_low		30
-#define		RxPathSelection_diff_TH			18
+#define		RX_PATH_SELECTION_SS_TH_LOW		30
+#define		RX_PATH_SELECTION_DIFF_TH		18
 
-#define		RateAdaptiveTH_High			50
+#define		RATE_ADAPTIVE_TH_HIGH			50
 #define		RateAdaptiveTH_Low_20M		30
 #define		RateAdaptiveTH_Low_40M		10
 #define		VeryLowRSSI					15
-- 
2.25.1

