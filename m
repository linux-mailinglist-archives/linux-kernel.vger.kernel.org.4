Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A305FA3DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJJTDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJJTDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:03:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C3D6C114
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:03:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id e18so7344379wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IH6I6NcjzPKjFPQf55rCYBqtWBzYJLRWJqZUybSFisQ=;
        b=SLDB+E6HI3mVhaxoZxkdrBbjmiTplPkAeBxrHHgklFWoNfBi+Ez2BIF4hXY/xMXYfb
         63a2uPrjxyD4qajLS8etlnj11O/Lw1K5LmvYxdhlRLN8SyjvDdzaVPj4YDmHco1njJWz
         8pDhszT9DWtRxau4UAAauOhBZdVkYcEzOJzD22ZpB09nmTqXkNDmvU34yOqRKMYgBsja
         mTdiYhW0H630TMfRif3kZVoplRWAgxCiZDVBWCLbvGcM7ci1XOwjhn4wKOx4U8/LHnjz
         hl9sckIoDG4elVElLba4+FHa4m9PZqKcoAQ4rKsFPvFlbLiKYVGNCa7IHuaxWfh8sxEh
         JvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH6I6NcjzPKjFPQf55rCYBqtWBzYJLRWJqZUybSFisQ=;
        b=kUjwi5IRYG2HtmOFavQvFFzOUBLeJsP/71gZaqLHXDO4y0uN9FVY5RKTG5CvoekQZ8
         0V/Q1Rv8nfrGYxs4gLAPcR+kEyAy6bmOuIAjPOUzPJWabmSGzd6B3vE63nZ1OH5k8Rn0
         8Ot4hx0TqZyWKe9q45iQY3LC7Fd1vmm8Vb4PirJxLmjJjQY+6M7Tng4QM3mTP0r5Klc9
         96wt8mcPPfrRUcdk7MEkknQrcv/VV3YpcXuYLbXWJaxjiGMCJpja1H39SLctsXShIFig
         ziyweiHnuKV9gX7q9U30RzTj4t+xZ5hstBPrW9/EU6Gexq0qP4/tGtCI8mURr0PNobfM
         Mr3g==
X-Gm-Message-State: ACrzQf1hT2SDS9l7x3vuKS5U4cYjKELzg1XV4lAUfhm5ll6QYWCR+8fR
        aVBoLaEO53M/O4S8iOneRmRkD4HRQoMZRSLMipI=
X-Google-Smtp-Source: AMsMyM4qZY1iV7wZSdC8XvhQD27cyJst3gKx9MtPbnhPZejYFK2ZBJJsDmzhOF1N/NftEn4Rei8o5g==
X-Received: by 2002:a05:600c:154e:b0:3b4:bf17:32fc with SMTP id f14-20020a05600c154e00b003b4bf1732fcmr21269440wmg.70.1665428580308;
        Mon, 10 Oct 2022 12:03:00 -0700 (PDT)
Received: from localhost.localdomain ([176.61.123.135])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b003a531c7aa66sm11786569wmq.1.2022.10.10.12.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:02:59 -0700 (PDT)
From:   Dragan Cvetic <dragan.m.cvetic@gmail.com>
To:     philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dragan Cvetic <dragan.m.cvetic@gmail.com>
Subject: [PATCH] staging: rtl8192e: Remove single statement braces
Date:   Mon, 10 Oct 2022 20:02:51 +0100
Message-Id: <20221010190252.12402-1-dragan.m.cvetic@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Remove braces around single line statement, to resolve checkpatch.pl
warnings "braces {} are not necessary for single statement blocks"

Signed-off-by: Dragan Cvetic <dragan.m.cvetic@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 702551056227..d7bfaf68291c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -267,10 +267,8 @@ static void _rtl92e_dm_check_ac_dc_power(struct net_device *dev)
 			"PATH=/usr/bin:/bin",
 			 NULL};
 
-	if (priv->ResetProgress == RESET_TYPE_SILENT) {
+	if (priv->ResetProgress == RESET_TYPE_SILENT)
 		return;
-	}
-
 	if (priv->rtllib->state != RTLLIB_LINKED)
 		return;
 	call_usermodehelper(ac_dc_script, argv, envp, UMH_WAIT_PROC);
@@ -330,9 +328,8 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 	bool bshort_gi_enabled = false;
 	static u8 ping_rssi_state;
 
-	if (!priv->up) {
+	if (!priv->up)
 		return;
-	}
 
 	if (pra->rate_adaptive_disabled)
 		return;
@@ -777,9 +774,8 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 		tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
 					    bMaskDWord);
 		for (i = 0; i < OFDM_Table_Length; i++) {
-			if (tmpRegA == OFDMSwingTable[i]) {
+			if (tmpRegA == OFDMSwingTable[i])
 				priv->OFDM_index[0] = i;
-			}
 		}
 
 		TempCCk = rtl92e_get_bb_reg(dev, rCCK0_TxFilter1, bMaskByte2);
@@ -1066,9 +1062,8 @@ void rtl92e_dm_restore_state(struct net_device *dev)
 	u32	reg_ratr = priv->rate_adaptive.last_ratr;
 	u32 ratr_value;
 
-	if (!priv->up) {
+	if (!priv->up)
 		return;
-	}
 
 	if (priv->rate_adaptive.rate_adaptive_disabled)
 		return;
-- 
2.25.1

