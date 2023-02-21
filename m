Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53C069E927
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBUUxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjBUUxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:53:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90325305C2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:53:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id da10so23601498edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHR3bAPWRzNH3uceXibtG9TZoHwCI92GdhICVcRGuxc=;
        b=cujsHR2biF4mJAv32C6CIgyZzTh5zaWy4Y7EC7P7uy0efNh8aeb/mAc+jzPLmGauFE
         lWsggM0e5S2xGfKqFgwRAWLXVymontTf+C/nyZsZYQQaxt/NIGxc7LHoY2/ZKUs/Gn4q
         lMUMXiZwb+P73W9BTepfzxgAkscsiY2QFJxA9qi58DOdhtXeckdlMmmL+W/O/twK5kia
         DkAKO+nYeeLG790bZnmiScjRD62b3gtbKajvg/eUfn9qKClTu+GzN/FLXsD8LmAVrtH8
         EdXmTorTBROTKmh+/e963lGMnTKcSg2WM4E3ltSIIPjad5qHSSAc/MYJI0zp2iRdWfRl
         0nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHR3bAPWRzNH3uceXibtG9TZoHwCI92GdhICVcRGuxc=;
        b=3Xy3iUTr7hSqe1+U0hqsL3vwRy5LJOPfI6p8o3YKi/XFMppAPIJCdA3xZ510Xnv6uv
         t3PBZEW5U8qw82XhXXFQWcm1CIQIJCkV+dmeHp7gemayPFymQjFCzgGGSh3yh7UWP1Zt
         SnB7VTwMpCuGentEIWO8T7xbGazZG13w3eonF/K+9gdvMN0iBSUJZDNvz0i+vD4lZWQ5
         TGg116rnw9+PyCwL1Enw3i8dqfJ+FB3Y+Ls7onAJ4lIBgCLRUdkXZDmbTBWjofT1jq8U
         lIz5UBSAS89KgI0RrXYskIILrWXFVU0tRZ7fDhLoYc73Ao3ON2oqzUWG9HTcqjnFBDnH
         dy+w==
X-Gm-Message-State: AO0yUKUPH0xnDym22Yu+p5UOte3ND+83zGFLTOLan4YJYrH3eOjOgS32
        eC0BUB1Hi7UGEimNkptfMTo=
X-Google-Smtp-Source: AK7set9LVCJ2MJfL0Hw4KezNFy2ugWPQLpB9o9oMcCJvFTifgWIjIZPISLlfR92PtrsQqaEX06ZSPA==
X-Received: by 2002:a05:6402:34d5:b0:4ab:dde:dea7 with SMTP id w21-20020a05640234d500b004ab0ddedea7mr6024923edc.2.1677012786030;
        Tue, 21 Feb 2023 12:53:06 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id l13-20020a1709066b8d00b008cdb0628991sm3580334ejr.57.2023.02.21.12.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:53:05 -0800 (PST)
Date:   Tue, 21 Feb 2023 21:53:03 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] staging: rtl8192e: Remove entry .interrupt_re.. from
 struct rtl819x_ops
Message-ID: <a972ff8963b426f20651810b5161c8759ffa2d05.1677010997.git.philipp.g.hortmann@gmail.com>
References: <cover.1677010997.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677010997.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove entry .interrupt_recognized and replace it with function name
rtl92e_ack_irq. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f1cde3fc8634..3323bdf564ee 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -30,7 +30,6 @@ static const struct rtl819x_ops rtl819xp_ops = {
 	.link_change			= rtl92e_link_change,
 	.rx_command_packet_handler = NULL,
 	.irq_clear			= rtl92e_clear_irq,
-	.interrupt_recognized		= rtl92e_ack_irq,
 	.tx_check_stuck_handler	= rtl92e_is_tx_stuck,
 	.rx_check_stuck_handler	= rtl92e_is_rx_stuck,
 };
@@ -2103,7 +2102,7 @@ static irqreturn_t _rtl92e_irq(int irq, void *netdev)
 
 	spin_lock_irqsave(&priv->irq_th_lock, flags);
 
-	priv->ops->interrupt_recognized(dev, &inta, &intb);
+	rtl92e_ack_irq(dev, &inta, &intb);
 
 	if (!inta) {
 		spin_unlock_irqrestore(&priv->irq_th_lock, flags);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 79281c077182..d3558bf6ce23 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -211,8 +211,6 @@ struct rtl819x_ops {
 					  struct sk_buff *skb,
 					  struct rx_desc *pdesc);
 	void (*irq_clear)(struct net_device *dev);
-	void (*interrupt_recognized)(struct net_device *dev,
-				     u32 *p_inta, u32 *p_intb);
 	bool (*tx_check_stuck_handler)(struct net_device *dev);
 	bool (*rx_check_stuck_handler)(struct net_device *dev);
 };
-- 
2.39.2

