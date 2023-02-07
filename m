Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69E568DFBD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjBGSRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjBGSRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:17 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F7D3EC5E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:16:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so13828492wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dRXlbuHWIqEI2LZL4Y/EiSrD0H+SiFzYSzy68+DpRcI=;
        b=AvFAsLg76DNcqBL5Ki9pWEbflh5k18Z9it0vGcETw+2Hw17NsmeXaTnnbJb0vgeC7x
         OaII1I4jEhMMv+p81cDzt6JVm9Eb8bzf9pKjGFAWqpHvChUcAAsO7OhGsJGcU/fiIA2t
         JxdVhqua+VpEFXqnzqQVdoRdlGe3jbL5s1fi77GpGSrkn2erSUFUp2QVxudXZhPmq/HG
         vAkuhg6wb3zgdj3/9YRcj9UnOGWcXpDD/gGyICzyp9Vp8v1zLcojo2oJSRIwJfFSLPUr
         RUJOCCUyIK0eTt3gFK2vxaASBPNTLOPkBBRaPZmeA8LvOrJcGPvEHKjr1DrrAhdPjUol
         WTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRXlbuHWIqEI2LZL4Y/EiSrD0H+SiFzYSzy68+DpRcI=;
        b=iCB2Sr+bXmdhqN7kUhI1TAhPXdSErJgGoHtT8AGSmt8E+4FajJKcud4cIBds92Gyky
         QaWwDSFmw8RLBFKimURo2ypcIgLxyQPcRgLG+BNdkSPqR2FcIkqMsZhypFZZwW4a2r4K
         4mjiJxsLgIyJnjpETqkK4dw3RAUBUtcLwAV1+3+80/k2Okz8XQ0Lq0t7vmThnksO1+Xp
         5tuPSeuGvN7rk0ha6FnUyIxXFBfsn9ElLwpGpRUPt4JSmZK7LU6+zcMOd10ONI0FX00n
         13LKJ4jp4v69nZoVV5eUCeV1uTma8WgPVwqTvFog/ltTI37FeNDTVB/VQ4UkSbmv0XK0
         GM4w==
X-Gm-Message-State: AO0yUKWpS9VIdzSaDsL3BwmWgX6YJ/D73NEoQbvyeB+FxzLUS3jFm5ZH
        evmSLJpjEVIe8X8BCw+hM4s=
X-Google-Smtp-Source: AK7set8yJYJ1txXDOyS9E2+5Baq4azg1KX5SHxPfKMUj5bTiFlyAO6J5FpGbSQUYH9lEmbwl6nK/WA==
X-Received: by 2002:a05:600c:511c:b0:3dc:3398:cf65 with SMTP id o28-20020a05600c511c00b003dc3398cf65mr4841197wms.2.1675793809441;
        Tue, 07 Feb 2023 10:16:49 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id ip20-20020a05600ca69400b003dd19baf45asm13784914wmb.40.2023.02.07.10.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:16:48 -0800 (PST)
Date:   Tue, 7 Feb 2023 19:16:47 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] staging: rtl8192e: Rename OFDM_Table.., CCK_Table_..
 and RxPathSelecti..
Message-ID: <197e98073922ec14d56e4a516c493188c88e11c1.1675792435.git.philipp.g.hortmann@gmail.com>
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

Rename constants OFDM_Table_Length to OFDM_TABLE_LEN, CCK_Table_length to
CCK_TABLE_LEN and RxPathSelection_SS_TH_low to RX_PATH_SEL_SS_TH_LOW to
avoid CamelCase which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 24 +++++++++++-----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h |  6 +++---
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 5d77baf7df64..40e6194c6687 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -455,7 +455,7 @@ static void _rtl92e_dm_bandwidth_autoswitch(struct net_device *dev)
 	}
 }
 
-static u32 OFDMSwingTable[OFDM_Table_Length] = {
+static u32 OFDMSwingTable[OFDM_TABLE_LEN] = {
 	0x7f8001fe,
 	0x71c001c7,
 	0x65400195,
@@ -477,7 +477,7 @@ static u32 OFDMSwingTable[OFDM_Table_Length] = {
 	0x10000040
 };
 
-static u8	CCKSwingTable_Ch1_Ch13[CCK_Table_length][8] = {
+static u8	CCKSwingTable_Ch1_Ch13[CCK_TABLE_LEN][8] = {
 	{0x36, 0x35, 0x2e, 0x25, 0x1c, 0x12, 0x09, 0x04},
 	{0x30, 0x2f, 0x29, 0x21, 0x19, 0x10, 0x08, 0x03},
 	{0x2b, 0x2a, 0x25, 0x1e, 0x16, 0x0e, 0x07, 0x03},
@@ -492,7 +492,7 @@ static u8	CCKSwingTable_Ch1_Ch13[CCK_Table_length][8] = {
 	{0x0f, 0x0f, 0x0d, 0x0b, 0x08, 0x05, 0x03, 0x01}
 };
 
-static u8	CCKSwingTable_Ch14[CCK_Table_length][8] = {
+static u8	CCKSwingTable_Ch14[CCK_TABLE_LEN][8] = {
 	{0x36, 0x35, 0x2e, 0x1b, 0x00, 0x00, 0x00, 0x00},
 	{0x30, 0x2f, 0x29, 0x18, 0x00, 0x00, 0x00, 0x00},
 	{0x2b, 0x2a, 0x25, 0x15, 0x00, 0x00, 0x00, 0x00},
@@ -771,13 +771,13 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 	if (!priv->tx_pwr_tracking_init) {
 		tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
 					    bMaskDWord);
-		for (i = 0; i < OFDM_Table_Length; i++) {
+		for (i = 0; i < OFDM_TABLE_LEN; i++) {
 			if (tmpRegA == OFDMSwingTable[i])
 				priv->ofdm_index[0] = i;
 		}
 
 		TempCCk = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1, bMaskByte2);
-		for (i = 0; i < CCK_Table_length; i++) {
+		for (i = 0; i < CCK_TABLE_LEN; i++) {
 			if (TempCCk == (u32)CCKSwingTable_Ch1_Ch13[i][0]) {
 				priv->cck_index = i;
 				break;
@@ -799,12 +799,12 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 		tmpOFDMindex = tmpCCK20Mindex = 6+(priv->thermal_meter[0] -
 			      (u8)tmpRegA);
 		tmpCCK40Mindex = tmpCCK20Mindex - 6;
-		if (tmpOFDMindex >= OFDM_Table_Length)
-			tmpOFDMindex = OFDM_Table_Length-1;
-		if (tmpCCK20Mindex >= CCK_Table_length)
-			tmpCCK20Mindex = CCK_Table_length-1;
-		if (tmpCCK40Mindex >= CCK_Table_length)
-			tmpCCK40Mindex = CCK_Table_length-1;
+		if (tmpOFDMindex >= OFDM_TABLE_LEN)
+			tmpOFDMindex = OFDM_TABLE_LEN - 1;
+		if (tmpCCK20Mindex >= CCK_TABLE_LEN)
+			tmpCCK20Mindex = CCK_TABLE_LEN - 1;
+		if (tmpCCK40Mindex >= CCK_TABLE_LEN)
+			tmpCCK40Mindex = CCK_TABLE_LEN - 1;
 	} else {
 		tmpval = (u8)tmpRegA - priv->thermal_meter[0];
 		if (tmpval >= 6) {
@@ -1732,7 +1732,7 @@ static void _rtl92e_dm_init_rx_path_selection(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	DM_RxPathSelTable.Enable = 1;
-	DM_RxPathSelTable.SS_TH_low = RxPathSelection_SS_TH_low;
+	DM_RxPathSelTable.SS_TH_low = RX_PATH_SEL_SS_TH_LOW;
 	DM_RxPathSelTable.diff_TH = RxPathSelection_diff_TH;
 	if (priv->customer_id == RT_CID_819X_NETCORE)
 		DM_RxPathSelTable.cck_method = CCK_Rx_Version_2;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index a0c4006c7726..c41490850713 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -8,8 +8,8 @@
 #define __R8192UDM_H__
 
 /*--------------------------Define Parameters-------------------------------*/
-#define			OFDM_Table_Length	19
-#define		CCK_Table_length	12
+#define		OFDM_TABLE_LEN				19
+#define		CCK_TABLE_LEN				12
 
 #define		DM_DIG_THRESH_HIGH					40
 #define		DM_DIG_THRESH_LOW					35
@@ -25,7 +25,7 @@
 #define		DM_DIG_MIN					0x1c
 #define		DM_DIG_MIN_Netcore			0x12
 
-#define		RxPathSelection_SS_TH_low		30
+#define		RX_PATH_SEL_SS_TH_LOW			30
 #define		RxPathSelection_diff_TH			18
 
 #define		RateAdaptiveTH_High			50
-- 
2.39.1

