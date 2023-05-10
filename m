Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3806FE131
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbjEJPJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbjEJPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:09:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18EF65AA
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:09:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-250175762b8so6358865a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683731352; x=1686323352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/5MHYkfOkYJQ3WwKEx9INoY78DTjq0oXqSLJNfYktQ=;
        b=PYswHEjGfGlAdOKS84F9lqMmvGRYBxNBZZQ48dL4ScLEKMBvflskAouwo5LA7m3tYJ
         UHwuHv1aTb79xITPkI1r/B4pujZ3JsnY5vGCzy/KjrPNabIQl4ioYqFVsmnr5BaKfqqP
         x5Km2JIaPyZlXVVxpr/551I+qkLw0GbgUUYJCmSL4DpCpm/QiecMlY3vWW0bmTodbf3E
         IdsM4YnnIJYffE9GHwIqBpIsg9vMxtnAtOp/BU4ZAwjb7cjTDV7cGBGkf3QcvxFxabOM
         YpNt5hLyBAOdeFP0KqvaJtxgocCUg9IglQD7IEQZv/ITHUVHbH8gNLTsv3f0HyHUXEU/
         L3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683731352; x=1686323352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/5MHYkfOkYJQ3WwKEx9INoY78DTjq0oXqSLJNfYktQ=;
        b=GSdfBK/y2aFq/4cfobBUnzPt/eZGJxywyo0fOwyGLD2PBVVY4868xqu36THvCF9d/Y
         TboHDK8BN59wjF4ZMUYzZrAKgT5moXLXI8EpnDbVRiK0qBhNB9RZQJzsIl7G77j7/JxM
         M+jf76uI+xTDyqtJvN0CiHRHUIpTc56kCoUE1c0yWbDhYYSpWSJwYB61JOuQUUJKc9MH
         D86YxDuSqRq+xjqqkGh+djFw5yJu/uGOw8O8M8RQsDZIrGUxjk5Biu7bnpk/MlVmUgor
         7gurQ3HinWOYi8Mo97JqIcnEbpA+PwG0/4lnurFdEGKAuwZ92mhBhEMr24hT36w0GRLi
         +0Vg==
X-Gm-Message-State: AC+VfDy1Ld5sjZ54rxrCL8bj408id5xplRQO0w8saAV4yqgfRCqsDC24
        8eeffyCdk5NQQNAep53HvpM=
X-Google-Smtp-Source: ACHHUZ6C6nqRupvnUzPQMrFg/nsiI/qzt3Kvg+6td3NJ9w6K/9l9DCbzSK4zP0ymErHm9FL//pVVEQ==
X-Received: by 2002:a17:90a:608f:b0:250:2384:120d with SMTP id z15-20020a17090a608f00b002502384120dmr16991895pji.19.1683731352284;
        Wed, 10 May 2023 08:09:12 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id s14-20020a17090a760e00b0024e134a2408sm16858088pjk.14.2023.05.10.08.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:09:12 -0700 (PDT)
Date:   Wed, 10 May 2023 20:39:07 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: rtl8192e: Rename tmpRegA and TempCCk
Message-ID: <c9c67f832db3a776c04f26e0afb083ae3ba99c07.1683730854.git.yogi.kernel@gmail.com>
References: <cover.1683730854.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683730854.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable tmpRegA to tmp_reg, TempCCk to tmp_cck
to avoid CamelCase which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 56a8ec517c06..af136abc595c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -657,21 +657,21 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 {
 #define ThermalMeterVal	9
 	struct r8192_priv *priv = rtllib_priv(dev);
-	u32 tmpRegA, TempCCk;
+	u32 tmp_reg, tmp_cck;
 	u8 tmpOFDMindex, tmpCCKindex, tmpCCK20Mindex, tmpCCK40Mindex, tmpval;
 	int i = 0, CCKSwingNeedUpdate = 0;
 
 	if (!priv->tx_pwr_tracking_init) {
-		tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
+		tmp_reg = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
 					    bMaskDWord);
 		for (i = 0; i < OFDM_TABLE_LEN; i++) {
-			if (tmpRegA == OFDMSwingTable[i])
+			if (tmp_reg == OFDMSwingTable[i])
 				priv->ofdm_index[0] = i;
 		}
 
-		TempCCk = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1, bMaskByte2);
+		tmp_cck = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1, bMaskByte2);
 		for (i = 0; i < CCK_TABLE_LEN; i++) {
-			if (TempCCk == (u32)CCKSwingTable_Ch1_Ch13[i][0]) {
+			if (tmp_cck == (u32)CCKSwingTable_Ch1_Ch13[i][0]) {
 				priv->cck_index = i;
 				break;
 			}
@@ -680,17 +680,17 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 		return;
 	}
 
-	tmpRegA = rtl92e_get_rf_reg(dev, RF90_PATH_A, 0x12, 0x078);
-	if (tmpRegA < 3 || tmpRegA > 13)
+	tmp_reg = rtl92e_get_rf_reg(dev, RF90_PATH_A, 0x12, 0x078);
+	if (tmp_reg < 3 || tmp_reg > 13)
 		return;
-	if (tmpRegA >= 12)
-		tmpRegA = 12;
+	if (tmp_reg >= 12)
+		tmp_reg = 12;
 	priv->thermal_meter[0] = ThermalMeterVal;
 	priv->thermal_meter[1] = ThermalMeterVal;
 
-	if (priv->thermal_meter[0] >= (u8)tmpRegA) {
+	if (priv->thermal_meter[0] >= (u8)tmp_reg) {
 		tmpOFDMindex = tmpCCK20Mindex = 6+(priv->thermal_meter[0] -
-			      (u8)tmpRegA);
+			      (u8)tmp_reg);
 		tmpCCK40Mindex = tmpCCK20Mindex - 6;
 		if (tmpOFDMindex >= OFDM_TABLE_LEN)
 			tmpOFDMindex = OFDM_TABLE_LEN - 1;
@@ -699,7 +699,7 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 		if (tmpCCK40Mindex >= CCK_TABLE_LEN)
 			tmpCCK40Mindex = CCK_TABLE_LEN - 1;
 	} else {
-		tmpval = (u8)tmpRegA - priv->thermal_meter[0];
+		tmpval = (u8)tmp_reg - priv->thermal_meter[0];
 		if (tmpval >= 6) {
 			tmpOFDMindex = 0;
 			tmpCCK20Mindex = 0;
-- 
2.34.1

