Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B89968DFC4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjBGSSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjBGSRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EED3B0F3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:17:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id u10so8608966wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p3HK2Y0LG1NQWI87IVm7GfhefNnAh5k+/ABvdKRfjFo=;
        b=cybvnBPiPauEWITYLfCHY0LN8tvTQQ8oQRU/yu3Of6VFsWKxn2GkiepP66EasbFI9S
         qbU/ouqaXYlke0hCL65o9zSlZew5gpsxaIF9aEz7GCyU8iGNuHRBIZhyz/izEf4lnauV
         HaibjChZSUxHY9oq35PHl0PTcQnZqZD0R5CeOiWgM9KUI8bLTe0zdLhFzj64OHzixZKK
         KIYpuWR50vzFJdQBYJmCY8Y1kbTpcZ95TElmVxy1aiJCNkkPInoSD9Qpu9kepg2d4AW8
         0XlbTEbCc2QWMJ12sXj/QDuP+JZeC2S8gEa/DJ9jZx0U/4+ETuOqj+26UgBoiUq4et21
         PgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3HK2Y0LG1NQWI87IVm7GfhefNnAh5k+/ABvdKRfjFo=;
        b=QXvU3JpmNgojpAtGvcB5QbtQx1x0bJsB3mY4uHzCbbTfj5EJlH2JgondN/kZlsGw6W
         no0I/bCb+Rw6Dy7KP7tDXAA+lhgc7PWU3lx4nCmRTYNdpucTAsPAyVpkGfbbHkRLEUlC
         TFI210w0rkR+fnoVUOmNA0zIF3u3GUVb9epVTwVrZIvcbY5cMw78qhW2/FLEdGuu/IGP
         50hJPvahxa9jYy96cXHL56a7yfZ/fXXdq/MO/IbFlbCXT+K99QbOSAswsXPNiF/HVULb
         /smliC8IcrgPKkjrIuDvM9edH/Uzw13P/DLt7VGMOOyOnMChBGqGrf3h20RAAgT1Gum5
         5sPg==
X-Gm-Message-State: AO0yUKUpT/INQ4SBmoDeyb8LObZ4pP9YoTvNzG9TkZBrvvPipVNR9zfn
        8yKTcbXbbxIFp4WDFXZIyhARNq0WxbM=
X-Google-Smtp-Source: AK7set/hLQGnN/cGBokuzI5GR+W4Po7BVsvAJa0drsRzFUBUzNoROTd6D/YtyAvTwRebk3BMsH/xFQ==
X-Received: by 2002:a05:600c:3106:b0:3dd:1cd3:5d75 with SMTP id g6-20020a05600c310600b003dd1cd35d75mr4899140wmo.0.1675793837184;
        Tue, 07 Feb 2023 10:17:17 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c44c900b003dc4fd6e624sm7726803wmo.19.2023.02.07.10.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:17:16 -0800 (PST)
Date:   Tue, 7 Feb 2023 19:17:15 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] staging: rtl8192e: Rename diff_TH and disabledRF
Message-ID: <2b95586ed460f90c98721a429aced1ffaf258e49.1675792435.git.philipp.g.hortmann@gmail.com>
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

Rename variables diff_TH to diff_th and disabledRF to disabled_rf to
avoid CamelCase which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 14 +++++++-------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 5e9a0e9653de..911cfecd50cb 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1733,12 +1733,12 @@ static void _rtl92e_dm_init_rx_path_selection(struct net_device *dev)
 
 	DM_RxPathSelTable.enable = 1;
 	DM_RxPathSelTable.ss_th_low = RX_PATH_SEL_SS_TH_LOW;
-	DM_RxPathSelTable.diff_TH = RX_PATH_SEL_DIFF_TH;
+	DM_RxPathSelTable.diff_th = RX_PATH_SEL_DIFF_TH;
 	if (priv->customer_id == RT_CID_819X_NETCORE)
 		DM_RxPathSelTable.cck_method = CCK_Rx_Version_2;
 	else
 		DM_RxPathSelTable.cck_method = CCK_Rx_Version_1;
-	DM_RxPathSelTable.disabledRF = 0;
+	DM_RxPathSelTable.disabled_rf = 0;
 	for (i = 0; i < 4; i++) {
 		DM_RxPathSelTable.rf_rssi[i] = 50;
 		DM_RxPathSelTable.cck_pwdb_sta[i] = -64;
@@ -1773,8 +1773,8 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 		cck_Rx_Path_initialized = 1;
 	}
 
-	DM_RxPathSelTable.disabledRF = 0xf;
-	DM_RxPathSelTable.disabledRF &= ~(rtl92e_readb(dev, 0xc04));
+	DM_RxPathSelTable.disabled_rf = 0xf;
+	DM_RxPathSelTable.disabled_rf &= ~(rtl92e_readb(dev, 0xc04));
 
 	if (priv->rtllib->mode == WIRELESS_MODE_B)
 		DM_RxPathSelTable.cck_method = CCK_Rx_Version_2;
@@ -1903,7 +1903,7 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 
 	if (tmp_min_rssi < DM_RxPathSelTable.ss_th_low && disabled_rf_cnt < 2) {
 		if ((tmp_max_rssi - tmp_min_rssi) >=
-		     DM_RxPathSelTable.diff_TH) {
+		     DM_RxPathSelTable.diff_th) {
 			DM_RxPathSelTable.rf_enable_rssi_th[min_rssi_index] =
 				 tmp_max_rssi+5;
 			rtl92e_set_bb_reg(dev, rOFDM0_TRxPathEnable,
@@ -1927,9 +1927,9 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 				  DM_RxPathSelTable.cck_rx_path);
 	}
 
-	if (DM_RxPathSelTable.disabledRF) {
+	if (DM_RxPathSelTable.disabled_rf) {
 		for (i = 0; i < 4; i++) {
-			if ((DM_RxPathSelTable.disabledRF>>i) & 0x1) {
+			if ((DM_RxPathSelTable.disabled_rf >> i) & 0x1) {
 				if (tmp_max_rssi >=
 				    DM_RxPathSelTable.rf_enable_rssi_th[i]) {
 					rtl92e_set_bb_reg(dev,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index a9fa984c25ac..1c2eb7ac52ce 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -130,8 +130,8 @@ struct drx_path_sel {
 	u8		cck_rx_path;
 
 	u8		ss_th_low;
-	u8		diff_TH;
-	u8		disabledRF;
+	u8		diff_th;
+	u8		disabled_rf;
 	u8		reserved;
 
 	u8		rf_rssi[4];
-- 
2.39.1

