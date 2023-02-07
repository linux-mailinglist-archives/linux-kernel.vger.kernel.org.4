Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF1C68DFC5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjBGSSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjBGSRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:52 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25383C2A3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:17:26 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so3526685wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HTiF0YIa3PdrY6tKdiAmvkQYvcKnR6W7qr1uTcPoR/g=;
        b=E28KMjB6gPE5bfO5zuiBwwhmm3qDhLnvhlfgqmaoOvtQ3CqIBV4visKND1+YBY3jgY
         5jF82T5SFlKukUcRjsJj0dsHFO7LUyvljttMlNbOCsKb4eNeM8Jn7Etfo8lDP97VPgBQ
         rSd/w+DXXAnZatMok8RKFMebVe97pDWSGg3uNOMyezOfHlJezJY+Jo7/1mUxhrJZmOJw
         bXO+JgiZw0OUZn9G43vbaHpO+R9zpg9v2Bf1LOhkGcbZVB71P3LPbOCYHU05ZLQ6ZDjd
         zCsyejOu3xa5TiQgY7uj1BWyuFblqyCg/I/5Om77JOmKo3FAc9t2vX7AngWDo/2OtSJU
         KuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTiF0YIa3PdrY6tKdiAmvkQYvcKnR6W7qr1uTcPoR/g=;
        b=Eqgbcqd+UlTJSthOKYka4ZeBJrc0kg9TFUqxHulef66fkyD9ViCgAf/DxLADMFHx54
         XywtKYfR/pbVKGeBWx2Ta2bLmFKe2HPfWGddE00i4Trvy0QB12+s9UHFMcyXSgrsQToB
         cjGiXV4vwt7/rB8o5WnLSfoKbm02Sq72xn4aRmYiKn1iHH/U2SeRKWYJoDvU8LdJSXd5
         CeGFA6DDQ2DGhCLivgHRX1xucMBNPUGj2VS/4QzRxRzA0oLx2+n4uBVT8LFWDkMqIzjp
         iWl81LwaRb1Djn7uoiB2tTcNSNk04JMMS9jg1NKX+sZYytERKAP4nOYxs+y2inkqbVIm
         hk2w==
X-Gm-Message-State: AO0yUKUal8SKdByV8oZIWP0K+d/kW13PFiMmTu8ggQnFsf11ryIltvQG
        dFvj5KY26UGYTK9D4+5qmIE=
X-Google-Smtp-Source: AK7set8SNFnSeQFerYfakosPTO2lv9HTfk2JSlDuHOQPFj0UlaHcs92bc5omNLK3n6s6JVUFN4GaZA==
X-Received: by 2002:a05:600c:3ca3:b0:3dc:5ae4:c13d with SMTP id bg35-20020a05600c3ca300b003dc5ae4c13dmr5182028wmb.4.1675793845136;
        Tue, 07 Feb 2023 10:17:25 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c228e00b003dd9232f036sm16252810wmf.23.2023.02.07.10.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:17:24 -0800 (PST)
Date:   Tue, 7 Feb 2023 19:17:22 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] staging: rtl8192e: Rename DM_RxPathSelTable
Message-ID: <8846ad13a4ee4b534d2410c9bca0c2943500c858.1675792435.git.philipp.g.hortmann@gmail.com>
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

Rename variable DM_RxPathSelTable to dm_rx_path_sel_table to avoid
CamelCase which is not accepted by checkpatch. Remove "extern struct
drx_path_sel DM_RxPathSelTable;" in rtl_dm.h as it is dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 60 +++++++++++-----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h |  1 -
 2 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 911cfecd50cb..d8455b23e555 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -144,7 +144,7 @@ const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8] = {
 /*------------------------Define global variable-----------------------------*/
 struct dig_t dm_digtable;
 
-struct drx_path_sel DM_RxPathSelTable;
+struct drx_path_sel dm_rx_path_sel_table;
 /*------------------------Define global variable-----------------------------*/
 
 
@@ -1720,7 +1720,7 @@ void rtl92e_dm_rf_pathcheck_wq(void *data)
 		else
 			priv->brfpath_rxenable[i] = false;
 	}
-	if (!DM_RxPathSelTable.enable)
+	if (!dm_rx_path_sel_table.enable)
 		return;
 
 	_rtl92e_dm_rx_path_sel_byrssi(dev);
@@ -1731,18 +1731,18 @@ static void _rtl92e_dm_init_rx_path_selection(struct net_device *dev)
 	u8 i;
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	DM_RxPathSelTable.enable = 1;
-	DM_RxPathSelTable.ss_th_low = RX_PATH_SEL_SS_TH_LOW;
-	DM_RxPathSelTable.diff_th = RX_PATH_SEL_DIFF_TH;
+	dm_rx_path_sel_table.enable = 1;
+	dm_rx_path_sel_table.ss_th_low = RX_PATH_SEL_SS_TH_LOW;
+	dm_rx_path_sel_table.diff_th = RX_PATH_SEL_DIFF_TH;
 	if (priv->customer_id == RT_CID_819X_NETCORE)
-		DM_RxPathSelTable.cck_method = CCK_Rx_Version_2;
+		dm_rx_path_sel_table.cck_method = CCK_Rx_Version_2;
 	else
-		DM_RxPathSelTable.cck_method = CCK_Rx_Version_1;
-	DM_RxPathSelTable.disabled_rf = 0;
+		dm_rx_path_sel_table.cck_method = CCK_Rx_Version_1;
+	dm_rx_path_sel_table.disabled_rf = 0;
 	for (i = 0; i < 4; i++) {
-		DM_RxPathSelTable.rf_rssi[i] = 50;
-		DM_RxPathSelTable.cck_pwdb_sta[i] = -64;
-		DM_RxPathSelTable.rf_enable_rssi_th[i] = 100;
+		dm_rx_path_sel_table.rf_rssi[i] = 50;
+		dm_rx_path_sel_table.cck_pwdb_sta[i] = -64;
+		dm_rx_path_sel_table.rf_enable_rssi_th[i] = 100;
 	}
 }
 
@@ -1769,22 +1769,22 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 		return;
 
 	if (!cck_Rx_Path_initialized) {
-		DM_RxPathSelTable.cck_rx_path = (rtl92e_readb(dev, 0xa07)&0xf);
+		dm_rx_path_sel_table.cck_rx_path = (rtl92e_readb(dev, 0xa07)&0xf);
 		cck_Rx_Path_initialized = 1;
 	}
 
-	DM_RxPathSelTable.disabled_rf = 0xf;
-	DM_RxPathSelTable.disabled_rf &= ~(rtl92e_readb(dev, 0xc04));
+	dm_rx_path_sel_table.disabled_rf = 0xf;
+	dm_rx_path_sel_table.disabled_rf &= ~(rtl92e_readb(dev, 0xc04));
 
 	if (priv->rtllib->mode == WIRELESS_MODE_B)
-		DM_RxPathSelTable.cck_method = CCK_Rx_Version_2;
+		dm_rx_path_sel_table.cck_method = CCK_Rx_Version_2;
 
 	for (i = 0; i < RF90_PATH_MAX; i++) {
-		DM_RxPathSelTable.rf_rssi[i] = priv->stats.rx_rssi_percentage[i];
+		dm_rx_path_sel_table.rf_rssi[i] = priv->stats.rx_rssi_percentage[i];
 
 		if (priv->brfpath_rxenable[i]) {
 			rf_num++;
-			cur_rf_rssi = DM_RxPathSelTable.rf_rssi[i];
+			cur_rf_rssi = dm_rx_path_sel_table.rf_rssi[i];
 
 			if (rf_num == 1) {
 				max_rssi_index = min_rssi_index = sec_rssi_index = i;
@@ -1832,12 +1832,12 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 	}
 
 	rf_num = 0;
-	if (DM_RxPathSelTable.cck_method == CCK_Rx_Version_2) {
+	if (dm_rx_path_sel_table.cck_method == CCK_Rx_Version_2) {
 		for (i = 0; i < RF90_PATH_MAX; i++) {
 			if (priv->brfpath_rxenable[i]) {
 				rf_num++;
 				cur_cck_pwdb =
-					 DM_RxPathSelTable.cck_pwdb_sta[i];
+					 dm_rx_path_sel_table.cck_pwdb_sta[i];
 
 				if (rf_num == 1) {
 					cck_rx_ver2_max_index = i;
@@ -1894,17 +1894,17 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 	}
 
 	update_cck_rx_path = 0;
-	if (DM_RxPathSelTable.cck_method == CCK_Rx_Version_2) {
+	if (dm_rx_path_sel_table.cck_method == CCK_Rx_Version_2) {
 		cck_default_Rx = cck_rx_ver2_max_index;
 		cck_optional_Rx = cck_rx_ver2_sec_index;
 		if (tmp_cck_max_pwdb != -64)
 			update_cck_rx_path = 1;
 	}
 
-	if (tmp_min_rssi < DM_RxPathSelTable.ss_th_low && disabled_rf_cnt < 2) {
+	if (tmp_min_rssi < dm_rx_path_sel_table.ss_th_low && disabled_rf_cnt < 2) {
 		if ((tmp_max_rssi - tmp_min_rssi) >=
-		     DM_RxPathSelTable.diff_th) {
-			DM_RxPathSelTable.rf_enable_rssi_th[min_rssi_index] =
+		     dm_rx_path_sel_table.diff_th) {
+			dm_rx_path_sel_table.rf_enable_rssi_th[min_rssi_index] =
 				 tmp_max_rssi+5;
 			rtl92e_set_bb_reg(dev, rOFDM0_TRxPathEnable,
 					  0x1<<min_rssi_index, 0x0);
@@ -1912,7 +1912,7 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 					  0x1<<min_rssi_index, 0x0);
 			disabled_rf_cnt++;
 		}
-		if (DM_RxPathSelTable.cck_method == CCK_Rx_Version_1) {
+		if (dm_rx_path_sel_table.cck_method == CCK_Rx_Version_1) {
 			cck_default_Rx = max_rssi_index;
 			cck_optional_Rx = sec_rssi_index;
 			if (tmp_max_rssi)
@@ -1921,24 +1921,24 @@ static void _rtl92e_dm_rx_path_sel_byrssi(struct net_device *dev)
 	}
 
 	if (update_cck_rx_path) {
-		DM_RxPathSelTable.cck_rx_path = (cck_default_Rx<<2) |
+		dm_rx_path_sel_table.cck_rx_path = (cck_default_Rx<<2) |
 						(cck_optional_Rx);
 		rtl92e_set_bb_reg(dev, rCCK0_AFESetting, 0x0f000000,
-				  DM_RxPathSelTable.cck_rx_path);
+				  dm_rx_path_sel_table.cck_rx_path);
 	}
 
-	if (DM_RxPathSelTable.disabled_rf) {
+	if (dm_rx_path_sel_table.disabled_rf) {
 		for (i = 0; i < 4; i++) {
-			if ((DM_RxPathSelTable.disabled_rf >> i) & 0x1) {
+			if ((dm_rx_path_sel_table.disabled_rf >> i) & 0x1) {
 				if (tmp_max_rssi >=
-				    DM_RxPathSelTable.rf_enable_rssi_th[i]) {
+				    dm_rx_path_sel_table.rf_enable_rssi_th[i]) {
 					rtl92e_set_bb_reg(dev,
 							  rOFDM0_TRxPathEnable,
 							  0x1 << i, 0x1);
 					rtl92e_set_bb_reg(dev,
 							  rOFDM1_TRxPathEnable,
 							  0x1 << i, 0x1);
-					DM_RxPathSelTable.rf_enable_rssi_th[i]
+					dm_rx_path_sel_table.rf_enable_rssi_th[i]
 						 = 100;
 					disabled_rf_cnt--;
 				}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 1c2eb7ac52ce..01587e2fec65 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -155,7 +155,6 @@ struct dcmd_txcmd {
 
 /*------------------------Export global variable----------------------------*/
 extern	struct dig_t dm_digtable;
-extern struct drx_path_sel DM_RxPathSelTable;
 
 /* Pre-calculated gain tables */
 extern const u32 dm_tx_bb_gain[TX_BB_GAIN_TABLE_LEN];
-- 
2.39.1

