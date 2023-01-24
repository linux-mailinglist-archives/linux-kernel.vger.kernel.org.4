Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BA467A553
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjAXWEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbjAXWEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:04:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F23E4FCE7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:03:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso23273wmn.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90Z8arZ8S7xn+pHZz9yBB5NUzJn4HNmNZB/3Uj4Q9P4=;
        b=TJWRvJrtjQOLpizydU1exBKvpWb0s72G89GIe0WwyYLAvsSsWnBL9EPGMVe2V0Wgvu
         ijVhnn/V0TOAcHAxYv/Yd8d9ZFrI7zczAhI9y6HcSx+MPt7yi2q41SK0vZ9g4Zd45oww
         voa9s1WQHF3ekI4mbRuDEUMTQOsDgFP09q1Mh5kHqz6oIWmF1v1fsmbwnLF3PQFlIXxp
         qOhLITkfvYGgvXZ9fSIyqNc/R5Bh5r8fjeRBlr5cyzbODYoyB9pCnObphsRFXfyxteFc
         z9Jox+/gYJF2m3pkKMw3cK511yEp6cP0og15fnZhcgoZZSxNgWSCNotencf+j73/PE8K
         KekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90Z8arZ8S7xn+pHZz9yBB5NUzJn4HNmNZB/3Uj4Q9P4=;
        b=3eE+voDtnQkgsQ1k6LRPaIvldOfpY5YFnGaHAuzZ3ztwDhvKh4kREOXDAEp/QBPe14
         GX1cymHUor5ysP90ZypIaFIbg2xSrYFP3NngNlluRnyJuHZ7NJZWQpQCP0szHxTLORc3
         PXr9aGO/mdDZ6qPvYhdvCXhbrDeGw13Wx92sByHemy6JIAbOi6JVSTw8SYJooMuEbksd
         5tL3rTAI/03zxiTu0aS2LY55atQ2SVSuBZvPuxN8pRCLs78e+1D1J6NqUN34k+ca+z8+
         J2U1NjV4f3i2Gx/8clQU14jnMH/Ju9A41Spwgc3d009teJiQYyR4cZdotadfuUPwGWyU
         IJ+w==
X-Gm-Message-State: AFqh2krkDXNKft3tQDGvqOddjllrR6vmh3yPtQxvb0PPDNDshBAGZHop
        UB3j31tq4+ElNtx9/SnnLWc=
X-Google-Smtp-Source: AMrXdXtLRcgeNgGCnwC31AVW01RYJbkIdItxmGzgELgriMPfyvsqlWzAVKwpXL4RyQ1faC8c9lYJhA==
X-Received: by 2002:a05:600c:6029:b0:3db:2922:2b99 with SMTP id az41-20020a05600c602900b003db29222b99mr5233661wmb.4.1674597831102;
        Tue, 24 Jan 2023 14:03:51 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003daf7721bb3sm38892wmi.12.2023.01.24.14.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:03:50 -0800 (PST)
Date:   Tue, 24 Jan 2023 23:03:48 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] staging: rtl8192e: Remove unused variables numqry_..
Message-ID: <fd9e175bfb8773a8c3236dacc8b3327dcb0198e7.1674596722.git.philipp.g.hortmann@gmail.com>
References: <cover.1674596722.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674596722.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

numqry_phystatus, numqry_phystatusCCK and numqry_phystatusHT are
initialized and increased but never read. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 4 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index c5ebc33dc7f1..31b4823e6324 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1308,8 +1308,6 @@ static void _rtl92e_query_rxphystatus(
 	static	u8 check_reg824;
 	static	u32 reg824_bit9;
 
-	priv->stats.numqry_phystatus++;
-
 	is_cck_rate = rx_hal_is_cck_rate(pdrvinfo);
 	memset(precord_stats, 0, sizeof(struct rtllib_rx_stats));
 	pstats->bPacketMatchBSSID = precord_stats->bPacketMatchBSSID =
@@ -1341,7 +1339,6 @@ static void _rtl92e_query_rxphystatus(
 	if (is_cck_rate) {
 		u8 report;
 
-		priv->stats.numqry_phystatusCCK++;
 		if (!reg824_bit9) {
 			report = pcck_buf->cck_agc_rpt & 0xc0;
 			report >>= 6;
@@ -1416,7 +1413,6 @@ static void _rtl92e_query_rxphystatus(
 			precord_stats->RxMIMOSignalQuality[1] = -1;
 		}
 	} else {
-		priv->stats.numqry_phystatusHT++;
 		for (i = RF90_PATH_A; i < RF90_PATH_MAX; i++) {
 			if (priv->brfpath_rxenable[i])
 				rf_rx_num++;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 70767238e721..e38de4d8a467 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -185,9 +185,6 @@ enum reset_type {
 struct rt_stats {
 	unsigned long received_rate_histogram[4][32];
 	unsigned long num_process_phyinfo;
-	unsigned long numqry_phystatus;
-	unsigned long numqry_phystatusCCK;
-	unsigned long numqry_phystatusHT;
 	unsigned long received_bwtype[5];
 	unsigned long rxoverflow;
 	unsigned long rxint;
-- 
2.39.1

