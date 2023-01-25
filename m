Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED6867BC38
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjAYUJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjAYUJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:09:25 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311AA5AA6C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:08:58 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n7so18198717wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPD0oaXUwE0lhRDbVVND/Kc9WuyherZicOM8X1Re1go=;
        b=K8kyMHybsveElrrjOMCBIF0OmQ6Cuk81brwhY/J2sem7mqToCmCMWnjIDmzlKn3fc9
         YUeFpufUdO9fqNX6X9w49EXMt7uFYiYNoR7lTVo38g5V1i/tHc0ScDYzdADVnv0GcJRi
         1BW/9tnZDvj2pJo8APvz+AVFEjcB6qTm19hYpW5n3qFA3YHAnH/l+Vps0Tz/VaHzwuQf
         zWDewvbG0/6v2JS9YlrepfYSJACNlnhLv8l6fAQYW7F+ynPAp+ZaiWrCTqoPQw2jvfSU
         ccdJ4Q9mdbZuLOmYm3+gNQqtAtNjxcqzGISR9j4RE/16mv753HdBVPSFMnd9m98s5rIR
         Nkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPD0oaXUwE0lhRDbVVND/Kc9WuyherZicOM8X1Re1go=;
        b=uTURWo8vfyiJAk3eJBKL0M4i7F2nMkH+/BjDzbFz0VWcLcnCBYYvwauZjl+cZyGVan
         2PyLH45B2OQVdd5/JLkPaWlKBA9gO9Q9x6pDSem14+BZL3Ul3/lvk/v/g+FWD0boaavE
         NiGsalQDJomaTOQWckX6y03c60DCJJ5fHL3qsgxTyAB0LrO7B2LaJaEXghg7Z77BjQMZ
         2vswxTY/++F4dtMHNfcakXF+N6mDh8YdGfnF2vsPYgYv5GOOsorppiQV9ktnowqpyzrm
         RnlyuwsJyuQq14LI4nO2PpKRZzYPQ9u0X4BCTa0MHBAfT9JiM7zHIPz6a0M4kJjg/OW+
         pmVA==
X-Gm-Message-State: AFqh2kqKKHynXmZNgWit2tIEKe7xPPOu7Pyj3HBA5SJrLZei0KvAWB6V
        okRhRWjI5cBCm4ZAbYOcPAN2QsCJ9og=
X-Google-Smtp-Source: AMrXdXtKEG+Hod7P339+LXhVmkjTjcFe4V/KC1S+eyYlY5WEYAOeXBhwq1suHOKgCHufExkr580gHg==
X-Received: by 2002:adf:fa4e:0:b0:2bd:e8bd:79c7 with SMTP id y14-20020adffa4e000000b002bde8bd79c7mr5281596wrr.1.1674677335888;
        Wed, 25 Jan 2023 12:08:55 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d4205000000b002bdbead763csm5218018wrq.95.2023.01.25.12.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:08:55 -0800 (PST)
Date:   Wed, 25 Jan 2023 21:08:53 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] staging: rtl8192e: Remove unused variables numqry_..
Message-ID: <20aedc3bd3cc860ee8d86d205461f479ac201fea.1674675808.git.philipp.g.hortmann@gmail.com>
References: <cover.1674675808.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674675808.git.philipp.g.hortmann@gmail.com>
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
index b4651cea07a1..f62547e54261 100644
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

