Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2267BC40
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjAYUKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbjAYUJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:09:39 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B725A376
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:09:18 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z5so18206579wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u9KDPpjVKPB5sOQxBI2Abbi3wGikXqFCKNDvpCWP0FU=;
        b=CJFpdB0XCRJu3gIwSZp3Ta9DCtU3V8aBi+GOaExYHwIoDybhpUjd07TFRsBrbfFSls
         cuCjw6ZWTrV27iC4ZrADnl9lkOmpsM5WeWRWbJDunQFFKeMmGxb2nkVk9mWlL0bljWWx
         FpbtRX1WwJIGOhV35G9JYf9PIMnsMdcBDF3K7q/389ocJiNVWVZ4Ixvvpnu6BaHe2L1A
         vEnD52xDd90V6q9OjGadaV6ub8pJEP19PZtySlMi/E+by37M2f1cWqVAadtHbx1MQSYA
         0xk/7P6Gbk1XKQHldjM3GbJlJsB9qSaNthc0OPRs9A+z7DcQnA735sZ9uPliKohtWITZ
         8K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9KDPpjVKPB5sOQxBI2Abbi3wGikXqFCKNDvpCWP0FU=;
        b=SwvY1SgQVdh1wUoePuWCOdOoAssJdD9C+GtoExieY0hDibL0t8RwrnQolc2NvEtlzF
         EgjQVZBtkjf8xdEKb8PsPAStcle5esXOspcZw8xxbe93FLAo4hkAjxbcHtS+XLnutC0i
         Bt5Zbndw4IL7L3zgh7NVFzWXRsJP072Rp8MtMuAIRNWi1Xf/AjqgJSmde3QEGHRQMBmb
         CVeBpYAsp2aEKC73bBe/cPYjSUUmZK1/sOx7HWIqmhS1umlgvaV5AierYPTbhQodocv2
         aVV6pYle8nEmfaxnAmQsI/kMiCZUwJBl0d8H+q3QsJ+CteVU1Iw/z7rILA4uuUXad1JM
         o6Pg==
X-Gm-Message-State: AFqh2krFYgsplTmXVeq5ioNX1iAFPF2tX8k9dXFeEKRanjbNGhmoCg/E
        ep1KNAL30pL4DzmjXMlR5kq5AyXNzeE=
X-Google-Smtp-Source: AMrXdXtH7lBqibmwThD1nA1HAiRVvadzNEpssJMoEV8806t/XJLHi+OsNhMCij1fobz8/UIp6cNVYw==
X-Received: by 2002:adf:fd0f:0:b0:2be:4639:ee27 with SMTP id e15-20020adffd0f000000b002be4639ee27mr3835467wrr.1.1674677356684;
        Wed, 25 Jan 2023 12:09:16 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id r13-20020adfdc8d000000b002bfb5bda59asm3288112wrj.25.2023.01.25.12.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:09:16 -0800 (PST)
Date:   Wed, 25 Jan 2023 21:09:14 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] staging: rtl8192e: Remove unused variables txov..,
 txbeokint and txbkokint
Message-ID: <023f612dc35eca3a74c31344f7dbb168180bf437.1674675808.git.philipp.g.hortmann@gmail.com>
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

txoverflow, txbeokint and txbkokint are initialized and increased but
never read. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 5 -----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index ff9dc06642f6..768324cbe253 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -2181,17 +2181,12 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 	if (inta & IMR_RXFOVW)
 		tasklet_schedule(&priv->irq_rx_tasklet);
 
-	if (inta & IMR_TXFOVW)
-		priv->stats.txoverflow++;
-
 	if (inta & IMR_BKDOK) {
-		priv->stats.txbkokint++;
 		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, BK_QUEUE);
 	}
 
 	if (inta & IMR_BEDOK) {
-		priv->stats.txbeokint++;
 		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, BE_QUEUE);
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 2d1561a202d0..96d340f686e9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -184,9 +184,6 @@ enum reset_type {
 
 struct rt_stats {
 	unsigned long received_rate_histogram[4][32];
-	unsigned long txoverflow;
-	unsigned long txbeokint;
-	unsigned long txbkokint;
 	unsigned long txviokint;
 	unsigned long txvookint;
 	unsigned long txbeaconokint;
-- 
2.39.1

