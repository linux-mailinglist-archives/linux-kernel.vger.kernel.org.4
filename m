Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B214E67BC3F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbjAYUJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbjAYUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:09:37 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B705D907
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:09:10 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n7so18199241wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPkDVI+kwbAJ93P/3HO1c8dYxoMR9aHUJQ6dLWT3TnA=;
        b=nFNa9GQFJ8A+X4cryDepHdIoycHcC97q53wLw55WoPYQQILEGPqNqavlMFUx8NYeSQ
         3rQA78vczlT3E67SuKvBhVztNJXiWtAX5u9LvK3WUbN/w0roPt6td5QfWsFLTDY78tYI
         r+XmPa8ztUM6fMeYtgvkPOlO5EvUO/Duoyy4cc132pBbAgw6O+wmvcK0iVIDtr+gOcog
         ida/56erXAFgSQmpBzxep8eQ4j5bul1F4EV70iBTZWWinG/CO2tEdHPMeHnehWCNq0t4
         Ra2wLE/yjWdHfXaMlERJ0hX/NUugFMYMKAnZRBErnq7a3xa4bK2WGCdQ50yX9+OfNA4e
         O0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPkDVI+kwbAJ93P/3HO1c8dYxoMR9aHUJQ6dLWT3TnA=;
        b=NSNdeYBHd0waqbq2O19qZunmb8WUyCA40I+LaqYiQXblblXPLDF5Pb8GEO3jEBxKZa
         3e8LrcuoDc8/jAuEkT8NTmweH3PUvfj3UiKxg5dAUXxMmNIqE2px6rh9EDlH3pxAzfpL
         jDPFlP48UWDlC1ouKTwDHaVKbND4q4CuPkmEIdvifXIrWo7a/cFDoGOaNAUtxwZn8Ac2
         6VT38hN8fN/SVbTWLnEo5YU0uD6+8ZrtPy+oqdzRoDMFuC/FicaHN0LRUvcAeafRDsq0
         UcOTJ/sVrwtUkTJBiyIfBgp4dUNhXchVJeuCzRlSz9Xh1kopWCU3nozBMktKjgRtHMYU
         OCZQ==
X-Gm-Message-State: AFqh2krLhI3iUvIS31qylAsFi8T+eS4I894XD31e+yDM7uoMDAWQyGyC
        DC2QcW0aQvJj/PyaGtVy2k/vNGqV25g=
X-Google-Smtp-Source: AMrXdXuuDPM7/KXGtoSE1pkM7BeCpSWKMaxKX46SFnwLrs1/YM/M7poDu8pTStktfCpl4ld0LgG4sQ==
X-Received: by 2002:a05:6000:69d:b0:2be:184:8af6 with SMTP id bo29-20020a056000069d00b002be01848af6mr6524766wrb.0.1674677348695;
        Wed, 25 Jan 2023 12:09:08 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b002366e3f1497sm5248458wrq.6.2023.01.25.12.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:09:08 -0800 (PST)
Date:   Wed, 25 Jan 2023 21:09:06 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] staging: rtl8192e: Remove unused variables rxint,
 ints and shints
Message-ID: <ee6ee009d139a3da3d2c171d7ac6454271b4da9b.1674675808.git.philipp.g.hortmann@gmail.com>
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

