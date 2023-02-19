Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBD469C2A4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjBSVQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjBSVQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:16:09 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0433199E0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:15:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id fd2so4399351edb.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676841355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjjWJfxbsqn6gyfLTHs1w3kGrQ+J6hwOQ7AqbciTCCg=;
        b=XyNxU/u1C28TR7N2u8CLt4P3JlztWLoYHs2eQZG2zcwlNAfYebV+Sw7ji8BxliZ/Xj
         yB9ZsktPVh/pR3BMXxDjuBmz3BlMClDdiPfW3eMLZlQyoKXMTQWbfyj4KPbWSZw7vnrt
         T/FXvyuT4meqWUnPJapFvOWTtFvrGlu2iUHLW+TSlqPnmvOf3S0nQy5+69cyFqF8w6Us
         nMPOpdMWT8UxZEqtT0gKOt1L5O0TBpFwgd14kF+a8nrxDhHZ7aFK7AveH/DEgQ/TK0k+
         2rWSaQyYfGgL78qA+e52VkZ4d77fi1qELdO6RX0Vuz3ir4EOv+z7wTkw025EqYgeFVVV
         IvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676841355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjjWJfxbsqn6gyfLTHs1w3kGrQ+J6hwOQ7AqbciTCCg=;
        b=z/DOIkfX6L2jp04k9HMutTC1klo1AU8ohFgPvf8k6BHxnO84WvzghuVd86+rOPfwNI
         QuzEnQKtYks2eh9jS6KDSEM9WZdAnKyiZpkpVF2JvTd8CzIt1WDbK5k32XPWWaCwFNez
         yryi4TkXQ4gYXCNWVKTA7C5CZrkBq7rFPjb9Kh+9++UyWvHmOWg/GfDZmUNzZ4d9NpLR
         kPmOAzQpecEO3xKvw5VsQ+pgoOusHwwpICTPnGhn7lIgVegWTiVbzjQXakwnsr1d0tKo
         awb2Jc9J/P8z9QBH4e263REQ4o8V8iC1/WA6VxD58017JO/frXy6Gg6MUqixNjtJ8a4G
         X8/g==
X-Gm-Message-State: AO0yUKVapfjRmTZHZ2CGaJm5n04Pa36//hiIM929MxyPyjUyB/wZoOqM
        w0+9sF7MRUOmyJhCtSBzetg=
X-Google-Smtp-Source: AK7set9SvehXBcrEpoyGfQKTNjPGQESa91OB0Y+u65s42bvmW77t1O35tpE28ZZjQ35AtBRD5KKezA==
X-Received: by 2002:a17:906:51d8:b0:8ae:cd8e:3957 with SMTP id v24-20020a17090651d800b008aecd8e3957mr5745457ejk.4.1676841355330;
        Sun, 19 Feb 2023 13:15:55 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id o23-20020a17090637d700b008c5075f5331sm1801552ejc.165.2023.02.19.13.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 13:15:54 -0800 (PST)
Date:   Sun, 19 Feb 2023 22:15:52 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] staging: rtl8192e: Remove entry .tx_fill_descr.. from
 struct rtl819x_ops
Message-ID: <1ae7d44ef74dc6cb61ff43f670b21d702403d7fb.1676840647.git.philipp.g.hortmann@gmail.com>
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

Remove entry .tx_fill_descriptor and replace it with function name
rtl92e_fill_tx_desc. This increases readability of the code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 5 ++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 4 ----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 3bebc1153572..dd1f4a3c4bf9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -28,7 +28,6 @@ static char *ifname = "wlan%d";
 static const struct rtl819x_ops rtl819xp_ops = {
 	.nic_type			= NIC_8192E,
 	.link_change			= rtl92e_link_change,
-	.tx_fill_descriptor		= rtl92e_fill_tx_desc,
 	.tx_fill_cmd_descriptor		= rtl92e_fill_tx_cmd_desc,
 	.rx_query_status_descriptor	= rtl92e_get_rx_stats,
 	.rx_command_packet_handler = NULL,
@@ -496,7 +495,7 @@ static void _rtl92e_prepare_beacon(struct tasklet_struct *t)
 	skb_push(pnewskb, priv->rtllib->tx_headroom);
 
 	pdesc = &ring->desc[0];
-	priv->ops->tx_fill_descriptor(dev, pdesc, tcb_desc, pnewskb);
+	rtl92e_fill_tx_desc(dev, pdesc, tcb_desc, pnewskb);
 	__skb_queue_tail(&ring->queue, pnewskb);
 	pdesc->OWN = 1;
 }
@@ -1637,7 +1636,7 @@ static short _rtl92e_tx(struct net_device *dev, struct sk_buff *skb)
 		if (priv->rtllib->LedControlHandler)
 			priv->rtllib->LedControlHandler(dev, LED_CTL_TX);
 	}
-	priv->ops->tx_fill_descriptor(dev, pdesc, tcb_desc, skb);
+	rtl92e_fill_tx_desc(dev, pdesc, tcb_desc, skb);
 	__skb_queue_tail(&ring->queue, skb);
 	pdesc->OWN = 1;
 	spin_unlock_irqrestore(&priv->irq_th_lock, flags);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 9edadc62faa9..0d4ae3a310da 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -207,10 +207,6 @@ struct rtl819x_ops {
 	enum nic_t nic_type;
 	void (*init_before_adapter_start)(struct net_device *dev);
 	void (*link_change)(struct net_device *dev);
-	void (*tx_fill_descriptor)(struct net_device *dev,
-				   struct tx_desc *tx_desc,
-				   struct cb_desc *cb_desc,
-				   struct sk_buff *skb);
 	void (*tx_fill_cmd_descriptor)(struct net_device *dev,
 				       struct tx_desc_cmd *entry,
 				       struct cb_desc *cb_desc,
-- 
2.39.2

