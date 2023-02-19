Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D4269C2A5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjBSVQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjBSVQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:16:21 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CD119F08
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:04 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id en26so4249301edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676841362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zBGT80p9I2eT4hT6fNa+sJ1+FO2kjG3R8giy+glmW6A=;
        b=eNMpxHaBvi2z3V+dJ7Gh7RQCO8pVc1sugU2YuoqgLTYHkj3Ph68rM7Jq7QCobCvbqg
         BZ0OVochzeMUhlAqncS0gGGVnVoDO3BNwwmPoF+lX/UkhUwvj5CpmYNruMYcibt4e+r9
         o7c48X4OKjyKMdjVRYykgV9Gx27lsT8OZQKAqO+Civ2IKA0ojmG8gqQiS8K4qdct7l05
         5EFu4NE/zAGpx5N4+Q14lBZB1MGiLN5HbrDRArDFo+znaihYeDAk8nNSymRHV9p+kWny
         6gk5FYUMo054MSCpypzLEu6WNnNdXCJfSZ6LGt1QXuHIlbP9gbjvU0WvdHsFgvLWHRF/
         f3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676841362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBGT80p9I2eT4hT6fNa+sJ1+FO2kjG3R8giy+glmW6A=;
        b=E53ZQBFNIpcLdn4i/GgpwNgMStp9ByHzOgZ5ItewklEZFXtVVO+2U97QiNWsoixDDY
         9cFo/NXk0Tc1VEr9wefrutO0bR3gEZxMNRatfzGfUSUB62n32aaHbkPxmXGf3yYqiJOH
         OaNgeCKXGYngC8wy/3IilOKN6lnPerZ+agq01AR5vkqxH+XV96W36PkWajphrIiRsJR1
         jBUnSEbV261NuOyV72eXKlhLmaPHux63lLPJr4i7XkOtfgmV9GY1KoY+IGvcaSqU1GY4
         qB8rUzE0tq87ylXI1vYnqyvlbP6bcrhVE81qAszEQ6fEJuqCueH0tTo7Eb1jAoUCZNne
         xdTg==
X-Gm-Message-State: AO0yUKVE+cMBYU7srUR/LWGp59tUcx9SieTbLL60Cf7V6yoXm6xcMm1r
        J4mEhnUL2LzX/AdfOBwg5yg=
X-Google-Smtp-Source: AK7set/zmG3uNWlPSRWZBdmt8zi1usm0vjuWMNg3dCSKZ2Ka3c8GHd1DqacnPdiDbIckEGwTlnXI0w==
X-Received: by 2002:a17:906:73d2:b0:87c:c1:111 with SMTP id n18-20020a17090673d200b0087c00c10111mr5266553ejl.4.1676841362681;
        Sun, 19 Feb 2023 13:16:02 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id k26-20020a170906579a00b008b2714f4d8asm3551162ejq.181.2023.02.19.13.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 13:16:01 -0800 (PST)
Date:   Sun, 19 Feb 2023 22:16:00 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] staging: rtl8192e: Remove entry .tx_fill_cmd_d.. from
 struct rtl819x_ops
Message-ID: <713a48fcd6d56c3cc4e32aea0eeba881e0d092c5.1676840647.git.philipp.g.hortmann@gmail.com>
References: <cover.1676840647.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676840647.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove entry .tx_fill_cmd_descriptor and replace it with function name
rtl92e_fill_tx_cmd_desc. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 +--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index dd1f4a3c4bf9..372bb4810c31 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -28,7 +28,6 @@ static char *ifname = "wlan%d";
 static const struct rtl819x_ops rtl819xp_ops = {
 	.nic_type			= NIC_8192E,
 	.link_change			= rtl92e_link_change,
-	.tx_fill_cmd_descriptor		= rtl92e_fill_tx_cmd_desc,
 	.rx_query_status_descriptor	= rtl92e_get_rx_stats,
 	.rx_command_packet_handler = NULL,
 	.stop_adapter			= rtl92e_stop_adapter,
@@ -1577,7 +1576,7 @@ static void _rtl92e_tx_cmd(struct net_device *dev, struct sk_buff *skb)
 
 	tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
 
-	priv->ops->tx_fill_cmd_descriptor(dev, entry, tcb_desc, skb);
+	rtl92e_fill_tx_cmd_desc(dev, entry, tcb_desc, skb);
 
 	__skb_queue_tail(&ring->queue, skb);
 	spin_unlock_irqrestore(&priv->irq_th_lock, flags);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 0d4ae3a310da..5af14837df31 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -207,10 +207,6 @@ struct rtl819x_ops {
 	enum nic_t nic_type;
 	void (*init_before_adapter_start)(struct net_device *dev);
 	void (*link_change)(struct net_device *dev);
-	void (*tx_fill_cmd_descriptor)(struct net_device *dev,
-				       struct tx_desc_cmd *entry,
-				       struct cb_desc *cb_desc,
-				       struct sk_buff *skb);
 	bool (*rx_query_status_descriptor)(struct net_device *dev,
 					   struct rtllib_rx_stats *stats,
 					   struct rx_desc *pdesc,
-- 
2.39.2

