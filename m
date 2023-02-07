Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE2668DFBE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjBGSRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjBGSRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:22 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5543EC65
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:17:01 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so10684003wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=doEhSZ1ZWSbiqK6262/Gppr2vN+zJ+4OHWK0fM/t0m4=;
        b=qAxhseizMgzVK8VNabQYUHFA3ziy/vYcvzH8KWSUsaUo3DYLl1shUNE+sr+2fzRmH7
         KYKS4lnpBTjhYII9b/fK1L/Aemdod+1Gm9WSIp0/96YUkbM3r5hSxXBqF9ed4GblzWLa
         panLNSe+F53DdZQ0jltsFTUhbXyDPlygRpi3twccEV9tF5ChjncnM25l7/P0CvsBeqL3
         vbySATfC57/aO5KHGy8ghTZsVtravMlSGaCE+FQS7Pdm7fjUEWVvlOwITmEbx2Ntl6I4
         MPIex30S99clE+DnLpMHvGEfp5HBYbn7+8u87USQuIFLf58VQewbklnaPiiO2razeOE8
         3gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doEhSZ1ZWSbiqK6262/Gppr2vN+zJ+4OHWK0fM/t0m4=;
        b=TEBxzLnG4qLYlsgWk1uLomZdyJjKMF2LUB2920mKQAlwrPl8/qbKBdzqbESRAVRKN4
         M3wRwBmhaGQIyL2bDPNRTSOzT3uE9MkQmADeoVLiqrme/fHXXB/1camPSFPE9tsCeIMs
         sgV5NWEOTPZAZv+TR0hOKhNH4EqHUGx6KbbEGiArh4p75zyUIvGBCDZ5G6upMrvPmpQv
         Gr98DhzoiE+BCXVRtRBwawtB0f9KNKJUvnolq9aNS41VEsuZewA5Pew6q876C0D9Bdav
         dCIFD7MkURDy3NkNXwpgQKBwtrTNCgTQVbvSmZfKJ/GuHUUIQGG8o8OaJsAPAeHdPcZ6
         I5xA==
X-Gm-Message-State: AO0yUKXKXyP9/dNdvV341xigr/lpk/2tKEoQ3diwBx+az9M31C3kmrBV
        z6SdRuC+gpMYgdfht/Ymf08CvOB9uf4=
X-Google-Smtp-Source: AK7set9Nz/9NyyHVkS+wJWMskZhfFaxuUgxeV0zGY79BnbchMKm3M1HjI23WwasptuaSS2XNOR8SEg==
X-Received: by 2002:a05:600c:3b9d:b0:3dc:54da:ba3e with SMTP id n29-20020a05600c3b9d00b003dc54daba3emr4837964wms.3.1675793815912;
        Tue, 07 Feb 2023 10:16:55 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id x14-20020a5d650e000000b002c3f0e94e94sm3019066wru.14.2023.02.07.10.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:16:55 -0800 (PST)
Date:   Tue, 7 Feb 2023 19:16:53 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] staging: rtl8192e: Rename RxPathSelectio..,
 RateAdaptive.. and RateAdap..
Message-ID: <3fb44a7f8020b898d3f589f16e9be4f555aa9e1e.1675792435.git.philipp.g.hortmann@gmail.com>
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

Rename constants RxPathSelection_diff_TH to RX_PATH_SEL_DIFF_TH,
RateAdaptiveTH_High to RATE_ADAPTIVE_TH_HIGH and RateAdaptiveTH_Low_20M
to RATE_ADAPTIVE_TH_LOW_20M to avoid CamelCase which is not accepted by
checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 10 +++++-----
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h     |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index a2587300a47a..7e445a168daa 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -2017,20 +2017,20 @@ bool rtl92e_is_rx_stuck(struct net_device *dev)
 	u8		SilentResetRxSoltNum = 4;
 
 	rx_chk_cnt++;
-	if (priv->undecorated_smoothed_pwdb >= (RateAdaptiveTH_High+5)) {
+	if (priv->undecorated_smoothed_pwdb >= (RATE_ADAPTIVE_TH_HIGH + 5)) {
 		rx_chk_cnt = 0;
-	} else if ((priv->undecorated_smoothed_pwdb < (RateAdaptiveTH_High + 5))
+	} else if ((priv->undecorated_smoothed_pwdb < (RATE_ADAPTIVE_TH_HIGH + 5))
 	  && (((priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) &&
 	  (priv->undecorated_smoothed_pwdb >= RateAdaptiveTH_Low_40M))
 	  || ((priv->current_chnl_bw == HT_CHANNEL_WIDTH_20) &&
-	  (priv->undecorated_smoothed_pwdb >= RateAdaptiveTH_Low_20M)))) {
+	  (priv->undecorated_smoothed_pwdb >= RATE_ADAPTIVE_TH_LOW_20M)))) {
 		if (rx_chk_cnt < 2)
 			return bStuck;
 		rx_chk_cnt = 0;
 	} else if ((((priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) &&
 		  (priv->undecorated_smoothed_pwdb < RateAdaptiveTH_Low_40M)) ||
 		((priv->current_chnl_bw == HT_CHANNEL_WIDTH_20) &&
-		 (priv->undecorated_smoothed_pwdb < RateAdaptiveTH_Low_20M))) &&
+		 (priv->undecorated_smoothed_pwdb < RATE_ADAPTIVE_TH_LOW_20M))) &&
 		priv->undecorated_smoothed_pwdb >= VeryLowRSSI) {
 		if (rx_chk_cnt < 4)
 			return bStuck;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 40e6194c6687..739f7c512831 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -282,12 +282,12 @@ void rtl92e_init_adaptive_rate(struct net_device *dev)
 	struct rate_adaptive *pra = &priv->rate_adaptive;
 
 	pra->ratr_state = DM_RATR_STA_MAX;
-	pra->high2low_rssi_thresh_for_ra = RateAdaptiveTH_High;
-	pra->low2high_rssi_thresh_for_ra20M = RateAdaptiveTH_Low_20M+5;
+	pra->high2low_rssi_thresh_for_ra = RATE_ADAPTIVE_TH_HIGH;
+	pra->low2high_rssi_thresh_for_ra20M = RATE_ADAPTIVE_TH_LOW_20M + 5;
 	pra->low2high_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M+5;
 
-	pra->high_rssi_thresh_for_ra = RateAdaptiveTH_High+5;
-	pra->low_rssi_thresh_for_ra20M = RateAdaptiveTH_Low_20M;
+	pra->high_rssi_thresh_for_ra = RATE_ADAPTIVE_TH_HIGH + 5;
+	pra->low_rssi_thresh_for_ra20M = RATE_ADAPTIVE_TH_LOW_20M;
 	pra->low_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M;
 
 	if (priv->customer_id == RT_CID_819X_NETCORE)
@@ -1733,7 +1733,7 @@ static void _rtl92e_dm_init_rx_path_selection(struct net_device *dev)
 
 	DM_RxPathSelTable.Enable = 1;
 	DM_RxPathSelTable.SS_TH_low = RX_PATH_SEL_SS_TH_LOW;
-	DM_RxPathSelTable.diff_TH = RxPathSelection_diff_TH;
+	DM_RxPathSelTable.diff_TH = RX_PATH_SEL_DIFF_TH;
 	if (priv->customer_id == RT_CID_819X_NETCORE)
 		DM_RxPathSelTable.cck_method = CCK_Rx_Version_2;
 	else
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index c41490850713..ea698e894146 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -26,10 +26,10 @@
 #define		DM_DIG_MIN_Netcore			0x12
 
 #define		RX_PATH_SEL_SS_TH_LOW			30
-#define		RxPathSelection_diff_TH			18
+#define		RX_PATH_SEL_DIFF_TH			18
 
-#define		RateAdaptiveTH_High			50
-#define		RateAdaptiveTH_Low_20M		30
+#define		RATE_ADAPTIVE_TH_HIGH			50
+#define		RATE_ADAPTIVE_TH_LOW_20M		30
 #define		RateAdaptiveTH_Low_40M		10
 #define		VeryLowRSSI					15
 
-- 
2.39.1

