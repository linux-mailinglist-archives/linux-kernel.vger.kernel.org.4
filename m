Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD76FE133
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbjEJPJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbjEJPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:09:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0855BBD
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:09:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115e652eeso50937729b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683731371; x=1686323371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/+U69i+oXYARFhfnLN9Kpm6lIKqslW4ET+ngsmdlTA=;
        b=m6+LJ+C98J+VMJZwyIS8bNLITH3vIYwmhU76QbeV60Ni9XrJdFPl24ysp0a9SJHXrN
         ttDHsECNj0XpoY8AhZaOfD1Gct0yfoADGWc/60E8uvTEQpjkI0dhA6K0gv4XlflnvxjJ
         6xb8XyfIuEEm9jJ40iso744+nePhMxLkUJrYSgPaVKQDvCz0fMx7xQhil78gq0HtkDy0
         VXwemSTb0P1JG1L+ZzZNFYR5kfq1Igvaik+go+FYAzx0ZQus7aoUdhdcZSqtd7Zg9Szp
         GIMC8Su1WaOnPew8TBgKO5kkjWcGaUkZvvu3dWA6Brg81kYdHWQt6D+NyZ0RO16VOttJ
         +6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683731371; x=1686323371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/+U69i+oXYARFhfnLN9Kpm6lIKqslW4ET+ngsmdlTA=;
        b=NccaYIadRJAiqL9q/UTzX4IzNrEX2p/1wi9NVukwcPgI7iW7yCJ0pWrs19xu9IWojA
         IXKlQD7Py/440TYUZAg13t89gCBY0xM6qDmr1DBBy6eL3wKAy/hgSKn/aCZIwQ99WOPe
         kw+6pP5gn9SXdqkIPDd+lGHuPgyCkZPbuJ5iseQLYXLP1hZIKGJRW1n6ixetS2xbR+l1
         9/3NdT9C4+2Te46wAGalv1aupDy/w6iRYBM8uQVhRP11Z5u7KjMwJN46LGbKvsouqJsB
         sk8rENTPx0NJ/7sXsB62jBLwOuGwQDZG9voRLJhRB39D45kf03+Y9LnRj5ZZ1Hy8FMwF
         7Kxw==
X-Gm-Message-State: AC+VfDy2VgUvbas2wtO/MG0U2hZQexX+8ytJlOhLDgZ4bEI/d4/QlDpd
        h/ookIkh37v15mz0RvIp7Q0=
X-Google-Smtp-Source: ACHHUZ43znpN4GPGFdQLAMPHvVbbEvcH4cZz8x4AHB+vSapQoQWLDQThNumZ5hWAcMFZ0FlWB58xvw==
X-Received: by 2002:a17:90a:db07:b0:250:50c5:cabc with SMTP id g7-20020a17090adb0700b0025050c5cabcmr16937872pjv.3.1683731370599;
        Wed, 10 May 2023 08:09:30 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090ad14f00b0024b6a90741esm13456870pjw.49.2023.05.10.08.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:09:30 -0700 (PDT)
Date:   Wed, 10 May 2023 20:39:25 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: rtl8192e: Rename tmpOFDMindex and tmpCCKindex
Message-ID: <48098479094e4562fe196cbce813476041a664df.1683730854.git.yogi.kernel@gmail.com>
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

Rename variable tmpOFDMindex to tmp_ofdm_index and
tmpCCKindex to tmp_cck_index to avoid CamelCase which
is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index af136abc595c..117c0538cf5f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -658,7 +658,7 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 #define ThermalMeterVal	9
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u32 tmp_reg, tmp_cck;
-	u8 tmpOFDMindex, tmpCCKindex, tmpCCK20Mindex, tmpCCK40Mindex, tmpval;
+	u8 tmp_ofdm_index, tmp_cck_index, tmpCCK20Mindex, tmpCCK40Mindex, tmpval;
 	int i = 0, CCKSwingNeedUpdate = 0;
 
 	if (!priv->tx_pwr_tracking_init) {
@@ -689,11 +689,11 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 	priv->thermal_meter[1] = ThermalMeterVal;
 
 	if (priv->thermal_meter[0] >= (u8)tmp_reg) {
-		tmpOFDMindex = tmpCCK20Mindex = 6+(priv->thermal_meter[0] -
+		tmp_ofdm_index = tmpCCK20Mindex = 6+(priv->thermal_meter[0] -
 			      (u8)tmp_reg);
 		tmpCCK40Mindex = tmpCCK20Mindex - 6;
-		if (tmpOFDMindex >= OFDM_TABLE_LEN)
-			tmpOFDMindex = OFDM_TABLE_LEN - 1;
+		if (tmp_ofdm_index >= OFDM_TABLE_LEN)
+			tmp_ofdm_index = OFDM_TABLE_LEN - 1;
 		if (tmpCCK20Mindex >= CCK_TABLE_LEN)
 			tmpCCK20Mindex = CCK_TABLE_LEN - 1;
 		if (tmpCCK40Mindex >= CCK_TABLE_LEN)
@@ -701,18 +701,18 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 	} else {
 		tmpval = (u8)tmp_reg - priv->thermal_meter[0];
 		if (tmpval >= 6) {
-			tmpOFDMindex = 0;
+			tmp_ofdm_index = 0;
 			tmpCCK20Mindex = 0;
 		} else {
-			tmpOFDMindex = 6 - tmpval;
+			tmp_ofdm_index = 6 - tmpval;
 			tmpCCK20Mindex = 6 - tmpval;
 		}
 		tmpCCK40Mindex = 0;
 	}
 	if (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20)
-		tmpCCKindex = tmpCCK40Mindex;
+		tmp_cck_index = tmpCCK40Mindex;
 	else
-		tmpCCKindex = tmpCCK20Mindex;
+		tmp_cck_index = tmpCCK20Mindex;
 
 	priv->rec_cck_20m_idx = tmpCCK20Mindex;
 	priv->rec_cck_40m_idx = tmpCCK40Mindex;
@@ -727,15 +727,15 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 		CCKSwingNeedUpdate = 1;
 	}
 
-	if (priv->cck_index != tmpCCKindex) {
-		priv->cck_index = tmpCCKindex;
+	if (priv->cck_index != tmp_cck_index) {
+		priv->cck_index = tmp_cck_index;
 		CCKSwingNeedUpdate = 1;
 	}
 
 	if (CCKSwingNeedUpdate)
 		rtl92e_dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
-	if (priv->ofdm_index[0] != tmpOFDMindex) {
-		priv->ofdm_index[0] = tmpOFDMindex;
+	if (priv->ofdm_index[0] != tmp_ofdm_index) {
+		priv->ofdm_index[0] = tmp_ofdm_index;
 		rtl92e_set_bb_reg(dev, rOFDM0_XATxIQImbalance, bMaskDWord,
 				  OFDMSwingTable[priv->ofdm_index[0]]);
 	}
-- 
2.34.1

