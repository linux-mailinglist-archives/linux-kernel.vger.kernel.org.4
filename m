Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4F8634A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiKVWqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiKVWqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:46:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1939CEB97
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:46:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id x17so13531235wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEaJLedtxp4Hd4OqGYxt+eo5FX2zcD+DeLqh0BnkZRE=;
        b=htH6hiIze2cA8azBJCi1YaJk/VDgg84GAWotqblQ09VK/wBHIlp4u3VqNiJ8ufYlIZ
         yQV6VjC42gjeBOTKRlWYofvHJubGgUOHGnHFmAKufSrIStW3Df8tnKQNQ5i3xVh3jTMs
         S6S3x5gxJn9jNSOqO7lvraQpf44qwGKunVEVOF08Flwc9u1/I6QvaYrtpluz/BP5QjHt
         Za+Mn4P+WDNEFwQS01ihYWoC5l8zpPj7/TFC1OHRmyaSWdX/JlnKRboef72xCBl4rfPj
         Xtiu1eNh2Rh2w+fXn0pDoN6FlIj9WP+EcGUHsbv6Ib2u9LEqD0gx0D/qD6B5zcz2omiF
         rcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEaJLedtxp4Hd4OqGYxt+eo5FX2zcD+DeLqh0BnkZRE=;
        b=sMdKHIbNaGt3oFDBD/wLUMhxgRI9gAuKltJzHbT7MLoDh/bWQGR74okR06iasYQ6EW
         IfZoMhPjpToLjx7ONH1wc4iVjw++5EqBDYvJUsPCFFpx3JFiDDLtq/hBGZOdl9s1IERM
         SoJkkgM+on/2LXz0DDYA/oJLf6UnXfniIT166UjIfzXyQ5VpUJcjdiZgKxKrgBQAk7Dx
         +k7g0xIG4cnU6JVJVp4Envg1mCL5sPl7TgzbGlsncS6k7mDQMbnhpZAeRxxW3cD1U0KI
         fVw2Bm6rOByKr0gtLxcsavjcUsPWLnsuHnYwC4UOrmdTjSxRRHXnRrshmoRHoEIRmkC4
         PZCA==
X-Gm-Message-State: ANoB5pmoH/lCRVOIWQCugD9nLy0KgTu1aKUCK9X6nHEQ6MrwLjUSFvwv
        Rywp+6FsdHexW8xMrSWwWnMIJi7jVHE=
X-Google-Smtp-Source: AA0mqf6wsqjCTuK+EIEbfNaR6eiboD6gYIG0Df1WvEzxJ/tgJfrjB4le2tp8RIaqluCvI3HVucqi6A==
X-Received: by 2002:adf:c64e:0:b0:236:78cd:f3d2 with SMTP id u14-20020adfc64e000000b0023678cdf3d2mr16049108wrg.719.1669157191563;
        Tue, 22 Nov 2022 14:46:31 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b003c6f8d30e40sm153935wmq.31.2022.11.22.14.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:46:31 -0800 (PST)
Date:   Tue, 22 Nov 2022 23:46:29 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: rtl8192e: Remove unused variable int_log
Message-ID: <e2edcde052cc3c47e6e6b94d09e460b8cf6a49a8.1669156825.git.philipp.g.hortmann@gmail.com>
References: <cover.1669156825.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1669156825.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

int_log is initialized and incremented but never evaluated. Remove
resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 15 ---------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   |  3 ---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   |  2 --
 3 files changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index 53fd79a28189..ac192254a4bb 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -154,21 +154,6 @@ struct tx_fwinfo_8190pci {
 
 };
 
-struct log_int_8190 {
-	u32	nIMR_COMDOK;
-	u32	nIMR_MGNTDOK;
-	u32	nIMR_HIGH;
-	u32	nIMR_VODOK;
-	u32	nIMR_VIDOK;
-	u32	nIMR_BEDOK;
-	u32	nIMR_BKDOK;
-	u32	nIMR_ROK;
-	u32	nIMR_RCOK;
-	u32	nIMR_TBDOK;
-	u32	nIMR_BDOK;
-	u32	nIMR_RXFOVW;
-};
-
 struct phy_ofdm_rx_status_rxsc_sgien_exintfflag {
 	u8			reserved:4;
 	u8			rxsc:2;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 7b78bdfadc8d..f8fbe78ccad9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -866,8 +866,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->rst_progress = RESET_TYPE_NORESET;
 	priv->force_reset = false;
 	memset(priv->rtllib->swcamtable, 0, sizeof(struct sw_cam_table) * 32);
-
-	memset(&priv->int_log, 0, sizeof(struct log_int_8190));
 	priv->rx_ctr = 0;
 	priv->rtllib->wx_set_enc = 0;
 	priv->hw_radio_off = false;
@@ -2185,7 +2183,6 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 
 	if (inta & IMR_ROK) {
 		priv->stats.rxint++;
-		priv->int_log.nIMR_ROK++;
 		tasklet_schedule(&priv->irq_rx_tasklet);
 	}
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index ca2e685148d4..cceb77492363 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -317,8 +317,6 @@ struct r8192_priv {
 
 	struct work_struct				reset_wq;
 
-	struct log_int_8190 int_log;
-
 	enum rt_customer_id CustomerID;
 
 
-- 
2.37.3

