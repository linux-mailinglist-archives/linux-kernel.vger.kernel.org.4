Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7019C744D8F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGBMPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 08:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGBMPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 08:15:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1CC120
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 05:15:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b82bf265b2so15624935ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 05:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688300152; x=1690892152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ahNrA+kvPkt2jIv1WX2dJh9T0CTy/Hn3rwyQ5h/Idfs=;
        b=AlxV7Pr7eN7wuspl+PZcT1VxCqiyN0Yg1pDvW0lZJqo3S5/r1vX75iVS1psMMjBH0i
         IV20fVRGlLjs5CwK+9KqPM3dm8rwfUUME08+qFYdCZBvDl91rwHsnMyEjHQPJqlEdAHl
         QOWC5IwpeA4O+bJRVdsF9xAG1oy7IfTYBmQC41SeaTaPgK/uK7D4kvgJPeFKTaeauqIa
         LUcB1t52g7xgeaMGCOvKegIu44Tvh4W+dz0HWsmUof7vG9a0CwxMrUjrViQkFkcDhWDZ
         F++XClhrCQBjH2arYd9xCnOV+hlsWwH5gJRVMqp/JidblIIbDfL8fOOFuaPbdn4tPisH
         X+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688300152; x=1690892152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahNrA+kvPkt2jIv1WX2dJh9T0CTy/Hn3rwyQ5h/Idfs=;
        b=k4AvTco6jm9/Br6rSL/xn4a+dyo9KeqalH4HS4D0Ro54NdoqB6cbECdArqBFVxqKfo
         MXvLjYCQEbp/hj7z3HT+wtOlLCV+phevuB6MnIatFlFZYUqL4qH2IKj0iI+p8QUk2wsy
         LYelTr4kdveKOXu1cRo46275QBTitYqIWEEbalwaa53ttZ6OhohF6rx/TbB538ZNT7Hk
         6P5H+3Lm3GTYi5tQC2rS+EMcmL9Lf8i53iIAH7ORVLMtDw4wZ/sWCDzdOUp+2J4pNlNM
         xprW9m3HWSkULKmFt094XqNGNIC8j4jUJi1bghkfyxiFUJsdH+m3aWZLcXH0ZVgkPyXX
         OUtA==
X-Gm-Message-State: ABy/qLahHByKV3ajSOLQ00DqCTxSkwX95vQuv8uYoeMcUEw2P+tm7AD7
        C43Xuv2TlfyFN7EhCEWFn/g=
X-Google-Smtp-Source: APBJJlFxh2k5PKZ1iRR4/jkn4HJLDiUzOwrsdyihhLzIkblKK+aP46PVZUCLePZ7fiUY8T8X6VHrWw==
X-Received: by 2002:a17:903:230f:b0:1b8:8679:ab9f with SMTP id d15-20020a170903230f00b001b88679ab9fmr2978629plh.49.1688300152521;
        Sun, 02 Jul 2023 05:15:52 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.195])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902748a00b001a98f844e60sm7218474pll.263.2023.07.02.05.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 05:15:52 -0700 (PDT)
Date:   Sun, 2 Jul 2023 17:45:47 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH 2/4] staging: rtl8192e: Rename variable targetRATR
Message-ID: <ef60d870d643a3774363efdac798e059ea5b8f85.1688299890.git.yogi.kernel@gmail.com>
References: <cover.1688299890.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688299890.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable targetRATR to target_ratr to avoid CamelCase
which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 14c78f740366..a535a63ce9f7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -277,7 +277,7 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	struct rt_hi_throughput *ht_info = priv->rtllib->ht_info;
 	struct rate_adaptive *pra = &priv->rate_adaptive;
-	u32 current_ratr, targetRATR = 0;
+	u32 current_ratr, target_ratr = 0;
 	u32 LowRSSIThreshForRA = 0, HighRSSIThreshForRA = 0;
 	bool bshort_gi_enabled = false;
 	static u8 ping_rssi_state;
@@ -335,14 +335,14 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 		if (priv->undecorated_smoothed_pwdb >=
 		    (long)HighRSSIThreshForRA) {
 			pra->ratr_state = DM_RATR_STA_HIGH;
-			targetRATR = pra->upper_rssi_threshold_ratr;
+			target_ratr = pra->upper_rssi_threshold_ratr;
 		} else if (priv->undecorated_smoothed_pwdb >=
 			   (long)LowRSSIThreshForRA) {
 			pra->ratr_state = DM_RATR_STA_MIDDLE;
-			targetRATR = pra->middle_rssi_threshold_ratr;
+			target_ratr = pra->middle_rssi_threshold_ratr;
 		} else {
 			pra->ratr_state = DM_RATR_STA_LOW;
-			targetRATR = pra->low_rssi_threshold_ratr;
+			target_ratr = pra->low_rssi_threshold_ratr;
 		}
 
 		if (pra->ping_rssi_enable) {
@@ -352,7 +352,7 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 				     (long)pra->ping_rssi_thresh_for_ra) ||
 				    ping_rssi_state) {
 					pra->ratr_state = DM_RATR_STA_LOW;
-					targetRATR = pra->ping_rssi_ratr;
+					target_ratr = pra->ping_rssi_ratr;
 					ping_rssi_state = 1;
 				}
 			} else {
@@ -361,18 +361,18 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 		}
 
 		if (priv->rtllib->GetHalfNmodeSupportByAPsHandler(dev))
-			targetRATR &=  0xf00fffff;
+			target_ratr &=  0xf00fffff;
 
 		current_ratr = rtl92e_readl(dev, RATR0);
-		if (targetRATR !=  current_ratr) {
+		if (target_ratr !=  current_ratr) {
 			u32 ratr_value;
 
-			ratr_value = targetRATR;
+			ratr_value = target_ratr;
 			ratr_value &= ~(RATE_ALL_OFDM_2SS);
 			rtl92e_writel(dev, RATR0, ratr_value);
 			rtl92e_writeb(dev, UFWP, 1);
 
-			pra->last_ratr = targetRATR;
+			pra->last_ratr = target_ratr;
 		}
 
 	} else {
-- 
2.34.1

