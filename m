Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5514867A557
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjAXWEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjAXWEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:04:50 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9213E51C7F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:04:27 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so38968wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u9KDPpjVKPB5sOQxBI2Abbi3wGikXqFCKNDvpCWP0FU=;
        b=V+OeiocRchdGib1s/15ba9Yh9kWOa/t6CczrE/IdZOPu/1PrCug4laVgpF+HwPlDWV
         VHn3u8bqvjBFwLtVoQeSpp91Z1PQrmoWgR1cea4FKAbINUtR+raHEXJB7lQDNZCtZJQt
         lIg6A50sfFwfeLIeYU2YZXSRC6uexu6CB6ZqGs/OWBgsYy/v38WCNCBjE78fFrkPTcW3
         TjardTD5pOArjJ9s/6xAieTfkIT/KkY207ARTpXLSsRqpL1mD5WVs/kFPXbVRkocOCno
         VlJS9uKOmBrYGWqgpgZPjMsd0AHB7fXSRn6zS4aLdlXbwFhZx767lKJHrkhJnmXR5jw1
         x/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9KDPpjVKPB5sOQxBI2Abbi3wGikXqFCKNDvpCWP0FU=;
        b=lzqImHn4WcW6AmHA80ZZ/AUZOkOXMgpVvDuP9XZrzYnIAdeO+JqaJp948orsi5nI4R
         YM+UhcBB+EJZu52G+8VHRwH+ioyOkc8BE3HhaJNF5C9cn5a/8zoXARTLPK/wlUzDckvY
         u/mpwbmcNu09B6mSgM5xvHV8h9804ioF3RQF80um5X+n9uVAaA3Qrj8vU16953yBwvSS
         U2juQ819UDxfsUWLf850QGMaciqsYpL9zEo31jLfi3V+uFXh7OyUI4tmH/yOirNQt1+F
         FChwKvbTT/tW1nijJlYN7OEzmDzvTshJe7Ti30iCTvYTaaRFOm1tIkPLQnWyyKFObAYd
         wnfQ==
X-Gm-Message-State: AFqh2koXafVPbfOx8p2VtknxOwcPtw/tq/0iUYgdU90HtKd94OAKF2JB
        lrViBWwWVDfYWGjWYL4u7lY=
X-Google-Smtp-Source: AMrXdXtH3CdSB3oUOj5iEag4fJDjpIu96ar2OFRhQagghXHtwgjdNkqiWHJXRLtfkN85CuIYZdK6kg==
X-Received: by 2002:a05:600c:1e22:b0:3db:2063:425e with SMTP id ay34-20020a05600c1e2200b003db2063425emr5573938wmb.1.1674597863634;
        Tue, 24 Jan 2023 14:04:23 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id f5-20020a05600c44c500b003d1de805de5sm42022wmo.16.2023.01.24.14.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:04:22 -0800 (PST)
Date:   Tue, 24 Jan 2023 23:04:20 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] staging: rtl8192e: Remove unused variables txov..,
 txbeokint and txbkokint
Message-ID: <9ded1e4c43c87faef908df1d4aa564d0ba00e1a3.1674596722.git.philipp.g.hortmann@gmail.com>
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

