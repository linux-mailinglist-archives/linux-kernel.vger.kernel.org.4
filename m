Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7361B67A555
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjAXWEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjAXWEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:04:22 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7208750851
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:04:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j17so12529991wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPkDVI+kwbAJ93P/3HO1c8dYxoMR9aHUJQ6dLWT3TnA=;
        b=imbFKXgalkTRtXQTXS9Fs4SMJ1hEqVH6EWLyRtnqTVPrlhpWUUQ1u4lfEQ4WKeXpPF
         NyjTcCzs9Ox6xMslre3S/woYwiqj4nzNXgFcgXHGS63XDCuz+pkXpIxpDB5BdePrk26R
         bJMRM5w+gm/wyhyckDP+PRIzNmeLuIgKqLzfePKkhQWY7303AiOnNMnDtVgFi6bjEtur
         25Urg82ec+AXJwjUti5PmgvdBnsmRMc+hbDyJ4VFolTl6kJsBe1L9v3BqXOGxfmaTQyY
         Viiihktwgv/i6Ri9C02RyJ4SoDUcdb0lybTR+y7912gAGTeXk15k5Xdn28jO2dXD++QO
         Pg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPkDVI+kwbAJ93P/3HO1c8dYxoMR9aHUJQ6dLWT3TnA=;
        b=MAytn+inK05tAUO16HZb68r9+JjfN4fj+WBedNMKnUgWcUUuft84z4Ha+LBpPI8/4j
         +q/wM0D8orj/3k1zS5zYVTL7Qm/cjBOdRxUVH5j+WE4lF+kydSo042wXB6aOLISg+jPa
         Dkc4GKhjqrxVqnayY1IyFWl50ppbHEnRWcqNmyGU2r1qsyCXkgRveF0CnQ6Tu9X+kDvU
         PfX+3JtdJBixOGYNiY0LzTeTcln1x28y3ouQHNQynGUOqTuy760opM1p57m9+XF5l7f1
         HplFQFM026mMmB/1DxLdKrR49YPKK9pCR/TW2igywkAGJmzxx0zi/RID9mF2z/IauilP
         rAhA==
X-Gm-Message-State: AFqh2krI7BCbyNaqSvfST4MWpDGYYRNnCcDE3StRqEWs0Gbfzq1rqJXP
        XDxYjuNBjfL3ei1kBb7BJO04cYdhYV4=
X-Google-Smtp-Source: AMrXdXvifvtEy3l/deRUmlTDNE1EmkSy5kS6GOnOYrhxNI5ZESiX/7mH7on8/PebqJynRwcVj74+Vw==
X-Received: by 2002:a05:600c:5120:b0:3db:21b8:5f53 with SMTP id o32-20020a05600c512000b003db21b85f53mr5582344wms.1.1674597846842;
        Tue, 24 Jan 2023 14:04:06 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id p15-20020a5d4e0f000000b002bdc39849d1sm2791366wrt.44.2023.01.24.14.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:04:06 -0800 (PST)
Date:   Tue, 24 Jan 2023 23:04:04 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] staging: rtl8192e: Remove unused variables rxint, ints
 and shints
Message-ID: <1ddfe407a0b93f991466ecba71741c5025fb6352.1674596722.git.philipp.g.hortmann@gmail.com>
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

rxint, ints and shints are initialized and increased but never read.
Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 7 +------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 3 ---
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index c5fe8e0aa83f..ff9dc06642f6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -2123,7 +2123,6 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 	spin_lock_irqsave(&priv->irq_th_lock, flags);
 
 	priv->ops->interrupt_recognized(dev, &inta, &intb);
-	priv->stats.shints++;
 
 	if (!inta) {
 		spin_unlock_irqrestore(&priv->irq_th_lock, flags);
@@ -2135,8 +2134,6 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 		goto done;
 	}
 
-	priv->stats.ints++;
-
 	if (!netif_running(dev)) {
 		spin_unlock_irqrestore(&priv->irq_th_lock, flags);
 		goto done;
@@ -2169,10 +2166,8 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 	if (inta & IMR_HIGHDOK)
 		_rtl92e_tx_isr(dev, HIGH_QUEUE);
 
-	if (inta & IMR_ROK) {
-		priv->stats.rxint++;
+	if (inta & IMR_ROK)
 		tasklet_schedule(&priv->irq_rx_tasklet);
-	}
 
 	if (inta & IMR_BcnInt)
 		tasklet_schedule(&priv->irq_prepare_beacon_tasklet);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index bb942283bc7a..2d1561a202d0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -184,9 +184,6 @@ enum reset_type {
 
 struct rt_stats {
 	unsigned long received_rate_histogram[4][32];
-	unsigned long rxint;
-	unsigned long ints;
-	unsigned long shints;
 	unsigned long txoverflow;
 	unsigned long txbeokint;
 	unsigned long txbkokint;
-- 
2.39.1

