Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF42467BC44
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbjAYUKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbjAYUJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:09:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03425D911
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:09:25 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso2134967wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMf09+fC4QI99DmXPRyQuRL+tFfoSe44zXEcxxr3d1Q=;
        b=pfhjKcsDMG0B6iYPy1uEpIfPgWWhr2EgYByXnBIKOjyeXxqKfvfk/XevDGkyN8CCTG
         16TteLtHyrNqg3yu6p5xze1CVd3TY/TGKo4DSghVvYHCArXdJMQuu9mWRoiXXtqsDrn6
         ohxv+G5zIn7LY0YrnCnNfKC83qiVIMcpYA6uuxogHZ/jcOlBJFYmV7lCe+sNR1dyCxfM
         D1VC9PZQ9SjwFKdS3uakSJVG3z4+sSJretwpGLGSJzmaQjK4ngH+YDsZUQpH3KWFAuH4
         ksYOHcqbqcEA/Bg8bBp6uAhwRgOG9y04bn4AnlgUOx/1UzZnErubqvtmvy0ZD/6R0hPr
         pSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMf09+fC4QI99DmXPRyQuRL+tFfoSe44zXEcxxr3d1Q=;
        b=EjBWDhguTHHxcKjGntGIJKAkpii2ybxurZZCYM6ZrV1QiHLgn776oqrcryn637qEQs
         f+bTLFFzTjnfgcQ/kMOOM8Z+awdQPsPYmlM+J8M+g1EYjBASJ41uS/LRk3hFQKt9J4hH
         VafOLXqCVZuZcHVnfYLCCsOKOxmqBkHRBdy/PaOEb32kWP/AaQd5vexfKomuL3J2Dz8b
         bfb3r+vmfZK4Rqsan8kh6Fck5D7IQ3XZ7CJFFz8xflRk0z34xeoLLzRxbtRXSHDqEkaU
         yHZdN8fxIwYrmpDYYE2PT7zsK2+9ucBbhlLVp7hLFV0W71rjdXwMFYdQAKiTgUri0szb
         zd3Q==
X-Gm-Message-State: AFqh2kq81iqlkLE0Ohxoa8x5Z8LFUrdMRQupD9++p6ERajQywaeFYYpD
        jYMqDL+Y6gaLMJL6GnIW44c=
X-Google-Smtp-Source: AMrXdXuRK3unvrxzTT2n3UwgPxByGkxRMh16tfnSW1GPMorniKmgRgivipCX6eq2+CH7VhJg8DoW2Q==
X-Received: by 2002:a05:600c:3ba8:b0:3d9:8635:a901 with SMTP id n40-20020a05600c3ba800b003d98635a901mr8574306wms.3.1674677362197;
        Wed, 25 Jan 2023 12:09:22 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600c329000b003d35acb0fd7sm2685430wmp.34.2023.01.25.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:09:21 -0800 (PST)
Date:   Wed, 25 Jan 2023 21:09:20 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] staging: rtl8192e: Remove unused variables
 txviok.., txvook.. and txbea..
Message-ID: <c45501eee5fbf2cc3e5ad999bbbe8e071e341a2c.1674675808.git.philipp.g.hortmann@gmail.com>
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

txviokint, txvookint and txbeaconokint are initialized and increased but
never read. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 5 -----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 768324cbe253..4cc90425fa4c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -2139,9 +2139,6 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 		goto done;
 	}
 
-	if (inta & IMR_TBDOK)
-		priv->stats.txbeaconokint++;
-
 	if (inta & IMR_TBDER)
 		priv->stats.txbeaconerr++;
 
@@ -2192,13 +2189,11 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 	}
 
 	if (inta & IMR_VIDOK) {
-		priv->stats.txviokint++;
 		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, VI_QUEUE);
 	}
 
 	if (inta & IMR_VODOK) {
-		priv->stats.txvookint++;
 		priv->rtllib->link_detect_info.NumTxOkInPeriod++;
 		_rtl92e_tx_isr(dev, VO_QUEUE);
 	}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 96d340f686e9..f8b2201ea288 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -184,9 +184,6 @@ enum reset_type {
 
 struct rt_stats {
 	unsigned long received_rate_histogram[4][32];
-	unsigned long txviokint;
-	unsigned long txvookint;
-	unsigned long txbeaconokint;
 	unsigned long txbeaconerr;
 	unsigned long txmanageokint;
 	unsigned long txcmdpktokint;
-- 
2.39.1

