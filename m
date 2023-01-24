Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1867A54E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjAXWDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjAXWDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:03:18 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D490C30E96
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:03:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so15259277wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3QUDM7lOv5vhtcSI90OpPSN2/l5dUarb+bY6Rv4FS0=;
        b=HnDQ8jcUqzklYtZ+03sHwmyFK6XwULAk90aX9K8vKRZmzTSzBSE+x5U9WJUQ/2ZMiw
         5WJx8nGlSFG2PmE+vjWUNeWoaJ9PEX9JZCRSuTCWKjIrS6jWn0/6xXZR3Zve4GhWrkgw
         VtZ1HdZxdEFE58L+Y/ohnStgDkf1/Cw9aa0wq8F7rXCprFFhPUxPkNprBf09rSikdYjd
         47lB4MR8ZiZcyCBMvaynOXwckJ59EWSeFzrWegWYI263Y859xrv4Ft1w5Boois8daGpz
         87BmOatXXFM1w0iLc3E1wjcKQwQTeap/iQd3xoGEpcz3i33hFIwInjllbVUsE3OD70pL
         /N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3QUDM7lOv5vhtcSI90OpPSN2/l5dUarb+bY6Rv4FS0=;
        b=tcK+KCLUulLbPvj0ox1qbZFvIFRhbSZSeWwawedZR0idGUTWFuvQdnt4ImGvH+c6lE
         3ujsU/4f87KQN6Q0KfibSD/XQ0lFVy942WWf7/BmLgqfvFVKxM2Rdqm7qraxxDverOud
         U07O+3PJ9L8Iz0vAUSfVK+fySyqNKVfqZbBAC7w2QM4exza5d2rgoqPQxIh6cT6nqcgT
         JaX1ZdIT2wNsenM7upFay2bi2poHR7Lg2FdcLJRVrOCkugd23TRaPRS844phJyaKtvYY
         yq9YKXAAkSTq/IBtJdkkanLV8GGnvuRWHFNnzKELasw6VE7+558KHRdEbddx9vr6deYj
         gwxQ==
X-Gm-Message-State: AO0yUKVR/LBbMv1WxVGS6rET/olveoVr34NlMyiMnjfDr0+Ju750jHfR
        1Zljk6j0KbwfaOp4cF34wSc=
X-Google-Smtp-Source: AK7set+Cr6heynZXLavpDc+Ia+seioc9hbM7lP1X3/fJLtZQZLJjHAqPoGInE80nkbLJs5ni7ZPJFg==
X-Received: by 2002:adf:a492:0:b0:2bf:b9b1:9568 with SMTP id g18-20020adfa492000000b002bfb9b19568mr3649wrb.2.1674597793145;
        Tue, 24 Jan 2023 14:03:13 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id r4-20020a5d4e44000000b0027cb20605e3sm2814715wrt.105.2023.01.24.14.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:03:12 -0800 (PST)
Date:   Tue, 24 Jan 2023 23:03:10 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] staging: rtl8192e: Remove unused variables rxrdu and
 rxok
Message-ID: <20738d339066e36f5347c7e5011bd3d1aa3e4f53.1674596722.git.philipp.g.hortmann@gmail.com>
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

rxrdu and rxok are initialized and increased but never read. Remove dead
code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 80450d46191c..605146c840c7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1938,7 +1938,6 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 		if (!rtllib_rx(priv->rtllib, skb, &stats)) {
 			dev_kfree_skb_any(skb);
 		} else {
-			priv->stats.rxok++;
 			if (unicast_packet)
 				priv->stats.rxbytesunicast += skb_len;
 		}
@@ -2186,7 +2185,6 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 		tasklet_schedule(&priv->irq_prepare_beacon_tasklet);
 
 	if (inta & IMR_RDU) {
-		priv->stats.rxrdu++;
 		rtl92e_writel(dev, INTA_MASK,
 			      rtl92e_readl(dev, INTA_MASK) & ~IMR_RDU);
 		tasklet_schedule(&priv->irq_rx_tasklet);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 983bc663a570..82cbc7f5536a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -183,8 +183,6 @@ enum reset_type {
 };
 
 struct rt_stats {
-	unsigned long rxrdu;
-	unsigned long rxok;
 	unsigned long rxdatacrcerr;
 	unsigned long rxmgmtcrcerr;
 	unsigned long rxcrcerrmin;
-- 
2.39.1

