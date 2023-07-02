Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8353744D91
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 14:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGBMQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 08:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGBMQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 08:16:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF13E6E
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 05:16:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55ac628e3cfso1817107a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 05:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688300211; x=1690892211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Dfo7hdwwVcnKMMgv844ECc9CeiQ+h3KUJdDMwa/uJE=;
        b=V1hzgS4/XWWDCxQpuSOHCIQ+CVOJQjNF8gAU38/f6S2UUXXiozgcfZLiPK8GHvtsPs
         ksVjJc9vdWqGQjoCxM7nRGCotaLa/qiP/1GEflpj1iDj0Mn9R5U01GTD4acDea6N3zka
         Ir8xSk6NAg+hsDBK2zeo15Z+MfwCOt0FC3VXVcTGEmBx2Y+VD6o9FEOXEdhdxtLWwuQZ
         kx1CnZBbmCOMwSQ5hDKARD/lkGOYvixxfSVaTsCzEILyVmTg4zI3zzRLfNCQwU/4kuuI
         DGhHZyhRcYplupxTSQYUzP3DPlkQcsGi66K9eH4E+pye3qOn2XBB6Mj7VfeJ5wdOpIdw
         krqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688300211; x=1690892211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Dfo7hdwwVcnKMMgv844ECc9CeiQ+h3KUJdDMwa/uJE=;
        b=Pn9RYDBWELvvOelCTjr+k+L07N20PHL+1JhvGpXnSw/UyDmaLzPzfszWdK5m/pBAAJ
         XySGOGO5X/WSxwDbUpYX6Cdja1Dn/cjdKGOpLS/Sw01IqD4lhAgd4Y3GVAmGPmLWUKXa
         8uEBqpWMNvsBBDoUyYJgM1s34z1kCuSBHp82rNCdxP6j5Y7v00maMf6ZIU4yilkGvuY9
         Xp9tyvXZG2N+oVbv9NmLUpOYDBGgpF5pefByvOMcrFwvijB5JmURwbsnCOsgUZqxd4l4
         GRazykww6e8GeUsxPlmVuAtwOWjdqWddhRVUBTQs1T73uhSFv+0CFuurruZEun4lSBXA
         8bUw==
X-Gm-Message-State: ABy/qLa3+BMNsN5MzxJ/weMsapIkShihIn91FNtZyisRDraUYN12bJ60
        0XAe4syNfOueTeo9fhidyc0=
X-Google-Smtp-Source: APBJJlEx8IhwL7Ls1PtCIMynqP9igB26GQ3djtNRsIIHDuGNj2mmL0QWtrk5BEVqt6EpR2zMT2TlEw==
X-Received: by 2002:a05:6a20:3257:b0:12c:1193:a563 with SMTP id hm23-20020a056a20325700b0012c1193a563mr5580459pzc.58.1688300210710;
        Sun, 02 Jul 2023 05:16:50 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.195])
        by smtp.gmail.com with ESMTPSA id t18-20020aa79392000000b0063d24fcc2b7sm6636965pfe.1.2023.07.02.05.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 05:16:50 -0700 (PDT)
Date:   Sun, 2 Jul 2023 17:46:45 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH 4/4] staging: rtl8192e: Rename variable HighRSSIThreshForRA
Message-ID: <e4a09d927eaa9c185afce3a58cd434326de735dc.1688299890.git.yogi.kernel@gmail.com>
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

Rename variable HighRSSIThreshForRA to high_rssi_thresh_for_ra to avoid
CamelCase which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index d266d2d047ca..dbf765d601b3 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -278,7 +278,7 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 	struct rt_hi_throughput *ht_info = priv->rtllib->ht_info;
 	struct rate_adaptive *pra = &priv->rate_adaptive;
 	u32 current_ratr, target_ratr = 0;
-	u32 low_rssi_thresh_for_ra = 0, HighRSSIThreshForRA = 0;
+	u32 low_rssi_thresh_for_ra = 0, high_rssi_thresh_for_ra = 0;
 	bool bshort_gi_enabled = false;
 	static u8 ping_rssi_state;
 
@@ -319,21 +319,21 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 				((bshort_gi_enabled) ? BIT31 : 0);
 
 		if (pra->ratr_state == DM_RATR_STA_HIGH) {
-			HighRSSIThreshForRA = pra->high2low_rssi_thresh_for_ra;
+			high_rssi_thresh_for_ra = pra->high2low_rssi_thresh_for_ra;
 			low_rssi_thresh_for_ra = (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) ?
 					(pra->low_rssi_thresh_for_ra40M) : (pra->low_rssi_thresh_for_ra20M);
 		} else if (pra->ratr_state == DM_RATR_STA_LOW) {
-			HighRSSIThreshForRA = pra->high_rssi_thresh_for_ra;
+			high_rssi_thresh_for_ra = pra->high_rssi_thresh_for_ra;
 			low_rssi_thresh_for_ra = (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) ?
 					(pra->low2high_rssi_thresh_for_ra40M) : (pra->low2high_rssi_thresh_for_ra20M);
 		} else {
-			HighRSSIThreshForRA = pra->high_rssi_thresh_for_ra;
+			high_rssi_thresh_for_ra = pra->high_rssi_thresh_for_ra;
 			low_rssi_thresh_for_ra = (priv->current_chnl_bw != HT_CHANNEL_WIDTH_20) ?
 					(pra->low_rssi_thresh_for_ra40M) : (pra->low_rssi_thresh_for_ra20M);
 		}
 
 		if (priv->undecorated_smoothed_pwdb >=
-		    (long)HighRSSIThreshForRA) {
+		    (long)high_rssi_thresh_for_ra) {
 			pra->ratr_state = DM_RATR_STA_HIGH;
 			target_ratr = pra->upper_rssi_threshold_ratr;
 		} else if (priv->undecorated_smoothed_pwdb >=
-- 
2.34.1

