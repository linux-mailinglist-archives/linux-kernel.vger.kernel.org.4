Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798D05FA3E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJJTE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJJTEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:04:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF70712095
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:04:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n9so1782001wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w13NLnUhg/us0UA07lnpLNoiEoB5Fcr+rg1qRGe/I/I=;
        b=WdSOZA7Xn0kkGvplBHSuUSOJurkY3g1eFpjrF97yY4pQOQblRYz3165UYEkLqxo3wl
         3vkI7/SfXtR2rUPTQzKBgDCh2Eio/Lt7bMpQNXZceb973+kphNPUTLLc4ur6P+4pdg/2
         pAqDj7TP6+5GAzK8ycFDCPLuFtnY/ulVkPYkj09nZG8ylks0gUQsp3eOvFiYqjNMQD5B
         E6SltHPKtoxUlpikTGVRhhECzhCcoQdjNbMKUIk3zWy8vXkF65t1zgZkVH3mGUSzo3xG
         +36loII2N2t89nyuuc6hKBIlQ5oFmcdMxCh09y43PsxtF07o3PCIPwBnNgV4/uPC1mkc
         BUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w13NLnUhg/us0UA07lnpLNoiEoB5Fcr+rg1qRGe/I/I=;
        b=tMu0IBafJqNIx5fN2etYoCrAChWBoHwQtd6kLJCIlmQsYBKFsgnvw8W+qMfxN8UMke
         CWUIZZbWK4vDSuo5uQD5mxj9XiurpCrbvhvHd4yvAAbhhjUOWKsXpLQqTUbOKC8M0yGS
         e53t/naeGygJUDyY56+hnEu1q/Oo7M6Y5IV3QBovx6kWZipAy+J6YsqxHq6CORltEuJf
         MpgC/1aPM2eUnKdHczTw+mfHAva0qeoMdZhd8qeCp2hZg7J2f3mE8rqRKlWHI5n7Nrmi
         +r7CfkgTCaz/l43ou0tOYUPcHJc5YVxEaVj0REyOF+WyM+5qUlppVvekG9c94lRToc/q
         ZSyw==
X-Gm-Message-State: ACrzQf30ThKJpCwjeUlSpxY3mC/Aiv3mJt33DIfWEDzKZ38ke313KPXL
        QwxjN/vHGs+WhRSx8Lu0098=
X-Google-Smtp-Source: AMsMyM6n6qS2ckUIQuoH02c3ULfdda34a5gcwP2kIQFo9nLxGgg0hJSsUCsFKLORU10WTJyx2kOdng==
X-Received: by 2002:a7b:c84f:0:b0:3b4:84c1:1e7 with SMTP id c15-20020a7bc84f000000b003b484c101e7mr21182908wml.12.1665428685365;
        Mon, 10 Oct 2022 12:04:45 -0700 (PDT)
Received: from localhost.localdomain ([176.61.123.135])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c1c2600b003b3365b38f9sm10753380wms.10.2022.10.10.12.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:04:44 -0700 (PDT)
From:   Dragan Cvetic <dragan.m.cvetic@gmail.com>
To:     philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dragan Cvetic <dragan.m.cvetic@gmail.com>
Subject: [PATCH 2/3] staging: rtl8192e: Rename RateAdap...20M, RateAdap...40M, VeryLowRSSI
Date:   Mon, 10 Oct 2022 20:04:38 +0100
Message-Id: <20221010190439.13131-3-dragan.m.cvetic@gmail.com>
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

Rename macros: VeryLowRSSI to VERI_LOW_RSSI,
RateAdaptiveTH_Low_20M to RATE_ADAPTIVE_TH_LOW_20M and
RateAdaptiveTH_Low_40M to RATE_ADAPTIVE_TH_LOW_40M
to avoid CamelCase which is not accepted by checkpatch.

Signed-off-by: Dragan Cvetic <dragan.m.cvetic@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 10 +++++-----
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     |  8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h     |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 3a2e89f6f683..a0d918899392 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -2113,17 +2113,17 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 		rx_chk_cnt = 0;
 	} else if ((priv->undecorated_smoothed_pwdb < (RATE_ADAPTIVE_TH_HIGH + 5))
 	  && (((priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) &&
-	  (priv->undecorated_smoothed_pwdb >= RateAdaptiveTH_Low_40M))
+	  (priv->undecorated_smoothed_pwdb >= RATE_ADAPTIVE_TH_LOW_40M))
 	  || ((priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20) &&
-	  (priv->undecorated_smoothed_pwdb >= RateAdaptiveTH_Low_20M)))) {
+	  (priv->undecorated_smoothed_pwdb >= RATE_ADAPTIVE_TH_LOW_20M)))) {
 		if (rx_chk_cnt < 2)
 			return bStuck;
 		rx_chk_cnt = 0;
 	} else if ((((priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20) &&
-		  (priv->undecorated_smoothed_pwdb < RateAdaptiveTH_Low_40M)) ||
+		  (priv->undecorated_smoothed_pwdb < RATE_ADAPTIVE_TH_LOW_40M)) ||
 		((priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20) &&
-		 (priv->undecorated_smoothed_pwdb < RateAdaptiveTH_Low_20M))) &&
-		priv->undecorated_smoothed_pwdb >= VeryLowRSSI) {
+		 (priv->undecorated_smoothed_pwdb < RATE_ADAPTIVE_TH_LOW_20M))) &&
+		priv->undecorated_smoothed_pwdb >= VERI_LOW_RSSI) {
 		if (rx_chk_cnt < 4)
 			return bStuck;
 		rx_chk_cnt = 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index fab427e3597e..c7ce1cab619d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -285,12 +285,12 @@ void rtl92e_init_adaptive_rate(struct net_device *dev)
 
 	pra->ratr_state = DM_RATR_STA_MAX;
 	pra->high2low_rssi_thresh_for_ra = RATE_ADAPTIVE_TH_HIGH;
-	pra->low2high_rssi_thresh_for_ra20M = RateAdaptiveTH_Low_20M+5;
-	pra->low2high_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M+5;
+	pra->low2high_rssi_thresh_for_ra20M = RATE_ADAPTIVE_TH_LOW_20M + 5;
+	pra->low2high_rssi_thresh_for_ra40M = RATE_ADAPTIVE_TH_LOW_40M + 5;
 
 	pra->high_rssi_thresh_for_ra = RATE_ADAPTIVE_TH_HIGH + 5;
-	pra->low_rssi_thresh_for_ra20M = RateAdaptiveTH_Low_20M;
-	pra->low_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M;
+	pra->low_rssi_thresh_for_ra20M = RATE_ADAPTIVE_TH_LOW_20M;
+	pra->low_rssi_thresh_for_ra40M = RATE_ADAPTIVE_TH_LOW_40M;
 
 	if (priv->CustomerID == RT_CID_819x_Netcore)
 		pra->ping_rssi_enable = 1;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index bf96eb25d808..a643ff5ad597 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -30,9 +30,9 @@
 #define		RX_PATH_SELECTION_DIFF_TH		18
 
 #define		RATE_ADAPTIVE_TH_HIGH			50
-#define		RateAdaptiveTH_Low_20M		30
-#define		RateAdaptiveTH_Low_40M		10
-#define		VeryLowRSSI					15
+#define		RATE_ADAPTIVE_TH_LOW_20M		30
+#define		RATE_ADAPTIVE_TH_LOW_40M		10
+#define		VERI_LOW_RSSI				15
 
 #define		WAIotTHVal						25
 
-- 
2.25.1

